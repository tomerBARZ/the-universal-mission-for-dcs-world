-- ====================================================================================
-- TUM.MISSION - HANDLES THE F10 MENU DISPLAYED DURING A MISSION
-- ====================================================================================
-- ====================================================================================

TUM.missionMenu = {}

do
    local function doCommandAbortMission()
        TUM.mission.endMission(TUM.mission.endCause.ABORTED)
    end

    local function doCommandMissionStatus()
        TUM.radio.playForCoalition(TUM.settings.getPlayerCoalition(), "playerCommandMissionStatus", nil, "Flight", false)
        TUM.mission.playMissionSummaryRadioMessage(false, true)
    end

    local function doCommandObjectiveLocation(index)
        local obj = TUM.objectives.getObjective(index)
        if not obj then return end

        local messageSuffix = ""
        if obj.preciseCoordinates then messageSuffix = "Precise" end

        TUM.radio.playForCoalition(TUM.settings.getPlayerCoalition(), "playerCommandRequireObjectives", { obj.name }, "Flight", false)

        local players = coalition.getPlayers(TUM.settings.getPlayerCoalition())
        for _,p in ipairs(players) do
            local coordinates = DCSEx.world.getCoordinatesAsString(obj.waypoint3, false)
            local braa = DCSEx.dcs.getBRAA(obj.waypoint3, p:getPoint(), false)
            TUM.radio.playForUnit(DCSEx.dcs.getObjectIDAsNumber(p), "commandObjectiveCoordinates"..messageSuffix, { obj.name, coordinates, braa }, "Command", true)
        end
    end

    function TUM.missionMenu.create()
        missionCommands.removeItem() -- Clear the menu
        missionCommands.addCommand("☱ Mission status", nil, doCommandMissionStatus, nil)

        local objectivesMenuRoot = missionCommands.addSubMenu("Objectives")
        for i=1,TUM.objectives.getCount() do
            local obj = TUM.objectives.getObjective(i)
            if obj then
                local objRoot = missionCommands.addSubMenu("Objective "..obj.name.." ("..Library.tasks[obj.taskID].description.short..")", objectivesMenuRoot)
                missionCommands.addCommand("Request objective coordinates", objRoot, doCommandObjectiveLocation, i)
                TUM.supportJTAC.setupJTACOnObjective(i, objRoot)
            end
        end

        TUM.wingmenMenu.create()
        TUM.supportAWACS.createMenu()

        if not TUM.settings.getValue(TUM.settings.id.MULTIPLAYER) then -- If not multiplayer, add "show mission score" command
            missionCommands.addCommand("★ Display mission score", nil, TUM.playerScore.showScore, nil)
        end

        local abortRoot = missionCommands.addSubMenu("⬣ Abort mission")
        if not TUM.settings.getValue(TUM.settings.id.MULTIPLAYER) and DCSEx.io.canReadAndWrite() then
            missionCommands.addCommand("✓ Confirm (all xp since last landing will be lost!)", abortRoot, doCommandAbortMission, nil)
        else
            missionCommands.addCommand("✓ Confirm", abortRoot, doCommandAbortMission, nil)
        end
        missionCommands.addCommand("✕ Cancel", abortRoot, DCSEx.dcs.doNothing, nil)

        TUM.debugMenu.createMenu() -- Append debug menu to other menus (if debug mode enabled)
    end
end
