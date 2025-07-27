-- ====================================================================================
-- TUM.WINGMEN - HANDLES THE PLAYER'S WINGMEN
-- ====================================================================================
-- ====================================================================================

TUM.wingmen = {}

do
    local DEFAULT_PAYLOAD = "attack" -- Default payload

    local wingmenGroupID = nil
    local wingmenUnitID = {}

    local function getWingmanPayloadForMission()
        if TUM.mission.getStatus() == TUM.mission.status.NONE then return DEFAULT_PAYLOAD end

        local taskingID = TUM.settings.getValue(TUM.settings.id.TASKING)

        if taskingID == DCSEx.enums.taskFamily.ANTISHIP then
            return "antiship"
        -- elseif taskingID == DCSEx.enums.taskFamily.CAP = 2 then
        -- elseif taskingID == DCSEx.enums.taskFamily.CAS = 3 then
        elseif taskingID == DCSEx.enums.taskFamily.GROUND_ATTACK then
            return "attack"
        -- elseif taskingID == DCSEx.enums.taskFamily.HELICOPTER then
        -- elseif taskingID == DCSEx.enums.taskFamily.HELO_HUN then
        elseif taskingID == DCSEx.enums.taskFamily.INTERCEPTION then
            return "cap"
        -- elseif taskingID == DCSEx.enums.taskFamily.OCA then
        elseif taskingID == DCSEx.enums.taskFamily.SEAD then
            return "sead"
        -- elseif taskingID == DCSEx.enums.taskFamily.STRIKE then
        --     return "strike"
        end

        return DEFAULT_PAYLOAD
    end

    function TUM.wingmen.create()
        TUM.wingmen.removeAll() -- Destroy all pre-existing wingmen
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

        -- Select proper payload for mission
        local groupInfo = DCSEx.unitGroupMaker.create(
            TUM.settings.getPlayerCoalition(),
            playerCategory,
            DCSEx.math.randomPointInCircle(DCSEx.math.vec3ToVec2(player:getPoint()), 500, 250),
            { playerTypeName, playerTypeName },
            {
                altitude = math.min(player:getPoint().y + 1524, 3048), -- spawn at player altitude + 5,000ft, up to a max of 10,000ft (to avoid crashes into nearby hills)
                callsign = wingmanCallsign,
                callsignOffset = 1,
                payload = getWingmanPayloadForMission(),
                prohibitJettison = true,
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

        -- Reinitialize list of known contacts and contact report interval
        TUM.wingmenContacts.clearKnownContacts()

        TUM.log("Spawned AI wingmen")

        TUM.radio.playForAll("pilotWingmanTakeOff", { TUM.wingmen.getFirstWingmanNumber() }, TUM.wingmen.getFirstWingmanCallsign(), true)
        TUM.wingmenTasking.commandRejoin(nil, true, true) -- Task the new wingmen to rejoin
    end

    function TUM.wingmen.getController()
        local wingmenGroup = TUM.wingmen.getGroup()
        if not wingmenGroup then return nil end
        return wingmenGroup:getController()
    end

    function TUM.wingmen.getFirstWingmanCallsign()
        for i=1,#wingmenUnitID do
            local wingmanUnit = DCSEx.world.getUnitByID(wingmenUnitID[i])
            if wingmanUnit then return wingmanUnit:getCallsign() end
        end

        return "Flight"
    end

    function TUM.wingmen.getFirstWingmanUnit()
        for i=1,#wingmenUnitID do
            local wingmanUnit = DCSEx.world.getUnitByID(wingmenUnitID[i])
            if wingmanUnit then return wingmanUnit end
        end

        return nil
    end

    function TUM.wingmen.getFirstWingmanNumber()
        for i=1,#wingmenUnitID do
            local wingmanUnit = DCSEx.world.getUnitByID(wingmenUnitID[i])
            if wingmanUnit then return DCSEx.string.toStringNumber(i + 1, true) end
        end

        return "Flight"
    end

    function TUM.wingmen.getGroup()
        if TUM.settings.getValue(TUM.settings.id.MULTIPLAYER) then return nil end -- No wingmen in multiplayer
        if not wingmenGroupID then return nil end
        local wingmenGroup = DCSEx.world.getGroupByID(wingmenGroupID)
        if not wingmenGroup then return nil end
        -- if #wingmenGroup:getUnits() <= 0 then return nil end
        if wingmenGroup:getSize() <= 0 then return nil end

        return wingmenGroup
    end

    function TUM.wingmen.removeAll()
        if not wingmenGroupID then return end

        TUM.log("Removing all wingmen...")
        DCSEx.world.destroyGroupByID(wingmenGroupID)

        wingmenGroupID = nil
        wingmenUnitID = {}
    end

    -------------------------------------
    -- Called when an event is raised
    -- @param event The DCS World event
    -------------------------------------
    function TUM.wingmen.onEvent(event)
        if TUM.settings.getValue(TUM.settings.id.MULTIPLAYER) then return end -- No wingmen in multiplayer
        if not event.initiator then return end
        if Object.getCategory(event.initiator) ~= Object.Category.UNIT then return end
        if not event.initiator:getPlayerName() then return end

        if event.id == world.event.S_EVENT_TAKEOFF then -- Create wingmen on player takeoff
            if TUM.mission.getStatus() == TUM.mission.status.NONE then return end -- Mission not in progress, no wingman needed
            TUM.wingmen.create()
        elseif event.id == world.event.S_EVENT_LAND then -- Remove wingmen on player landing
            TUM.wingmen.removeAll()
        end
    end
end
