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

    local function getWingmenGroup()
        if TUM.settings.getValue(TUM.settings.id.MULTIPLAYER) then return nil end -- No wingmen in multiplayer
        if not wingmenGroupID then return nil end
        local wingmenGroup = DCSEx.world.getGroupByID(wingmenGroupID)
        if not wingmenGroup then return nil end
        if #wingmenGroup:getUnits() == 0 then return nil end

        return wingmenGroup
    end

    local function getWingmenCallsign()
        local wingmenGroup = getWingmenGroup()
        if not wingmenGroup then return "Wingmen" end
        return wingmenGroup:getUnit(1):getCallsign()
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

    local function getDetectedTargets(attributes)
        local wingmenGroup = getWingmenGroup()
        trigger.action.outText("A", 1)
        if not wingmenGroup then return {} end

        trigger.action.outText("B", 1)
        local detectedTargets = {}
        for _,u in ipairs(wingmenGroup:getUnits()) do
            trigger.action.outText("C", 1)
            local ctrl = u:getController()
            if ctrl then
                trigger.action.outText("D", 1)
                local targets = ctrl:getDetectedTargets() -- Controller.Detection.VISUAL, Controller.Detection.OPTIC, Controller.Detection.RADAR, Controller.Detection.RWR, Controller.Detection.IRST)
                for _,t in ipairs(targets) do
                    trigger.action.outText("E", 1)
                    if isValidTarget(t, attributes) then
                        trigger.action.outText("F", 1)
                        table.insert(detectedTargets, t.object)
                    end
                end
            end
        end

        return detectedTargets
    end

    local function doWingmenOrder(orderID)
        local player = world:getPlayer()
        if not player then return end

        if orderID == TUM.supportWingmen.orderID.ORBIT then
            TUM.radio.playForAll("playerFlightOrbit", nil, player:getCallsign(), false)
        elseif orderID == TUM.supportWingmen.orderID.REJOIN then
            TUM.radio.playForAll("playerFlightRejoin", nil, player:getCallsign(), false)
        elseif orderID == TUM.supportWingmen.orderID.ENGAGE_BANDITS then
            TUM.radio.playForAll("playerFlightEngageBandits", nil, player:getCallsign(), false)
        end

        if not wingmenGroupID then return end
        local wingmenGroup = DCSEx.world.getGroupByID(wingmenGroupID)
        if not wingmenGroup then return end
        if #wingmenGroup:getUnits() == 0 then return end
        local wingmenCtrl = wingmenGroup:getController()
        if not wingmenCtrl then return end

        local wingmanCallsign = wingmenGroup:getUnit(1):getCallsign()

        local taskTable = nil

        if orderID == TUM.supportWingmen.orderID.ORBIT then
            taskTable = {
                id = "Orbit",
                params = {
                    pattern = "Circle",
                    point = DCSEx.math.vec3ToVec2(player:getPoint()),
                    altitude = player:getPoint().y
                }
            }
            TUM.radio.playForAll("pilotWingmanOrbit", nil, wingmanCallsign, true)
        elseif orderID == TUM.supportWingmen.orderID.REJOIN then
            taskTable = {
                id = "Follow",
                params = {
                    groupId = DCSEx.dcs.getObjectIDAsNumber(world:getPlayer():getGroup()),
                    pos = { x = -100, y = 0, z = -100 },
                    lastWptIndexFlag  = false,
                    lastWptIndex = -1
                }
            }
            TUM.radio.playForAll("pilotWingmanRejoin", nil, wingmanCallsign, true)
        elseif orderID == TUM.supportWingmen.orderID.ENGAGE_BANDITS then
            local banditGroups = coalition.getGroups(TUM.settings.getEnemyCoalition(), Group.Category.AIRPLANE)
            if not banditGroups or #banditGroups == 0 then
                TUM.radio.playForAll("pilotWingmanEngageNoTarget", nil, wingmanCallsign, true)
                return
            end
            -- TODO: sort by nearest
            local targetGroup = banditGroups[1]

            taskTable = {
                id = "AttackGroup",
                params = {
                    groupId = DCSEx.dcs.getObjectIDAsNumber(targetGroup),
                }
            }
            TUM.radio.playForAll("pilotWingmanEngageBandits", nil, wingmanCallsign, true)
        end

        if not taskTable then return end

        wingmenCtrl:setTask(taskTable)
    end

    local function doWingmenCommandOrbit()
        local player = world:getPlayer()
        if not player then return end

        TUM.radio.playForAll("playerFlightOrbit", nil, player:getCallsign(), false)

        local wingmenGroup = getWingmenGroup()
        if not wingmenGroup then return end
        local wingmenCtrl = wingmenGroup:getController()
        if not wingmenCtrl then return end

        local taskTable = {
            id = "Orbit",
            params = {
                pattern = "Circle",
                point = DCSEx.math.vec3ToVec2(player:getPoint()),
                altitude = player:getPoint().y
            }
        }
        wingmenCtrl:setTask(taskTable)
        TUM.radio.playForAll("pilotWingmanOrbit", nil, getWingmenCallsign(), true)
    end

    local function doWingmenCommandRejoin()
        local player = world:getPlayer()
        if not player then return end

        TUM.radio.playForAll("playerFlightRejoin", nil, player:getCallsign(), false)

        local wingmenGroup = getWingmenGroup()
        if not wingmenGroup then return end
        local wingmenCtrl = wingmenGroup:getController()
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
        TUM.radio.playForAll("pilotWingmanRejoin", nil, getWingmenCallsign(), true)
    end

    local function doWingmenOrderEngage(orderID)
    end

    local function doWingmenCommandReportTargets(attributes)
        local detectedTargets = getDetectedTargets(attributes)

        local reportText = "Detected targets:"
        if #detectedTargets == 0 then
            reportText = reportText.." none"
        else
            for _,t in ipairs(detectedTargets) do
                reportText = reportText.."\n - "..Library.objectNames.get(t)
            end
        end
        trigger.action.outText(reportText, 5)
    end

    local function doWingmenCommandReportStatus(sponatenousReport)
        sponatenousReport = sponatenousReport or false
        local player = world:getPlayer()
        if not player then return end

        if not sponatenousReport then
            TUM.radio.playForAll("playerFlightReportStatus", nil, player:getCallsign(), false)
        end
        local wingmenGroup = getWingmenGroup()
        if not wingmenGroup then return end

        local statusMsg = ""
        for i,u in ipairs(wingmenGroup:getUnits()) do
            statusMsg = statusMsg..u:getCallsign():upper()
            if u:getLife() >= u:getLife0() then
                statusMsg = statusMsg.."\n- No damage sustained"
            else
                statusMsg = statusMsg.."\n- Aircraft suffered damage"
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

            if i < wingmenGroup:getSize() then statusMsg = statusMsg.."\n\n" end
        end

        TUM.radio.playForAll("pilotWingmanReportStatus", { statusMsg }, getWingmenCallsign(), not sponatenousReport)
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

        TUM.log("Spawned AI wingmen")
        TUM.radio.playForAll("pilotWingmanRejoin", nil, getWingmenCallsign(), true)
    end

    function TUM.supportWingmen.removeAll()
        if not wingmenGroupID then return end

        TUM.log("Removing all wingmen...")

        DCSEx.world.destroyGroupByID(wingmenGroupID)
        -- TODO: delayed "returned to base" message from wingmen?

        wingmenGroupID = nil
    end

    function TUM.supportWingmen.createMenu()
        if TUM.settings.getValue(TUM.settings.id.MULTIPLAYER) then return end -- No wingmen in multiplayer

        local rootPath = missionCommands.addSubMenu("Flight")

        missionCommands.addCommand("Engage bandits", rootPath, doWingmenOrder, TUM.supportWingmen.orderID.ENGAGE_BANDITS)
        missionCommands.addCommand("Engage air defense", rootPath, doWingmenOrder, TUM.supportWingmen.orderID.ENGAGE_BANDITS)
        missionCommands.addCommand("Engage ground targets", rootPath, doWingmenOrder, TUM.supportWingmen.orderID.ENGAGE_BANDITS)
        missionCommands.addCommand("Report targets", rootPath, doWingmenCommandReportTargets, nil)
        missionCommands.addCommand("Report status", rootPath, doWingmenCommandReportStatus, false)
        missionCommands.addCommand("Orbit", rootPath, doWingmenCommandOrbit, nil)
        missionCommands.addCommand("Rejoin", rootPath, doWingmenCommandRejoin, nil)
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
