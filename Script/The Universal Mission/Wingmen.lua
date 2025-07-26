-- ====================================================================================
-- TUM.WINGMEN - HANDLES THE PLAYER'S WINGMEN
-- ====================================================================================
-- ====================================================================================

TUM.wingmen = {}

do
    local CONTACT_REPORT_INTERVAL = 8 -- Called AT MOST every 15 seconds, so 6 means "AT MOST every two minutes"
    local DEFAULT_PAYLOAD = "attack" -- Default payload

    local knownGroupsID = {}
    local newGroupsID = {}
    local ticksLeftBeforeContactReport = CONTACT_REPORT_INTERVAL
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
        elseif taskingID == DCSEx.enums.taskFamily.STRIKE then
            return "strike"
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
        knownGroupsID = {}
        newGroupsID = {}
        ticksLeftBeforeContactReport = CONTACT_REPORT_INTERVAL

        TUM.log("Spawned AI wingmen")

        TUM.radio.playForAll("pilotWingmanTakeOff", { TUM.wingmen.getFirstWingmanNumber() }, TUM.wingmen.getFirstWingmanCallsign(), true)
        TUM.wingmenTasking.commandRejoin(nil, true, true) -- Task the new wingmen to rejoin
    end

    function TUM.wingmen.getContacts(groupCategory)
        if TUM.settings.getValue(TUM.settings.id.MULTIPLAYER) then return {} end -- No wingmen in multiplayer
        if TUM.mission.getStatus() == TUM.mission.status.NONE then return {} end
        local wingmenGroup = TUM.wingmen.getGroup()
        if not wingmenGroup then return {} end

        local searchPoint = DCSEx.world.getGroupCenter(wingmenGroup)

        -- Take into account better sensors (radars, TGPs...) in later periods
        local detectionRangeMultiplier = 1.0
        if TUM.settings.getValue(TUM.settings.id.TIME_PERIOD) == DCSEx.enums.timePeriod.MODERN then
            detectionRangeMultiplier = 1.5
        elseif TUM.settings.getValue(TUM.settings.id.TIME_PERIOD) == DCSEx.enums.timePeriod.COLD_WAR then
            detectionRangeMultiplier = 1.25
        end

        local detectedTargets = {}
        local allGroups = coalition.getGroups(TUM.settings.getEnemyCoalition(), groupCategory)
        for _,g in ipairs(allGroups) do
            local gID = g:getID()
            if g:isExist() and g:getSize() > 0 then
                local gPos = DCSEx.world.getGroupCenter(g)
                local gCateg = Group.getCategory(g)

                local detectionRange = DCSEx.converter.nmToMeters(20 * detectionRangeMultiplier)
                if gCateg == Group.Category.AIRPLANE then
                    detectionRange = DCSEx.converter.nmToMeters(50 * detectionRangeMultiplier)
                elseif gCateg == Group.Category.SHIP then
                    detectionRange = DCSEx.converter.nmToMeters(30 * detectionRangeMultiplier)
                    local allSpeedboats = true
                    for _,u in ipairs(g:getUnits()) do
                        if not u:getTypeName() == "speedboat" then allSpeedboats = false end
                    end
                    if allSpeedboats then detectionRange = detectionRange / 8 end -- Speedboats are HARD to spot
                elseif gCateg == Group.Category.GROUND then
                    local allInfantry = true
                    local airDefenseCount = 0
                    for _,u in ipairs(g:getUnits()) do
                        if not u:hasAttribute("Infantry") then allInfantry = false end
                        if u:hasAttribute("Air Defence") then airDefenseCount = airDefenseCount + 1 end
                    end
                    if allInfantry then detectionRange = detectionRange / 8 end -- Infantry is HARD to spot
                end

                local distanceToGroup = DCSEx.math.getDistance2D(gPos, searchPoint)
                if distanceToGroup <= detectionRange then -- Check if wingman group is in detection range
                    if not DCSEx.table.contains(knownGroupsID, gID) then
                        table.insert(knownGroupsID, gID)
                        table.insert(newGroupsID, gID)
                    end

                    local groupInfo = {
                        id = gID,
                        point2 = gPos,
                        size = g:getSize(),
                        type = "unknown"
                    }

                    if gCateg == Group.Category.AIRPLANE or gCateg == Group.Category.HELICOPTER then
                        if distanceToGroup < detectionRange / 2 then -- Return exact type when aircraft is close enough
                            groupInfo.type = Library.objectNames.get(g:getUnit(1))
                        else
                            groupInfo.type = Library.objectNames.getGenericGroup(g)
                        end
                    else
                        if distanceToGroup > 2 * detectionRange / 3 then
                            groupInfo.type = Library.objectNames.getGenericGroup(g, true)
                        elseif distanceToGroup > detectionRange / 3 then
                            groupInfo.type = Library.objectNames.getGenericGroup(g, false)
                        else
                            groupInfo.type = Library.objectNames.get(g:getUnit(1))
                        end
                    end

                    table.insert(detectedTargets, groupInfo)
                end
            end
        end

        return detectedTargets
    end

    function TUM.wingmen.getContactsAsReportString(groupCategory, giveRelativePosition, newContactsOnly)
        giveRelativePosition = giveRelativePosition or false
        newContactsOnly = newContactsOnly or false

        if TUM.settings.getValue(TUM.settings.id.MULTIPLAYER) then return nil end -- No wingmen in multiplayer
        local contacts = TUM.wingmen.getContacts(groupCategory)
        if not contacts or #contacts == 0 then return nil end

        local refPoint = DCSEx.world.getGroupCenter(TUM.wingmen.getGroup())

        local reportText = ""
        for _,t in ipairs(contacts) do
            if not newContactsOnly or DCSEx.table.contains(newGroupsID, t.id) then
                reportText = reportText.."\n - "..tostring(t.size).."x "..t.type
                if refPoint and giveRelativePosition then
                    reportText = reportText..", "..DCSEx.dcs.getBRAA(t.point2, refPoint, false, false, false)
                end
            end
        end
        return reportText
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

    function TUM.wingmen.getFirstWingmanNumber()
        for i=1,#wingmenUnitID do
            local wingmanUnit = DCSEx.world.getUnitByID(wingmenUnitID[i])
            if wingmanUnit then return DCSEx.string.toStringNumber(i + 1, true) end
        end

        return "Two"
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

    function TUM.wingmen.updateContacts()
        if TUM.settings.getValue(TUM.settings.id.MULTIPLAYER) then return nil end -- No wingmen in multiplayer
        if not wingmenGroupID then return end
    end

    ----------------------------------------------------------
    -- Called on every mission update tick (every 10-20 seconds)
    -- @return True if something was done this tick, false otherwise
    ----------------------------------------------------------    
    function TUM.wingmen.onClockTick()
        if TUM.settings.getValue(TUM.settings.id.MULTIPLAYER) then return false end -- No wingmen in multiplayer
        if TUM.mission.getStatus() == TUM.mission.status.NONE then return false end

        TUM.wingmen.getContacts() -- Check for new contacts, just in case
        if #newGroupsID > 0 then -- New contacts found, alert the player!
            local newContactsReportString = TUM.wingmen.getContactsAsReportString(nil, true, true)
            TUM.radio.playForAll("pilotWingmanReportContactsNew", { TUM.wingmen.getFirstWingmanNumber(), newContactsReportString }, TUM.wingmen.getFirstWingmanCallsign(), false)
            newGroupsID = {}
            if ticksLeftBeforeContactReport < math.floor(CONTACT_REPORT_INTERVAL / 2) then
                ticksLeftBeforeContactReport = math.floor(CONTACT_REPORT_INTERVAL / 2)
            end
            return true
        end

        ticksLeftBeforeContactReport = ticksLeftBeforeContactReport - 1
        if ticksLeftBeforeContactReport > 0 then return false end
        ticksLeftBeforeContactReport = CONTACT_REPORT_INTERVAL

        return TUM.wingmenTasking.commandReportContacts(nil, true, false)
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
