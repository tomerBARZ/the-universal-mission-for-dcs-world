-- ====================================================================================
-- TUM.ENEMYAIRDEFENSE - HANDLES THE OPFOR AIR DEFENSE
-- ====================================================================================
-- (local) addSAMCoverage(point2)
-- (local) isPointCoveredBySAM(point2)
-- (local) createEnemyStrategicAirDefense()
-- (local) createEnemyScatteredAirDefense()
-- TUM.enemyAirDefense.onStartUp()
-- ====================================================================================

TUM.enemyAirDefense = {}

do
    local AIR_DEFENSE_RANGE = { -- in meters
        [DCSEx.enums.unitFamily.AIRDEFENSE_MANPADS] = 750,
        [DCSEx.enums.unitFamily.AIRDEFENSE_AAA_STATIC] = 1500,
        [DCSEx.enums.unitFamily.AIRDEFENSE_AAA_MOBILE] = 1500,
        [DCSEx.enums.unitFamily.AIRDEFENSE_SAM_SHORT_IR] = 6000,
        [DCSEx.enums.unitFamily.AIRDEFENSE_SAM_SHORT] = 8000,
        [DCSEx.enums.unitFamily.AIRDEFENSE_SAM_MEDIUM] = 35000,
        [DCSEx.enums.unitFamily.AIRDEFENSE_SAM_LONG] = 70000,
    }

    local airDefenseGroups = {} -- Stores info about all air defense groups (groupID, point2, range and unitFamily)

    local function getPointDefenseFamily(forceSHORAD)
        local airDefenseLevel = TUM.settings.getValue(TUM.settings.id.ENEMY_AIR_DEFENSE) - 1

        if airDefenseLevel > 1 and forceSHORAD then
            return DCSEx.enums.unitFamily.AIRDEFENSE_SAM_SHORT
        end

        if airDefenseLevel <= 1 then return DCSEx.table.getRandom({DCSEx.enums.unitFamily.AIRDEFENSE_AAA_MOBILE, DCSEx.enums.unitFamily.AIRDEFENSE_AAA_MOBILE, DCSEx.enums.unitFamily.AIRDEFENSE_SAM_SHORT_IR})
        elseif airDefenseLevel == 2 then return DCSEx.table.getRandom({DCSEx.enums.unitFamily.AIRDEFENSE_AAA_MOBILE, DCSEx.enums.unitFamily.AIRDEFENSE_AAA_MOBILE, DCSEx.enums.unitFamily.AIRDEFENSE_SAM_SHORT_IR, DCSEx.enums.unitFamily.AIRDEFENSE_SAM_SHORT})
        elseif airDefenseLevel == 3 then return DCSEx.table.getRandom({DCSEx.enums.unitFamily.AIRDEFENSE_AAA_MOBILE, DCSEx.enums.unitFamily.AIRDEFENSE_SAM_SHORT_IR, DCSEx.enums.unitFamily.AIRDEFENSE_SAM_SHORT})
        else return DCSEx.table.getRandom({DCSEx.enums.unitFamily.AIRDEFENSE_AAA_MOBILE, DCSEx.enums.unitFamily.AIRDEFENSE_SAM_SHORT_IR, DCSEx.enums.unitFamily.AIRDEFENSE_SAM_SHORT, DCSEx.enums.unitFamily.AIRDEFENSE_SAM_SHORT})
        end
    end

    local function getSkillLevel()
        local airDefenseLevel = TUM.settings.getValue(TUM.settings.id.ENEMY_AIR_DEFENSE) - 1

        if airDefenseLevel <= 1 then return "Average"
        elseif airDefenseLevel == 2 then return DCSEx.table.getRandom({"Average", "Good", "Good", "High"})
        elseif airDefenseLevel == 3 then return DCSEx.table.getRandom({"High", "Excellent"})
        else return "Excellent"
        end
    end

    local function getEnemyPointUnitsProtectingPoint(point2)
        local count = 0

        for _,adg in ipairs(airDefenseGroups) do
            if DCSEx.math.getDistance2D(adg.point2, point2) < adg.range then
                count = count + 1
            end
        end

        return count
    end

    local function addAirDefenseGroup(side, faction, unitFamily, point)
        if not point then return end

        -- Make sure no air defense unit is spawned in range of an allied player
        for _,p in ipairs(coalition.getPlayers(TUM.settings.getPlayerCoalition())) do
            if DCSEx.math.getDistance2D(point, DCSEx.math.vec3ToVec2(p:getPoint())) < AIR_DEFENSE_RANGE[unitFamily] then
                return false
            end
        end

        local units = Library.factions.getUnits(faction, unitFamily, 1)
        if not units or #units == 0 then return false end -- No valid units found

        local skill = getSkillLevel()
        if unitFamily == DCSEx.enums.unitFamily.AIRDEFENSE_MANPADS then skill = "Average" end -- MANPADS are too good in DCS, nerf them a little

        local groupInfo = DCSEx.unitGroupMaker.create(side, Group.Category.GROUND, point, units, { skill = skill })
        if not groupInfo then return false end -- Failed to create group

        local adGroup = {
            groupID = groupInfo.groupID,
            point2 = point,
            range = AIR_DEFENSE_RANGE[unitFamily],
            unitFamily = unitFamily
        }

        table.insert(airDefenseGroups, adGroup)
        return true
    end

    local function createPointAirDefense(airDefenseLevel, side, faction)
        -- Add point air defense near all objectives
        for i=1,TUM.objectives.getCount() do
            local objPoint2 = TUM.objectives.getObjective(i).point2 -- Objective location
            local desiredCount = math.random(math.floor(airDefenseLevel / 3), math.ceil(airDefenseLevel / 1.5)) -- Number of desired point air defense groups for this objective
            -- local desiredCount = math.random(math.floor(airDefenseLevel / 2), math.ceil(airDefenseLevel / 1.25)) -- Number of desired point air defense groups for this objective
            local adCount = desiredCount - getEnemyPointUnitsProtectingPoint(objPoint2) -- Number of point air defense groups already defending this objective

            local realCount = 0
            if adCount > 0 then -- Not enough groups? Create a few to reach the desired number
                for j=1,adCount do
                    local forceSHORAD = false
                    -- if j == 1 then forceSHORAD = (math.random(1, 2) == 1) end
                    if j == 1 then forceSHORAD = (math.random(1, 5) <= 2) end
                    local unitFamily = getPointDefenseFamily(forceSHORAD)
                    local point = DCSEx.math.randomPointInCircle(objPoint2, AIR_DEFENSE_RANGE[unitFamily], AIR_DEFENSE_RANGE[unitFamily] / 2, land.SurfaceType.LAND)

                    if addAirDefenseGroup(side, faction, unitFamily, point) then
                        realCount = realCount + 1
                    else
                        TUM.log("Failed to add point air defense group near objective "..TUM.objectives.getObjective(i).name..".", TUM.logger.logLevel.WARNING)
                    end
                end
            end
            TUM.log(string.format("Spawned %d air defense unit(s) near objective %s.", realCount, TUM.objectives.getObjective(i).name))
        end
    end

    local function createLocalAirDefense(airDefenseLevel, side, faction, objectivesCenter, objectivesRadius)
        -- local count = math.ceil(math.random(2, 3) * math.max(1, math.sqrt(objectivesRadius) / 200) * math.sqrt(airDefenseLevel))
        local count = math.ceil(math.random(2, 3) * math.max(1, math.sqrt(objectivesRadius) / 300) * math.sqrt(airDefenseLevel))

        if count <= 0 then return end

        local realCount = 0
        for i=1,count do
            local forceSHORAD = false
            -- if i <= math.max(1, count / 4) then forceSHORAD = true end
            if i <= math.max(1, count / 6) then forceSHORAD = true end
            local unitFamily = getPointDefenseFamily(forceSHORAD)
            local point = DCSEx.math.randomPointInCircle(objectivesCenter, objectivesRadius, 0, land.SurfaceType.LAND)

            if addAirDefenseGroup(side, faction, unitFamily, point) then
                realCount = realCount + 1
            else
                TUM.log("Failed to add local air defense group.", TUM.logger.logLevel.WARNING)
            end
        end

        TUM.log(string.format("Spawned %d air defense unit(s) around the objectives.", realCount))
    end

    local function createMANPADs(airDefenseLevel, side, faction, objectivesCenter, objectivesRadius)
        -- local count = math.ceil(math.random(2, 3) * math.max(1, math.sqrt(objectivesRadius) / 120) * math.sqrt(airDefenseLevel))
        local count = math.ceil(math.random(2, 3) * math.max(1, math.sqrt(objectivesRadius) / 250) * math.sqrt(airDefenseLevel))

        if count <= 0 then return end

        local realCount = 0
        for _=1,count do
            local point = DCSEx.math.randomPointInCircle(objectivesCenter, objectivesRadius, 0, land.SurfaceType.LAND)

            if addAirDefenseGroup(side, faction, DCSEx.enums.unitFamily.AIRDEFENSE_MANPADS, point) then
                realCount = realCount + 1
            else
                TUM.log("Failed to add local MANPADS group.", TUM.logger.logLevel.WARNING)
            end
        end

        TUM.log(string.format("Spawned %d MANPADS around the objectives.", realCount))
    end

    local function addStrategicSAMSite(side, faction, unitFamily, objectivesCenter, objectivesRadius)
        local point = DCSEx.math.randomPointInCircle(objectivesCenter, objectivesRadius)

        if point then
            local zoneCenter = TUM.territories.getRandomPointInTerritory(side, land.SurfaceType.LAND)
            if not zoneCenter then zoneCenter = TUM.territories.getRandomPointInTerritory(side) end
            if not zoneCenter then zoneCenter = DCSEx.table.getRandom(TUM.territories.getTerritoryZones(side)) end

            local vector = { x = zoneCenter.x - point.x, y = zoneCenter.y - point.y }
            vector = DCSEx.math.normalizeVec2(vector)
            local distance = math.floor(DCSEx.math.getDistance2D(zoneCenter, point) * 2)
            local step = math.min(distance / 10, 2500)

            for __=0,distance,step do
                point.x = point.x + vector.x * step
                point.y = point.y + vector.y * step

                if TUM.territories.getPointOwner(point) == side and land.getSurfaceType(point) == land.SurfaceType.LAND then
                    local distanceToObjectives = DCSEx.math.getDistance2D(objectivesCenter, point)

                    if distanceToObjectives > AIR_DEFENSE_RANGE[unitFamily] * 2 then return false end -- Went too far, no need to spawn a SAM site here, it will never engage the players and only eat up CPU

                    if distanceToObjectives > AIR_DEFENSE_RANGE[unitFamily] / 2 then
                        return addAirDefenseGroup(side, faction, unitFamily, point)
                    end
                end
            end
        end

        return false
    end

    local function createStrategicAirDefense(airDefenseLevel, side, faction, objectivesCenter, objectivesRadius)
        if airDefenseLevel <= 1 then return end

        local count = math.random(1, math.ceil(airDefenseLevel / 1.5))
        local realCount = 0
        local rerollsLeft = 5
        for i=1,count do
            local unitFamily = DCSEx.table.getRandom({DCSEx.enums.unitFamily.AIRDEFENSE_SAM_MEDIUM, DCSEx.enums.unitFamily.AIRDEFENSE_SAM_LONG})

            if addStrategicSAMSite(side, faction, unitFamily, objectivesCenter, objectivesRadius) then
                realCount = realCount + 1
            elseif rerollsLeft > 0 then -- Small chance to retry if couldn't spawn the SAM site last time
                if math.random(1, 3) == 1 then
                    i = i - 1
                    rerollsLeft = rerollsLeft - 1
                end
            end
        end
        TUM.log(string.format("Spawned %d strategic SAM(s) on enemy territory.", realCount))
    end

    function TUM.enemyAirDefense.create()
        TUM.enemyAirDefense.removeAll() -- Destroy all pre-existing air defense
        TUM.log("Creating enemy air defense...")

        if TUM.objectives.getCount() == 0 then return end -- No objectives, no air defense
        local airDefenseLevel = TUM.settings.getValue(TUM.settings.id.ENEMY_AIR_DEFENSE) - 1
        if airDefenseLevel <= 0 then return end -- No surface-to-air defense at all
        if TUM.settings.getValue(TUM.settings.id.TASKING) == DCSEx.enums.taskFamily.ANTISHIP then return end -- No ground air defense during antiship strikes

        local side = TUM.settings.getEnemyCoalition()
        local faction = TUM.settings.getEnemyFaction()
        local objectivesCenter = TUM.objectives.getCenter()
        local objectivesRadius = TUM.objectives.getRadius()

        createPointAirDefense(airDefenseLevel, side, faction) -- Must be created before the other layers, else it may think objective sites are already protected and fail to generate point defense
        createLocalAirDefense(airDefenseLevel, side, faction, objectivesCenter, objectivesRadius)
        createMANPADs(airDefenseLevel, side, faction, objectivesCenter, objectivesRadius)
        createStrategicAirDefense(airDefenseLevel, side, faction, objectivesCenter, objectivesRadius)
    end

    function TUM.enemyAirDefense.removeAll()
        if #airDefenseGroups > 0 then TUM.log("Removing all enemy air defense...") end

        for _,g in ipairs(airDefenseGroups) do
            DCSEx.world.destroyGroupByID(g.groupID)
        end

        airDefenseGroups = {}
    end
end
