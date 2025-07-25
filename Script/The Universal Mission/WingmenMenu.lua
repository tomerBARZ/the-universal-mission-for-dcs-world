-- ====================================================================================
-- TUM.WINGMENMENU - HANDLES THE WINGMEN'S F10 MENU
-- ====================================================================================
-- ====================================================================================

TUM.wingmenMenu = {}

do
    local function radioCommandReportContacts()
        local player = world:getPlayer()
        if not player then return false end
        TUM.radio.playForAll("playerWingmanReportContacts", nil, player:getCallsign(), false)

        TUM.wingmenTasking.commandReportContacts(nil, false, true)
    end

    local function radioCommandEngage(args)
        local player = world:getPlayer()
        if not player then return end

        TUM.radio.playForAll("playerWingmanEngage"..args.radioMessageSuffix, nil, player:getCallsign(), false)
        TUM.wingmenTasking.commandEngage(args.category, args.attributes, true)
    end

    local function radioCommandReportStatus()
        local player = world:getPlayer()
        if not player then return end
        TUM.radio.playForAll("playerWingmanReportStatus", nil, player:getCallsign(), false)

        TUM.wingmenTasking.commandReportStatus(true)
    end

    local function radioCommandGoToMapMarker()
        local player = world:getPlayer()
        if not player then return end
        TUM.radio.playForAll("playerWingmanGoToMarker", nil, player:getCallsign(), false)

        TUM.wingmenTasking.commandGoToMapMarker(TUM.wingmenTasking.DEFAULT_MARKER_TEXT, true)
    end

    local function radioCommandOrbit()
        local player = world:getPlayer()
        if not player then return end
        TUM.radio.playForAll("playerWingmanOrbit", nil, player:getCallsign(), false)

        TUM.wingmenTasking.commandOrbit(true)
    end

    local function radioCommandRejoin()
        local player = world:getPlayer()
        if not player then return end
        TUM.radio.playForAll("playerWingmanRejoin", nil, player:getCallsign(), false)

        TUM.wingmenTasking.commandRejoin(nil, true)
    end

    function TUM.wingmenMenu.create()
        if TUM.settings.getValue(TUM.settings.id.MULTIPLAYER) then return end -- No wingmen in multiplayer
        -- TODO: if WINGMEN_COUNT == 0 then return end

        local rootPath = missionCommands.addSubMenu("Flight")

        local engagePath = missionCommands.addSubMenu("Engage", rootPath)
        missionCommands.addCommand("Bandits", engagePath, radioCommandEngage, { attributes = nil, category = Group.Category.HELICOPTER, radioMessageSuffix = "Bandits" })
        missionCommands.addCommand("Helicopters", engagePath, radioCommandEngage, { attributes = nil, category = Group.Category.HELICOPTER, radioMessageSuffix = "Helicopters" })
        missionCommands.addCommand("Air defense", engagePath, radioCommandEngage, { attributes = { "Air Defence" }, category = Group.Category.GROUND, radioMessageSuffix = "AirDefense" })
        missionCommands.addCommand("Ground targets", engagePath, radioCommandEngage, { attributes = {"Tanks", "Trucks", "Artillery", "IFV", "APC"}, category = Group.Category.GROUND, radioMessageSuffix = "Ground" })
        missionCommands.addCommand("Ships", engagePath, radioCommandEngage, { attributes = nil, category = Group.Category.SHIP, radioMessageSuffix = "Ships" })

        missionCommands.addCommand("Report contacts", rootPath, radioCommandReportContacts, nil)
        missionCommands.addCommand("Status", rootPath, radioCommandReportStatus, nil)
        missionCommands.addCommand("Go to map marker "..TUM.wingmenTasking.DEFAULT_MARKER_TEXT:upper(), rootPath, radioCommandGoToMapMarker, nil)
        missionCommands.addCommand("Hold", rootPath, radioCommandOrbit, nil)
        missionCommands.addCommand("Rejoin", rootPath, radioCommandRejoin, nil)
    end
end
