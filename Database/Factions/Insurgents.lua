do
    Library.factions.tables["Insurgents"] = {}
    Library.factions.tables["Insurgents"].theaters = {}
    Library.factions.tables["Insurgents"].timePeriods = {}

    Library.factions.tables["Insurgents"].units = {}

    Library.factions.tables["Insurgents"].units[DCSEx.enums.timePeriod.WORLD_WAR_2] = {}
    Library.factions.tables["Insurgents"].units[DCSEx.enums.timePeriod.KOREA_WAR] = {}
    Library.factions.tables["Insurgents"].units[DCSEx.enums.timePeriod.VIETNAM_WAR] = {}
    Library.factions.tables["Insurgents"].units[DCSEx.enums.timePeriod.COLD_WAR] = {}

    Library.factions.tables["Insurgents"].units[DCSEx.enums.timePeriod.MODERN] = {
        [DCSEx.enums.unitFamily.AIRDEFENSE_AAA_MOBILE] = { "HL_ZU-23", "tt_ZU-23" },
        [DCSEx.enums.unitFamily.AIRDEFENSE_AAA_STATIC] = { "ZU-23 Closed Insurgent", "ZU-23 Insurgent" },
        [DCSEx.enums.unitFamily.AIRDEFENSE_MANPADS] = { "Igla manpad INS", "SA-18 Igla-S manpad" },
        [DCSEx.enums.unitFamily.AIRDEFENSE_SAM_LONG] = { "*SA-2" },
        [DCSEx.enums.unitFamily.AIRDEFENSE_SAM_MEDIUM] = { "*SA-2", "*SA-3" },
        [DCSEx.enums.unitFamily.AIRDEFENSE_SAM_SHORT] = { "Osa 9A33 ln", "Tor 9A331" },
        [DCSEx.enums.unitFamily.AIRDEFENSE_SAM_SHORT_IR] = { "Strela-1 9P31" },

        [DCSEx.enums.unitFamily.GROUND_APC] = { "HL_DSHK", "HL_KORD", "tt_DSHK", "tt_KORD", "BMD-1", "BMP-1", "Boman", "BRDM-2", "BTR_D", "BTR-80" },
        [DCSEx.enums.unitFamily.GROUND_ARTILLERY] = { "Grad-URAL", "SAU 2-C9", "SAU Akatsia", "SAU Gvozdika", "SAU Msta", "Smerch", "SpGH_Dana", "Uragan_BM-27" },
        [DCSEx.enums.unitFamily.GROUND_INFANTRY] = { "Infantry AK Ins" },
        [DCSEx.enums.unitFamily.GROUND_MBT] = { "T-55", "T-72B" },
        [DCSEx.enums.unitFamily.GROUND_SS_MISSILE] = { "Scud_B" },
        [DCSEx.enums.unitFamily.GROUND_UNARMED] = { "Land_Rover_101_FC", "Land_Rover_109_S3", "Ural-375", "Ural-4320 APA-5D", "Ural-4320T" },

        [DCSEx.enums.unitFamily.HELICOPTER_ATTACK] = { "Mi-24V", "Mi-28N" },
        [DCSEx.enums.unitFamily.HELICOPTER_TRANSPORT] = { "Mi-8MT", "Mi-26" },

        [DCSEx.enums.unitFamily.PLANE_ATTACK] = { "Su-25" },
        [DCSEx.enums.unitFamily.PLANE_AWACS] = { "A-50" },
        [DCSEx.enums.unitFamily.PLANE_BOMBER] = { "Tu-22M3" },
        [DCSEx.enums.unitFamily.PLANE_FIGHTER] = { "MiG-21Bis" },
        [DCSEx.enums.unitFamily.PLANE_TANKER] = { "IL-78M" },
        [DCSEx.enums.unitFamily.PLANE_TRANSPORT] = { "An-26B" },
        [DCSEx.enums.unitFamily.PLANE_UAV] = { "WingLoong-I" },

        [DCSEx.enums.unitFamily.SHIP_CARGO] = { "Dry-cargo ship-1", "Dry-cargo ship-2", "ELNYA", "Ship_Tilde_Supply" },
        [DCSEx.enums.unitFamily.SHIP_CARRIER] = { "KUZNECOW" },
        [DCSEx.enums.unitFamily.SHIP_CRUISER] = { "MOSCOW", "PIOTR" },
        [DCSEx.enums.unitFamily.SHIP_FRIGATE] = { "leander-gun-andromeda", "leander-gun-ariadne", "leander-gun-condell", "leander-gun-lynch" },
        [DCSEx.enums.unitFamily.SHIP_LIGHT] = { "speedboat" },
        [DCSEx.enums.unitFamily.SHIP_MISSILE_BOAT] = { "ALBATROS", "BDK-775", "MOLNIYA" },
        [DCSEx.enums.unitFamily.SHIP_SUBMARINE] = { "KILO", "SOM" },

        -- [DCSEx.enums.unitFamily.STATIC_STRUCTURE] = { "af_hq", ".Command Center", "Building01_PBR", "Building02_PBR", "Building03_PBR", "Building04_PBR", "Building05_PBR", "Bunker", "Chemical tank A", "Comms tower M", "FARP Fuel Depot", "outpost", "Sandbox", "Workshop A" },
        [DCSEx.enums.unitFamily.STATIC_STRUCTURE] = { "af_hq", ".Command Center", "Building01_PBR", "Building02_PBR", "Building03_PBR", "Building04_PBR", "Building05_PBR", "Chemical tank A", "Comms tower M", "FARP Fuel Depot", "outpost", "Workshop A" },
    }
end
