-- ====================================================================================
-- TUM.WINGMEN - HANDLES THE WINGMEN'S CONTACTS
-- ====================================================================================
-- ====================================================================================

TUM.wingmenContacts = {}

do
    local CONTACT_REPORT_INTERVAL = 8 -- Called AT MOST every 15 seconds, so 6 means "AT MOST every two minutes"

    local knownGroupsID = {}
    local newGroupsID = {}
    local ticksLeftBeforeContactReport = CONTACT_REPORT_INTERVAL

    local function getGroupDetectionRange(grp)
        if not grp then return 0.0 end

        local gCateg = Group.getCategory(grp)

        -- Take into account better sensors (radars, TGPs...) in later periods
        local detectionRangeMultiplier = 1.0
        if TUM.settings.getValue(TUM.settings.id.TIME_PERIOD) == DCSEx.enums.timePeriod.MODERN then
            detectionRangeMultiplier = 2.0
        elseif TUM.settings.getValue(TUM.settings.id.TIME_PERIOD) == DCSEx.enums.timePeriod.COLD_WAR then
            detectionRangeMultiplier = 1.5
        elseif TUM.settings.getValue(TUM.settings.id.TIME_PERIOD) == DCSEx.enums.timePeriod.VIETNAM_WAR then
            detectionRangeMultiplier = 1.25
        end

        local detectionRange = DCSEx.converter.nmToMeters(15 * detectionRangeMultiplier)
        if gCateg == Group.Category.AIRPLANE then
            detectionRange = DCSEx.converter.nmToMeters(40 * detectionRangeMultiplier)
        elseif gCateg == Group.Category.SHIP then
            detectionRange = DCSEx.converter.nmToMeters(22 * detectionRangeMultiplier)
            local allSpeedboats = true
            for _,u in ipairs(grp:getUnits()) do
                if not u:getTypeName() == "speedboat" then allSpeedboats = false end
            end
            if allSpeedboats then detectionRange = detectionRange / 8 end -- Speedboats are HARD to spot
        elseif gCateg == Group.Category.GROUND then
            local allInfantry = true
            local airDefenseCount = 0
            for _,u in ipairs(grp:getUnits()) do
                if not u:hasAttribute("Infantry") then allInfantry = false end
                if u:hasAttribute("Air Defence") then airDefenseCount = airDefenseCount + 1 end
            end
            if allInfantry then detectionRange = detectionRange / 8 end -- Infantry is HARD to spot
        end

        return detectionRange
    end

    function TUM.wingmenContacts.clearKnownContacts()
        knownGroupsID = {}
        newGroupsID = {}
        ticksLeftBeforeContactReport = CONTACT_REPORT_INTERVAL
    end

    function TUM.wingmenContacts.getContacts(groupCategory)
        if TUM.settings.getValue(TUM.settings.id.MULTIPLAYER) then return {} end -- No wingmen in multiplayer
        if TUM.mission.getStatus() == TUM.mission.status.NONE then return {} end
        local wingmenGroup = TUM.wingmen.getGroup()
        if not wingmenGroup then return {} end

        local searchPoint = DCSEx.world.getGroupCenter(wingmenGroup)

        local detectedTargets = {}
        local allGroups = coalition.getGroups(TUM.settings.getEnemyCoalition(), groupCategory)
        for _,g in ipairs(allGroups) do
            local gID = g:getID()
            if g:isExist() and g:getSize() > 0 then
                local gPos = DCSEx.world.getGroupCenter(g)
                local gCateg = Group.getCategory(g)

                local detectionRange = getGroupDetectionRange(g)

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
                        type = "contact"
                    }

                    -- Return exact type when contact is close enough
                    if distanceToGroup < detectionRange / 2 then
                        groupInfo.type = Library.objectNames.get(g:getUnit(1))
                    else
                        groupInfo.type = Library.objectNames.getGenericGroup(g)
                    end

                    table.insert(detectedTargets, groupInfo)
                end
            end
        end

        return detectedTargets
    end

    function TUM.wingmenContacts.getContactsAsReportString(groupCategory, giveRelativePosition, newContactsOnly)
        giveRelativePosition = giveRelativePosition or false
        newContactsOnly = newContactsOnly or false

        if TUM.settings.getValue(TUM.settings.id.MULTIPLAYER) then return nil end -- No wingmen in multiplayer
        local contacts = TUM.wingmenContacts.getContacts(groupCategory)
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

    ----------------------------------------------------------
    -- Called on every mission update tick (every 10-20 seconds)
    -- @return True if something was done this tick, false otherwise
    ----------------------------------------------------------    
    function TUM.wingmenContacts.onClockTick()
        if TUM.settings.getValue(TUM.settings.id.MULTIPLAYER) then return false end -- No wingmen in multiplayer
        if TUM.mission.getStatus() == TUM.mission.status.NONE then return false end

        TUM.wingmenContacts.getContacts() -- Check for new contacts, just in case
        if #newGroupsID > 0 then -- New contacts found, alert the player!
            local newContactsReportString = TUM.wingmenContacts.getContactsAsReportString(nil, true, true)
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
end
