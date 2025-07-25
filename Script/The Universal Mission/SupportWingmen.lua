-- ====================================================================================
-- TUM.SUPPORTWINGMEN - HANDLES THE PLAYER'S WINGMEN
-- ====================================================================================
-- ====================================================================================

TUM.supportWingmen = {}

do
    TUM.supportWingmen.orderID = {
        ORBIT = 1,
        REJOIN = 2,
        ENGAGE_BANDITS = 3,
    }

    local wingmenGroupID = nil
    local wingmenUnitID = {}
    local WINGMEN_COUNT = 2 -- TODO: load from setting

    local function getWingmenGroup()
        if TUM.settings.getValue(TUM.settings.id.MULTIPLAYER) then return nil end -- No wingmen in multiplayer
        if not wingmenGroupID then return nil end
        local wingmenGroup = DCSEx.world.getGroupByID(wingmenGroupID)
        if not wingmenGroup then return nil end
        if #wingmenGroup:getUnits() == 0 then return nil end

        return wingmenGroup
    end

    local function getWingmanNumberAsWord(index)
        if not index then return "Flight" end

        return DCSEx.string.toStringNumber(index + 1, true)
    end

    local function getWingmanCallsign(wingmanIndex)
        if wingmanIndex then
            if wingmanIndex < 1 or wingmanIndex > #wingmenUnitID then return "Wingman" end

            local wingmanUnit = DCSEx.world.getUnitByID(wingmenUnitID[wingmanIndex])
            if not wingmanUnit then return "Wingman" end
            return wingmanUnit:getCallsign()
        end

        for i=1,#wingmenUnitID do
            local wingmanUnit = DCSEx.world.getUnitByID(wingmenUnitID[i])
            if wingmanUnit then return wingmanUnit:getCallsign() end
        end

        return "Flight"
    end

    local function isValidTarget(detectedTarget, attributes)
        attributes = attributes or {}
        if not detectedTarget then return false end
        if not detectedTarget.object then return false end

        if #attributes == 0 then return true end
        for _,a in ipairs(attributes) do
            if detectedTarget.object:hasAttribute(a) then
                return true
            end
        end

        return false
    end

    local function getDetectedTargets(wingmanIndex, attributes, maxRangeInNM)
        TUM.log("A")
        attributes = attributes or {}
        local maxRange = DCSEx.converter.nmToMeters(maxRangeInNM or 1000)

        TUM.log("B")
        local searchPoints = {}
        if wingmanIndex then
            if wingmanIndex < 1 or wingmanIndex > #wingmenUnitID then return {} end
            local u = DCSEx.world.getUnitByID(wingmenUnitID[wingmanIndex])
            if not u then return {} end
            searchPoints = { DCSEx.math.vec3ToVec2(u:getPoint()) }
        else
            for i=1,#wingmenUnitID do
                local u = DCSEx.world.getUnitByID(wingmenUnitID[i])
                if u then
                    table.insert(searchPoints, DCSEx.math.vec3ToVec2(u:getPoint()))
                end
            end

            if #searchPoints == 0 then return {} end
        end

        -- Take into account better sensors (radars, TGPs...) in later periods
        local detectionRangeMultiplier = 1.0
        if TUM.settings.getValue(TUM.settings.id.TIME_PERIOD) == DCSEx.enums.timePeriod.MODERN then
            detectionRangeMultiplier = 1.5
        elseif TUM.settings.getValue(TUM.settings.id.TIME_PERIOD) == DCSEx.enums.timePeriod.COLD_WAR then
            detectionRangeMultiplier = 1.25
        end

        local knownGroups = {}
        local detectedTargets = {}
        local allGroups = coalition.getGroups(TUM.settings.getEnemyCoalition())
        for _,g in ipairs(allGroups) do
            local gID = g:getID()
            if g:isExist() and g:getSize() > 0 and not DCSEx.table.contains(knownGroups, gID) then
                local gPos = DCSEx.world.getGroupCenter(g)
                local gCateg = Group.getCategory(g)

                local detectionRange = DCSEx.converter.nmToMeters(20 * detectionRangeMultiplier)
                if gCateg == Group.Category.AIRPLANE then
                    detectionRange = DCSEx.converter.nmToMeters(50 * detectionRangeMultiplier)
                elseif gCateg == Group.Category.SHIP then
                    detectionRange = DCSEx.converter.nmToMeters(30 * detectionRangeMultiplier)
                end

                -- Check if at least one wingman is in detection range
                local inRange = false
                for _,p in ipairs(searchPoints) do
                    if DCSEx.math.getDistance2D(gPos, p) <= detectionRange then
                        inRange = true
                        break
                    end
                end

                if inRange then
                    table.insert(knownGroups, gID)

                    local groupInfo = {
                        id = gID,
                        point2 = gPos,
                        size = g:getSize(),
                        type = "unknown"
                    }

                    if gCateg == Group.Category.AIRPLANE then
                        groupInfo.type = "aircraft"
                    elseif gCateg == Group.Category.HELICOPTER then
                        groupInfo.type = "helicopters"
                    elseif gCateg == Group.Category.GROUND then
                        if g:getUnits()[1]:hasAttribute("Infantry") then
                            groupInfo.type = "infantry"
                        else
                            groupInfo.type = "vehicles"
                        end
                    elseif gCateg == Group.Category.SHIP then
                        groupInfo.type = "ships"
                    elseif gCateg == Group.Category.TRAIN then
                        groupInfo.type = "trains"
                    end

                    table.insert(detectedTargets, groupInfo)
                end
            end
        end

        return detectedTargets
    end

    local function getWingmanController(wingmanIndex)
        if not wingmanIndex then
            local wingmenGroup = getWingmenGroup()
            if not wingmenGroup then return nil end
            return wingmenGroup:getController()
        end

        if wingmanIndex < 1 or wingmanIndex > #wingmenUnitID then return nil end

        local wingmanUnit = DCSEx.world.getUnitByID(wingmenUnitID[wingmanIndex])
        if not wingmanUnit then return nil end
        return wingmanUnit:getController()
    end

    local function doWingmenCommandOrbit(args)
        local player = world:getPlayer()
        if not player then return end

        TUM.radio.playForAll("playerWingmanOrbit", { getWingmanNumberAsWord(args.index) }, player:getCallsign(), false)

        local wingmenCtrl = getWingmanController(args.index)
        if not wingmenCtrl then return end

        local point = nil

        if args.index then
            point = DCSEx.math.vec3ToVec2(DCSEx.world.getUnitByID(wingmenUnitID[args.index]):getPoint())
        else
            point = DCSEx.world.getGroupCenter(getWingmenGroup())
        end

        local taskTable = {
            id = "Orbit",
            params = {
                pattern = "Circle",
                point = point,
                -- altitude = player:getPoint().y
            }
        }
        wingmenCtrl:setTask(taskTable)
        TUM.radio.playForAll("pilotWingmanOrbit", { getWingmanNumberAsWord(args.index) }, getWingmanCallsign(args.index), true)
    end

    local function doWingmenCommandRejoin(args)
        local player = world:getPlayer()
        if not player then return end

        TUM.radio.playForAll("playerWingmanRejoin", { getWingmanNumberAsWord(args.index) }, player:getCallsign(), false)

        local wingmenCtrl = getWingmanController(args.index)
        if not wingmenCtrl then return end

        local taskTable = {
            id = "Follow",
            params = {
                groupId = DCSEx.dcs.getObjectIDAsNumber(player:getGroup()),
                pos = { x = -100, y = 0, z = -100 },
                lastWptIndexFlag  = false,
                lastWptIndex = -1
            }
        }
        wingmenCtrl:setTask(taskTable)
        TUM.radio.playForAll("pilotWingmanRejoin", { getWingmanNumberAsWord(args.index) }, getWingmanCallsign(args.index), true)
    end

    local function doWingmenCommandEngage(args)
        local player = world:getPlayer()
        if not player then return end

        if args.radioSuffix then
            TUM.radio.playForAll("playerWingmanEngage"..args.radioSuffix, { getWingmanNumberAsWord(args.index) }, player:getCallsign(), false)
        end

        local wingmenCtrl = getWingmanController(args.index)
        if not wingmenCtrl then return end

        local targets = getDetectedTargets(args.index, args.attributes, args.maxRange)
        if not targets or #targets == 0 then
            TUM.radio.playForAll("pilotWingmanEngageNoTarget", { getWingmanNumberAsWord(args.index) }, getWingmanCallsign(args.index), true)
            return
        end

        local taskTable = {
            id = "AttackGroup",
            params = {
                groupId = DCSEx.dcs.getObjectIDAsNumber(targetGroup),
            }
        }
        wingmenCtrl:setTask(taskTable)

        -- Rejoin back once bandit has been shot down
        local rejoinBackTable = {
            id = "Follow",
            params = {
                groupId = DCSEx.dcs.getObjectIDAsNumber(player:getGroup()),
                pos = { x = -100, y = 0, z = -100 },
                lastWptIndexFlag  = false,
                lastWptIndex = -1
            }
        }
        wingmenCtrl:pushTask(rejoinBackTable)
        if args.radioSuffix then
            TUM.radio.playForAll("pilotWingmanEngage"..args.radioSuffix, { getWingmanNumberAsWord(args.index) }, getWingmanCallsign(args.index), true)
        end
    end


    local function doWingmenCommandReportTargets(args)
        local detectedTargets = getDetectedTargets(args.index, args.attributes)

        local reportText = "Detected targets:"
        if #detectedTargets == 0 then
            reportText = reportText.." none"
        else
            for _,t in ipairs(detectedTargets) do
                reportText = reportText.."\n - "..tostring(t.size).."x "..t.type..", "..DCSEx.dcs.getBRAA(t.point2, DCSEx.math.vec3ToVec2(world:getPlayer():getPoint()), false, false, false).." from you"
            end
        end
        trigger.action.outText(reportText, 5)
    end

    local function doWingmenCommandReportStatus(args)
        args.noPlayerMessage = args.noPlayerMessage or false
        local player = world:getPlayer()
        if not player then return end

        if not args.noPlayerMessage then
            TUM.radio.playForAll("playerWingmanReportStatus", { getWingmanNumberAsWord(args.index) }, player:getCallsign(), false)
        end
        local wingmenGroup = getWingmenGroup()
        if not wingmenGroup then return end

        local statusMsg = ""
        local atLeastOneUnit = false
        for i,u in ipairs(wingmenGroup:getUnits()) do
            if not args.index or args.index == i then
                atLeastOneUnit = true
                if not args.index then statusMsg = statusMsg..u:getCallsign():upper().."\n" end
                if u:getLife() >= u:getLife0() then
                    statusMsg = statusMsg.."- No damage sustained, fuel green"
                else
                    statusMsg = statusMsg.."- Aircraft suffered damage, fuel green"
                end
                statusMsg = statusMsg.."\n- BRAA from you: "..DCSEx.dcs.getBRAA(u:getPoint(), DCSEx.math.vec3ToVec2(player:getPoint()), true)
                statusMsg = statusMsg.."\n- Armament: "
                local ammo = u:getAmmo()
                if #ammo == 0 then
                    statusMsg = statusMsg.."None"
                else
                    for j,a in ipairs(ammo) do
                        if a.count and a.desc and (a.desc.displayName or a.desc.typeName) then
                            local ammoName = a.desc.displayName or a.desc.typeName
                            if j > 1 then statusMsg = statusMsg..", " end
                            statusMsg = statusMsg..tostring(a.count).."x "..ammoName
                        end
                    end
                end

                statusMsg = statusMsg.."\n\n"
            end
        end

        if not atLeastOneUnit then return end

        if #statusMsg >= 2 then -- Remove trailing "\n\n"
            statusMsg = statusMsg:sub(1, #statusMsg - 2)
        end

        TUM.radio.playForAll("pilotWingmanReportStatus", { getWingmanNumberAsWord(args.index), statusMsg }, getWingmanCallsign(args.index), not args.noPlayerMessage)
    end

    local function createWingmen()
        TUM.supportWingmen.removeAll() -- Destroy all pre-existing wingmen
        TUM.log("Creating wingmen...")

        local player = world:getPlayer()
        if not player then return end

        -- Retrive player unit type
        local playerTypeName = player:getTypeName()
        if not Library.aircraft[playerTypeName] then
            TUM.log("Cannot spawn AI wingmen, aircraft \""..playerTypeName.."\" not found in the database.", TUM.logLevel.WARNING)
            return
        end
        local playerCategory = Group.Category.AIRPLANE
        if player:hasAttribute("Helicopters") then playerCategory = Group.Category.HELICOPTER end -- Player is a helicopter

        -- Generate wingman callsign
        local wingmanCallsign = DCSEx.envMission.getPlayerGroups()[1].units[1].callsign
        if type(wingmanCallsign) == "table" then
            wingmanCallsign[3] = nil
            wingmanCallsign["name"] = wingmanCallsign["name"]:sub(1, #wingmanCallsign["name"] - 1)
            if wingmanCallsign[4] then wingmanCallsign[4] = wingmanCallsign["name"] end
        else
            wingmanCallsign = DCSEx.unitCallsignMaker.getCallsign(playerTypeName)
        end

        local groupInfo = DCSEx.unitGroupMaker.create(
            TUM.settings.getPlayerCoalition(),
            playerCategory,
            DCSEx.math.randomPointInCircle(DCSEx.math.vec3ToVec2(player:getPoint()), 500, 250),
            { playerTypeName, playerTypeName },
            {
                callsign = wingmanCallsign,
                callsignOffset = 1,
                silenced = true,
                skill = "Excellent",
                taskFollow = DCSEx.dcs.getObjectIDAsNumber(player:getGroup()),
                unlimitedFuel = true
            }
        )

        if not groupInfo then
            TUM.log("Failed to spawn AI wingmen", TUM.logLevel.WARNING)
            return
        end
        wingmenGroupID = groupInfo.groupID
        wingmenUnitID = DCSEx.table.deepCopy(groupInfo.unitsID)

        TUM.log("Spawned AI wingmen")
        TUM.radio.playForAll("pilotWingmanRejoin", { getWingmanNumberAsWord() }, getWingmanCallsign(), true)
    end

    local function doWingmenCommandGoToMapMarker(args)
        local player = world:getPlayer()
        if not player then return end

        TUM.radio.playForAll("playerWingmanGoToMarker", { getWingmanNumberAsWord(args.index) }, player:getCallsign(), false)

        local wingmenCtrl = getWingmanController(args.index)
        if not wingmenCtrl then return end

        local mapMarker = DCSEx.world.getMarkerByText("wingman")
        if not mapMarker then
            TUM.radio.playForAll("pilotWingmanGoToMarkerNoMarker", { getWingmanNumberAsWord(args.index) }, getWingmanCallsign(args.index), true)
            return
        end

        local taskTable = {
            id = "Orbit",
            params = {
                pattern = "Circle",
                point = DCSEx.math.vec3ToVec2(mapMarker.pos),
            }
        }
        wingmenCtrl:setTask(taskTable)
        TUM.radio.playForAll("pilotWingmanGoToMarker", { getWingmanNumberAsWord(args.index) }, getWingmanCallsign(args.index), true)
    end

    function TUM.supportWingmen.removeAll()
        if not wingmenGroupID then return end

        TUM.log("Removing all wingmen...")

        DCSEx.world.destroyGroupByID(wingmenGroupID)
        -- TODO: delayed "returned to base" message from wingmen?

        wingmenGroupID = nil
        wingmenUnitID = {}
    end

    local function createWingmanSubMenu(rootPath, wingmanIndex)
        local wingmanPath = missionCommands.addSubMenu(getWingmanNumberAsWord(wingmanIndex), rootPath)

        missionCommands.addCommand("Engage bandits", wingmanPath, doWingmenCommandEngage, { index = wingmanIndex, attributes = { "Battle airplanes" }, maxRange = 60, radioSuffix = "Bandits" })
        missionCommands.addCommand("Report targets", wingmanPath, doWingmenCommandReportTargets, { index = wingmanIndex })
        missionCommands.addCommand("Report status", wingmanPath, doWingmenCommandReportStatus, { index = wingmanIndex, noPlayerMessage = false } )
        missionCommands.addCommand("Go to map marker WINGMAN", wingmanPath, doWingmenCommandGoToMapMarker, { index = wingmanIndex } )
        missionCommands.addCommand("Orbit at position", wingmanPath, doWingmenCommandOrbit, { index = wingmanIndex })
        missionCommands.addCommand("Rejoin", wingmanPath, doWingmenCommandRejoin, { index = wingmanIndex })
    end

    function TUM.supportWingmen.createMenu()
        if TUM.settings.getValue(TUM.settings.id.MULTIPLAYER) then return end -- No wingmen in multiplayer
        if WINGMEN_COUNT == 0 then return end

        local rootPath = missionCommands.addSubMenu("Wingmen")

        createWingmanSubMenu(rootPath, nil)
        for i=1,WINGMEN_COUNT do
            createWingmanSubMenu(rootPath, i)
        end
    end

    -------------------------------------
    -- Called when an event is raised
    -- @param event The DCS World event
    -------------------------------------
    function TUM.supportWingmen.onEvent(event)
        if TUM.settings.getValue(TUM.settings.id.MULTIPLAYER) then return end -- No wingmen in multiplayer
        if TUM.mission.getStatus() == TUM.mission.status.NONE then return end
        if not event.initiator then return end 
        if Object.getCategory(event.initiator) ~= Object.Category.UNIT then return end
        if not event.initiator:getPlayerName() then return end

        if event.id == world.event.S_EVENT_TAKEOFF then -- Create wingmen on takeoff
            createWingmen()
        elseif event.id == world.event.S_EVENT_LAND then
            TUM.supportWingmen.removeAll() -- Remove wingmen on landing
        end
    end
end
