-- ====================================================================================
-- TUM.AIRFORCE - HANDLES THE FRIENDLY AND ENEMY COMBAT AIR PATROL
-- ====================================================================================
-- ====================================================================================

TUM.airForce = {}

do
    local desiredUnitCount = { 4, 4 } -- Desired max number of aircraft in the air at any single time
    local fighterGroups = { {}, {} }

    local playerCenter = nil

    local function getSkillLevel(side)
        -- Friendly AI is always excellent
        if side == TUM.settings.getPlayerCoalition() then return "Excellent" end

        local airForceLevel = TUM.settings.getValue(TUM.settings.id.ENEMY_AIR_FORCE) - 1

        -- if airForceLevel <= 1 then return "Average"
        -- elseif airForceLevel == 2 then return DCSEx.table.getRandom({"Average", "Good"})
        -- elseif airForceLevel == 3 then return DCSEx.table.getRandom({"Good", "High"})
        -- else return DCSEx.table.getRandom({"High", "Excellent"})
        -- end

        if airForceLevel <= 2 then return "Average"
        elseif airForceLevel == 3 then return DCSEx.table.getRandom({"Average", "Good"})
        else return DCSEx.table.getRandom({"Good", "High", "Excellent"})
        end
    end

    local function randomizeDesiredAircraftCount(side)
        local airForceLevel = 0

        if side == TUM.settings.getPlayerCoalition() then
            if TUM.settings.getValue(TUM.settings.id.AI_CAP) == 1 then
                airForceLevel = 2
            else
                airForceLevel = 0
            end
        else
            airForceLevel = TUM.settings.getValue(TUM.settings.id.ENEMY_AIR_FORCE) - 1
        end

        if airForceLevel == 0 then
            desiredUnitCount[side] = 0
        else
            desiredUnitCount[side] = math.random(airForceLevel, math.ceil(airForceLevel * 1.5)) + 1
        end
    end

    local function getAirborneUnitCount(side)
        local count = 0

        for _,id in ipairs(fighterGroups[side]) do
            local g = DCSEx.world.getGroupByID(id)
            if g then
                count = count + g:getSize()
            end
        end

        return count
    end

    local function launchNewAircraftGroup(side, airbases)
        local groupSize = DCSEx.table.getRandom({ 1, 2, 2, 2, 2, 3, 3, 4 })
        groupSize = math.min(groupSize, desiredUnitCount[side] - getAirborneUnitCount(side))
        if groupSize <= 0 then return false end

        local faction = TUM.settings.getEnemyFaction()
        if side == TUM.settings.getPlayerCoalition() then faction = TUM.settings.getPlayerFaction() end

        local units = Library.factions.getUnits(faction, DCSEx.enums.unitFamily.PLANE_FIGHTER, groupSize, true)
        if not units or #units == 0 then return false end -- No aircraft found

        local launchAirbase = airbases[DCSEx.math.clamp(math.random(1, math.ceil(math.sqrt(#airbases))), 1, #airbases)]
        local originPt = DCSEx.math.vec3ToVec2(launchAirbase:getPoint())

        local groupInfo = DCSEx.unitGroupMaker.create(
            side, Group.Category.AIRPLANE,
            originPt, units,
            {
                moveTo = DCSEx.math.randomPointInCircle(TUM.objectives.getCenter(), TUM.objectives.getRadius(), 0),
                silenced = true,
                skill = getSkillLevel(side),
                takeOff = true,
                taskCAP = true,
                unlimitedFuel = true
            })

        if not groupInfo then return false end
        table.insert(fighterGroups[side], groupInfo.groupID)

        if side == TUM.settings.getPlayerCoalition() then
            local newUnit = nil
            local newGroup = DCSEx.world.getGroupByID(groupInfo.groupID)
            if newGroup then newUnit = newGroup:getUnit(1) end

            local callsign = "FRIENDLY CAP"
            local typeName = "Fighter aircraft"
            if newUnit then
                callsign = newUnit:getCallsign()
                typeName = Library.objectNames.get(newUnit)
            end

            TUM.radio.playForCoalition(TUM.settings.getPlayerCoalition(), "pilotNewFriendlyAircraft", { typeName, launchAirbase:getName() }, callsign)
        else
            TUM.radio.playForCoalition(TUM.settings.getPlayerCoalition(), "commandNewEnemyAircraft", { tostring(groupSize), launchAirbase:getName() }, "Command")
        end

        return true
    end

    local function updateAirForce(side)
        if desiredUnitCount[side] <= 0 then return false end -- No airforce
        if not TUM.DEBUG_MODE and #DCSEx.world.getPlayersInAir() == 0 then return false end -- No players currently in the air, don't spawn new AI aircraft (except in debug mode)

        local airbases = coalition.getAirbases(side)
        if not airbases or #airbases == 0 then return false end -- No airbases found for this coalition, nowhere to takeoff from

        local center = nil
        if side == TUM.settings.getPlayerCoalition() then
            center = playerCenter
        else
            center = TUM.objectives.getCenter()
        end
        airbases = DCSEx.dcs.getNearestObjects(center, airbases)

        local airborneUnitCount = getAirborneUnitCount(side)

        if airborneUnitCount < desiredUnitCount[side] then
            if math.random(1, 2 + math.ceil(airborneUnitCount / 2)) == 1 then
                if math.random(1, 4) then
                    randomizeDesiredAircraftCount(side)
                end

                return launchNewAircraftGroup(side, airbases)
            end
        end

        return false
    end

    ----------------------------------------------------------
    -- Called on every mission update tick (every 10-20 seconds)
    -- @param side The side for which air force must be updated
    -- @return True if something was done this tick, false otherwise
    ----------------------------------------------------------    
    function TUM.airForce.onClockTick(side)
        if TUM.mission.getStatus() == TUM.mission.status.NONE then return false end -- Not currenly in a mission
        if TUM.objectives.getCount() <= 0 then return false end -- No objectives, nothing to defend for CAP

        return updateAirForce(side)
    end

    function TUM.airForce.create()
        TUM.airForce.removeAll()
        TUM.log("Creating friendly and enemy air forces...")

        for side=1,2 do
            randomizeDesiredAircraftCount(side)
        end
    end

    function TUM.airForce.removeAll()
        if #fighterGroups[1] > 0 or #fighterGroups[2] > 0 then
            TUM.log("Removing all friendly and enemy air force...")
        end

        for side=1,2 do
            for _,id in ipairs(fighterGroups[side]) do
                DCSEx.world.destroyGroupByID(id)
            end
        end

        fighterGroups = { {}, {} }
    end

    function TUM.airForce.onStartUp()
        playerCenter = { x = env.mission.map.centerX, y = env.mission.map.centerY }

        local playerSlots = DCSEx.envMission.getPlayerGroups()
        if #playerSlots > 0 then
            playerCenter = { x = 0, y = 0 }
            for _,p in ipairs(playerSlots) do
                playerCenter.x = playerCenter.x + p.x
                playerCenter.y = playerCenter.y + p.y
            end
            playerCenter.x = playerCenter.x / #playerSlots
            playerCenter.y = playerCenter.y / #playerSlots
        end

        return true
    end
end
