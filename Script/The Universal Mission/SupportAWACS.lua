-- ====================================================================================
-- TUM.SUPPORTAWACS - HANDLES THE FRIENDLY AWACS
-- ====================================================================================
-- ====================================================================================

TUM.supportAWACS = {}

do
    local awacsGroupID = nil
    local awacsCallsign = "AWACS"

    local function doAwacsPicture(bogeyDope, delayAnswer)
        delayAnswer = delayAnswer or false

        if not awacsGroupID then return end

        local awacsGroup = DCSEx.world.getGroupByID(awacsGroupID)
        if not awacsGroup then return end
        local awacsUnit = awacsGroup:getUnits()[1]
        if not awacsGroup then return end
        local awacsController = awacsUnit:getController()
        if not awacsController then return end

        -- local aircraftGroups = awacsController:getDetectedTargets(Controller.Detection.RADAR)
        local detectedUnits = awacsController:getDetectedTargets()

        local detectedAircraft = {}
        for _,u in pairs(detectedUnits) do
            if u.object and u.distance and Object.getCategory(u.object) == Object.Category.UNIT and u.object:inAir() then
                if u.object:getCoalition() ~= TUM.settings.getPlayerCoalition() then
                    table.insert(detectedAircraft, u.object)
                end
            end
        end

        -- No aircraft on picture
        if #detectedAircraft == 0 then
            TUM.radio.playForCoalition(TUM.settings.getPlayerCoalition(), "awacsPictureClear", { awacsCallsign }, "Overlord", delayAnswer)
            return
        end

        for _,p in pairs(coalition.getPlayers(TUM.settings.getPlayerCoalition())) do
            local pVec3 = p:getPoint()

            local maxCount = 5
            if bogeyDope then maxCount = 1 end -- TODO: Only report the nearest FIGHTER (not transport, awacs, etc)
            local sortedThreats = DCSEx.dcs.getNearestObjects(pVec3, detectedAircraft, maxCount)

            local pictureMsg = ""
            for ___,u in pairs(sortedThreats) do
                local typeName = Library.objectNames.get(u)
                pictureMsg = pictureMsg.."\n- "..typeName..", "..DCSEx.dcs.getBRAA(u:getPoint(), pVec3, true)
            end

            TUM.radio.playForUnit(DCSEx.dcs.getObjectIDAsNumber(p), "awacsPicture", { awacsCallsign, pictureMsg }, "Overlord", delayAnswer)
        end
    end

    local function doCommandPicture()
        TUM.radio.playForCoalition(TUM.settings.getPlayerCoalition(), "playerAwacsPicture", { awacsCallsign }, "Flight", false)
        doAwacsPicture(false, true)
    end

    local function doCommandBogeyDope()
        TUM.radio.playForCoalition(TUM.settings.getPlayerCoalition(), "playerAwacsBogeyDope", { awacsCallsign }, "Flight", false)
        doAwacsPicture(true, true)
    end

    ----------------------------------------------------------
    -- Called on every mission update tick (every 15 seconds)
    -- @return True if something was done this tick, false otherwise
    ----------------------------------------------------------
    function TUM.supportAWACS.onClockTick()
        if not awacsGroupID then return false end -- No awacs aircraft
        if TUM.mission.getStatus() == TUM.mission.status.NONE then return false end -- Not in a mission

        doAwacsPicture(false, false)
        return true
    end

    function TUM.supportAWACS.createMenu()
        if not awacsGroupID then return end -- No AWACS

        local rootPath = missionCommands.addSubMenu("✈ Awacs")
        missionCommands.addCommand("Bogey dope", rootPath, doCommandBogeyDope, nil)
        missionCommands.addCommand("Picture", rootPath, doCommandPicture, nil)
    end

    function TUM.supportAWACS.create()
        if awacsGroupID then return end -- Already spawned

        local awacsUnits = Library.factions.getUnits(TUM.settings.getPlayerFaction(), DCSEx.enums.unitFamily.PLANE_AWACS, 1)
        awacsCallsign = "AWACS"

        if awacsUnits and #awacsUnits > 0 then
            local groupInfo = DCSEx.unitGroupMaker.create(
                TUM.settings.getPlayerCoalition(),
                Group.Category.AIRPLANE,
                TUM.territories.getTerritoryCenter(TUM.settings.getPlayerCoalition()),
                { DCSEx.table.getRandom(awacsUnits) },
                {
                    immortal = true,
                    invisible = true,
                    silenced = true,
                    taskAwacs = true,
                    unlimitedFuel = true
                })

            if groupInfo then
                awacsGroupID = groupInfo.groupID
                if groupInfo.callsign then
                    awacsCallsign = groupInfo.callsign.name:sub(1, #groupInfo.callsign.name - 1)
                end
                TUM.log("Spawned AWACS aircraft")
            else
                TUM.log("Failed to create AWACS aircraft", TUM.logLevel.WARNING)
            end
        else
            TUM.log("No AWACS aircraft available")
        end
    end
end
