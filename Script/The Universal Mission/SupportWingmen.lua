-- ====================================================================================
-- TUM.SUPPORTWINGMEN - HANDLES THE PLAYER'S WINGMEN
-- ====================================================================================
-- ====================================================================================

TUM.supportWingmen = {}

do
    TUM.supportWingmen.orderID = {
        ORBIT = 1,
        REJOIN = 2,
    }

    local wingmenGroupID = nil

    local function doWingmenOrder(orderID)
        local player = world:getPlayer()
        if not player then return end

        if orderID == TUM.supportWingmen.orderID.ORBIT then
            TUM.radio.playForAll("playerFlightOrbit", nil, player:getCallsign(), false)
        elseif orderID == TUM.supportWingmen.orderID.REJOIN then
            TUM.radio.playForAll("playerFlightRejoin", nil, player:getCallsign(), false)
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
        end

        if not taskTable then return end

        wingmenCtrl:setTask(taskTable)
    end

    local function createWingmen()
        TUM.supportWingmen.removeAll() -- Destroy all pre-existing wingmen
        TUM.log("Creating wingmen...")

        local player = world:getPlayer()
        if not player then return end

        local playerTypeName = player:getTypeName()

        local playerCategory = Group.Category.AIRPLANE
        if player:hasAttribute("Helicopters") then playerCategory = Group.Category.HELICOPTER end

        local groupInfo = DCSEx.unitGroupMaker.create(
            TUM.settings.getPlayerCoalition(),
            playerCategory,
            DCSEx.math.randomPointInCircle(DCSEx.math.vec3ToVec2(player:getPoint()), 500, 250),
            { playerTypeName, playerTypeName },
            {
                callsign = DCSEx.unitCallsignMaker.getNextGroupCallSign(player:getCallsign()),
                silenced = true,
                taskFollow = DCSEx.dcs.getObjectIDAsNumber(player:getGroup()),
                unlimitedFuel = true
            }
        )

        if not groupInfo then
            TUM.log("Failed to spawn AI wingmen", TUM.logLevel.WARNING)
            return
        end

        TUM.log("Spawned AI wingmen")
        TUM.radio.playForAll("pilotWingmanRejoin", nil, "WINGMEN", false)
        wingmenGroupID = groupInfo.groupID
    end

    function TUM.supportWingmen.removeAll()
        if wingmenGroupID then TUM.log("Removing all wingmen...") end

        DCSEx.world.destroyGroupByID(wingmenGroupID)

        wingmenGroupID = nil
    end

    function TUM.supportWingmen.createMenu()
        if TUM.settings.getValue(TUM.settings.id.MULTIPLAYER) then return end -- No wingmen in multiplayer

        local rootPath = missionCommands.addSubMenu("Flight")
        missionCommands.addCommand("Orbit", rootPath, doWingmenOrder, TUM.supportWingmen.orderID.ORBIT)
        missionCommands.addCommand("Rejoin", rootPath, doWingmenOrder, TUM.supportWingmen.orderID.REJOIN)
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
