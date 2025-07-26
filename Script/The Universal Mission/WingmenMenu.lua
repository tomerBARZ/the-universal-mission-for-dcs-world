-- ====================================================================================
-- TUM.WINGMENMENU - HANDLES THE WINGMEN'S F10 MENU
-- ====================================================================================
-- ====================================================================================

TUM.wingmenMenu = {}

do
    local function radioCommandCoverMe(args)
        local player = world:getPlayer()
        if not player then return end

        TUM.radio.playForAll("playerWingmanCoverMe"..args.radioMessageSuffix, nil, player:getCallsign(), false)

        TUM.wingmenTasking.commandEngage(Group.Category.AIRPLANE, { "Fighters", "Interceptors", "Multirole fighters" } , true)
    end

    local function radioCommandEngage(args)
        local player = world:getPlayer()
        if not player then return end

        args.radioTargetName = args.radioTargetName or "hostile"

        TUM.radio.playForAll("playerWingmanEngage"..args.radioMessageSuffix, { args.radioTargetName }, player:getCallsign(), false)
        TUM.wingmenTasking.commandEngage(args.category, args.attributes, true)
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

    local function radioCommandReportContacts()
        local player = world:getPlayer()
        if not player then return false end
        TUM.radio.playForAll("playerWingmanReportContacts", nil, player:getCallsign(), false)

        TUM.wingmenTasking.commandReportContacts(nil, false, true)
    end

    local function radioCommandReportStatus()
        local player = world:getPlayer()
        if not player then return end
        TUM.radio.playForAll("playerWingmanReportStatus", nil, player:getCallsign(), false)

        TUM.wingmenTasking.commandReportStatus(true)
    end

    function TUM.wingmenMenu.create()
        if TUM.settings.getValue(TUM.settings.id.MULTIPLAYER) then return end -- No wingmen in multiplayer
        -- TODO: if WINGMEN_COUNT == 0 then return end

        local rootPath = missionCommands.addSubMenu("✈ Flight")
        missionCommands.addCommand("Cover me!", rootPath, radioCommandCoverMe, nil)

        local isWW2 = (TUM.settings.getValue(TUM.settings) == DCSEx.enums.timePeriod.WORLD_WAR_2)

        ------------------------------------------------------
        -- "Engage targets" submenu
        ------------------------------------------------------
        local engagePath = missionCommands.addSubMenu("Engage", rootPath)
        local engageSubPath = nil

        -- Aircraft -- (radioTargetName must be plural)
        engageSubPath = missionCommands.addSubMenu("Aircraft", engagePath)
        missionCommands.addCommand("Any aircraft", engageSubPath, radioCommandEngage, { attributes = nil, category = Group.Category.AIRPLANE, radioMessageSuffix = "Bandits", radioTargetName = "bandits" })
        missionCommands.addCommand("Fighters", engageSubPath, radioCommandEngage, { attributes = { "Fighters", "Interceptors", "Multirole fighters" }, category = Group.Category.AIRPLANE, radioMessageSuffix = "Bandits", radioTargetName = "fighters" })
        missionCommands.addCommand("Bombers and transports", engageSubPath, radioCommandEngage, { attributes = nil, category = Group.Category.AIRPLANE, radioMessageSuffix = "Bandits", radioTargetName = "strategic aircraft" })
        if not isWW2 then
            missionCommands.addCommand("Helicopters", engageSubPath, radioCommandEngage, { attributes = nil, category = Group.Category.HELICOPTER, radioMessageSuffix = "Bandits", radioTargetName = "helos" })
        end

        -- Ground -- (radioTargetName must be singular)
        engageSubPath = missionCommands.addSubMenu("Ground", engagePath)
        missionCommands.addCommand("Any ground", engageSubPath, radioCommandEngage, { attributes = {"Tanks", "Trucks", "Artillery", "IFV", "APC"}, category = Group.Category.GROUND, radioMessageSuffix = "Ground", radioTargetName = "ground" })
        missionCommands.addCommand("Armor", engageSubPath, radioCommandEngage, { attributes = {"Tanks", "IFV", "APC"}, category = Group.Category.GROUND, radioMessageSuffix = "Ground", radioTargetName = "armor" })
        missionCommands.addCommand("Artillery", engageSubPath, radioCommandEngage, { attributes = {"Artillery"}, category = Group.Category.GROUND, radioMessageSuffix = "Ground", radioTargetName = "artillery" })
        missionCommands.addCommand("Trucks", engageSubPath, radioCommandEngage, { attributes = {"Trucks"}, category = Group.Category.GROUND, radioMessageSuffix = "Ground", radioTargetName = "unarmed" })

        -- Air defense -- (radioTargetName must be singular)
        engageSubPath = missionCommands.addSubMenu("Air defense", engagePath)
        missionCommands.addCommand("Any air defense", engageSubPath, radioCommandEngage, { attributes = { "Air Defence" }, category = Group.Category.GROUND, radioMessageSuffix = "AirDefense", radioTargetName = "air defense" })
        missionCommands.addCommand("AAA", engageSubPath, radioCommandEngage, { attributes = { "AAA" }, category = Group.Category.GROUND, radioMessageSuffix = "AirDefense", radioTargetName = "AAA" })
        if not isWW2 then
            missionCommands.addCommand("MANPADS", engageSubPath, radioCommandEngage, { attributes = { "SR SAM", "IR Guided SAM" }, category = Group.Category.GROUND, radioMessageSuffix = "AirDefense", radioTargetName = "MANPADS" })
            missionCommands.addCommand("Short range SAMs", engageSubPath, radioCommandEngage, { attributes = { "SR SAM", "IR Guided SAM" }, category = Group.Category.GROUND, radioMessageSuffix = "AirDefense", radioTargetName = "SHORAD" })
            missionCommands.addCommand("Long-range SAMs", engageSubPath, radioCommandEngage, { attributes = { "LR SAM", "MR SAM" }, category = Group.Category.GROUND, radioMessageSuffix = "AirDefense", radioTargetName = "HIMAD" })
        end

        -- Ships -- (radioTargetName must be plural)
        engageSubPath = missionCommands.addSubMenu("Ships", engagePath)
        missionCommands.addCommand("Any ship", engageSubPath, radioCommandEngage, { attributes = nil, category = Group.Category.SHIP, radioMessageSuffix = "Ships", radioTargetName = "ships" })
        missionCommands.addCommand("Armed ships", engageSubPath, radioCommandEngage, { attributes = { "Armed ships" }, category = Group.Category.SHIP, radioMessageSuffix = "Ships", radioTargetName = "armed ships" })
        missionCommands.addCommand("Cargo ships", engageSubPath, radioCommandEngage, { attributes = { "Unarmed ships" }, category = Group.Category.SHIP, radioMessageSuffix = "Ships", radioTargetName = "cargo ships" })
        ------------------------------------------------------

        missionCommands.addCommand("Report contacts", rootPath, radioCommandReportContacts, nil)
        missionCommands.addCommand("Status", rootPath, radioCommandReportStatus, nil)
        missionCommands.addCommand("Go to map marker "..TUM.wingmenTasking.DEFAULT_MARKER_TEXT:upper(), rootPath, radioCommandGoToMapMarker, nil)
        missionCommands.addCommand("Hold", rootPath, radioCommandOrbit, nil)
        missionCommands.addCommand("Rejoin", rootPath, radioCommandRejoin, nil)
    end
end
