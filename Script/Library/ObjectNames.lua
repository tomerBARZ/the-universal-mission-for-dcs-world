Library.objectNames = {}

do
    local GROUP_PRIORITY = { -- lower in the list means higher priority
        "carrier",
        "submarine",
        "warship",
        "missile boat",
        "armed ship",
        "cargo ship",
        "speedboat",
        "ship",

        "interceptor",
        "fighter",
        "bomber",
        "AWACS",
        "tanker",
        "transport",
        "UAV",
        "aircraft",

        "attack helicopter",
        "transport helicopter",
        "helicopter",

        "IR SAM",
        "SHORAD",
        "AAA",
        "SAM tracking radar",
        "SAM search radar",
        "SAM launcher",
        "air defense",

        "artillery",
        "armor",
        "truck",
        "vehicle",

        "MANPADS",
        "infantry",

        "structure",
        "building",

        "unknown"
    }

    local namesTable = {
        ["1L13 EWR"] = "EWR 1L13",
        ["2B11 mortar"] = "Mortar 2B11 120mm",
        ["2S6 Tunguska"] = "SA-19 \"Tunguska\"",
        ["55G6 EWR"] = "EWR 55G6",
        ["5p73 s-125 ln"] = "SA-3 \"Goa\" launcher",
        ["A-10A"] = "A-10A",
        ["A-10C"] = "A-10C",
        ["A-10C_2"] = "A-10C",
        ["A-20G"] = "A-20G",
        ["A-50"] = "A-50",
        ["AA8"] = "fire truck",
        ["AAV7"] = "AAV-7",
        ["AH-1W"] = "AH-1W",
        ["AH-64A"] = "AH-64A",
        ["AH-64D"] = "AH-64D",
        ["AH-64D_BLK_II"] = "AH-64D",
        ["AJS37"] = "AJS37",
        ["ALBATROS"] = "Grisha-class corvette",
        ["Allies_Director"] = "Allies Rangefinder",
        ["An-26B"] = "An-26B",
        ["An-30M"] = "An-30M",
        ["ara_vdm"] = "Colossus-class aircraft carrier",
        ["atconveyor"] = "container ship",
        ["ATMZ-5"] = "ATMZ-5 fuel truck",
        ["ATZ-10"] = "ATZ-10 fuel truck",
        ["ATZ-5"] = "ATZ-5 fuel truck",
        ["ATZ-60_Maz"] = "ATZ-60 fuel truck",
        ["AV8BNA"] = "AV-8B",
        ["B-17G"] = "B-17G",
        ["B-1B"] = "B-1B",
        ["B-52H"] = "B-52H",
        ["B600_drivable"] = "B600 tug",
        ["BDK-775"] = "Ropucha-class landing ship",
        ["Bedford_MWD"] = "Bedford truck",
        ["Bf-109K-4"] = "Bf 109",
        ["Blitz_36-6700A"] = "Opel Blitz truck",
        ["BMD-1"] = "BMD-1 IFV",
        ["BMP-1"] = "BMP-1 IFV",
        ["BMP-2"] = "BMP-2 IFV",
        ["BMP-3"] = "BMP-3 IFV",
        ["bofors40"] = "Bofors 40mm AAA",
        ["Boxcartrinity"] = "Flatcar",
        ["BRDM-2"] = "BRDM-2 APC",
        ["BTR-80"] = "BTR-80 APC",
        ["BTR-82A"] = "BTR-82A IFV",
        ["BTR_D"] = "BTR-RD APC",
        ["Bunker"] = "Bunker",
        ["C-101CC"] = "C-101CC",
        ["C-101EB"] = "C-101EB",
        ["C-130"] = "C-130",
        ["C-17A"] = "C-17A",
        ["C-47"] = "C-47",
        ["CastleClass_01"] = "Castle-class ship",
        ["CCKW_353"] = "CCKW 353 truck",
        ["Centaur_IV"] = "Centaur IV tank",
        ["CH-47D"] = "CH-47D",
        ["CH-47Fbl1"] = "CH-47F",
        ["CH-53E"] = "CH-53E",
        ["Challenger2"] = "Challenger II MBT",
        ["Chieftain_mk3"] = "Chieftain tank",
        ["Christen Eagle II"] = "Christen Eagle II",
        ["Churchill_VII"] = "Churchill VII tank",
        ["Coach a passenger"] = "passenger car",
        ["Coach a platform"] = "coach",
        ["Coach a tank blue"] = "coach",
        ["Coach a tank yellow"] = "coach",
        ["Coach cargo open"] = "open wagon",
        ["Coach cargo"] = "freight van",
        ["Cobra"] = "Cobra APC",
        ["Cromwell_IV"] = "Cromwell tank",
        ["CV_1143_5"] = "Kuznetsov-class carrier",
        ["CVN_71"] = "Nimitz-class carrier",
        ["CVN_72"] = "Nimitz-class carrier",
        ["CVN_73"] = "Nimitz-class carrier",
        ["CVN_75"] = "Nimitz-class carrier",
        ["Daimler_AC"] = "Daimler armoured car",
        ["Dog Ear radar"] = "\"Dog Ear\" search radar",
        ["DR_50Ton_Flat_Wagon"] = "armored train wagon",
        ["DRG_Class_86"] = "armored locomotive",
        ["Dry-cargo ship-1"] = "cargo ship",
        ["Dry-cargo ship-2"] = "cargo ship",
        ["E-2C"] = "E-2D",
        ["E-3A"] = "E-3A",
        ["Electric locomotive"] = "locomotive",
        ["Elefant_SdKfz_184"] = "Jagdpanzer Elefant",
        ["ELNYA"] = "Altay-class oiler",
        ["ES44AH"] = "locomotive",
        ["Essex"] = "Essex-class carrier",
        ["F-117A"] = "F-117A",
        ["F-14A"] = "F-14A",
        ["F-14A-135-GR"] = "F-14A",
        ["F-14B"] = "F-14B",
        ["F-15C"] = "F-15C",
        ["F-15E"] = "F-15E",
        ["F-15ESE"] = "F-15E",
        ["F-16A MLU"] = "F-16A",
        ["F-16A"] = "F-16A",
        ["F-16C bl.50"] = "F-16C",
        ["F-16C bl.52d"] = "F-16C",
        ["F-16C_50"] = "F-16C",
        ["F-4E"] = "F-4E",
        ["F-4E-45MC"] = "F-4E",
        ["F-5E"] = "F-5E",
        ["F-5E-3"] = "F-5E",
        ["F-5E-3_FC"] = "F-5E",
        ["F-86F Sabre"] = "F-86F",
        ["F-86F_FC"] = "F-86F",
        ["F/A-18A"] = "F/A-18A",
        ["F/A-18C"] = "F/A-18C",
        ["F4U-1D"] = "F4U Corsair",
        ["F4U-1D_CW"] = "F4U Corsair",
        ["FA-18C_hornet"] = "F/A-18C",
        ["Falcon_Gyrocopter"] = "gyrocopter",
        ["fire_control"] = "Bunker with Fire Control Center",
        ["flak18"] = "Flak 18 AAA",
        ["flak30"] = "Flak 38 AAA",
        ["flak36"] = "Flak 36 AAA",
        ["flak37"] = "Flak 37 AAA",
        ["flak38"] = "Flak-Vierling 38 AAA",
        ["flak41"] = "Flak 41 AAA",
        ["Flakscheinwerfer_37"] = "Flakscheinwerfer 37",
        ["Forrestal"] = "Forrestal-class carrier",
        ["FPS-117 Dome"] = "FPS-117 radar dome",
        ["FPS-117 ECS"] = "FPS-117 search radar",
        ["FPS-117"] = "FPS-117 search radar",
        ["FuMG-401"] = "Freya radar",
        ["FuSe-65"] = "Würzburg radar",
        ["FW-190A8"] = "Fw 190",
        ["FW-190D9"] = "Fw 190",
        ["GAZ-3307"] = "GAZ-3307 truck",
        ["GAZ-3308"] = "GAZ-3308 truck",
        ["GAZ-66"] = "GAZ-66 truck",
        ["GD-20"] = "GD-20 lift truck",
        ["generator_5i57"] = "diesel power station",
        ["Gepard"] = "Flakpanzer Gepard",
        ["German_covered_wagon_G10"] = "covered wagon",
        ["German_tank_wagon"] = "tank wagon",
        ["Grad-URAL"] = "BM-21 Grad MLRS",
        ["Grad_FDDM"] = "BM-21 Grad fire direction data manager",
        ["H-6J"] = "H-6J",
        ["HandyWind"] = "bulker ship",
        ["HarborTug"] = "harbor tug",
        ["Hawk cwar"] = "Hawk SAM radar",
        ["Hawk ln"] = "Hawk SAM launcher",
        ["Hawk pcp"] = "Hawk SAM command post",
        ["Hawk sr"] = "Hawk SAM search radar",
        ["Hawk tr"] = "Hawk SAM tracker radar",
        ["Hawk"] = "Hawk",
        ["HEMTT TFFT"] = "HEMMT TFFT fire truck",
        ["HEMTT_C-RAM_Phalanx"] = "Centurion C-RAM",
        ["Higgins_boat"] = "Higgins landing craft",
        ["HL_B8M1"] = "MLRS on technical",
        ["HL_DSHK"] = "technical",
        ["HL_KORD"] = "technical",
        ["HL_ZU-23"] = "ZU-23 AAA on technical",
        ["hms_invincible"] = "Invincible-class aircraft carrier",
        ["Horch_901_typ_40_kfz_21"] = "Horch 901 car",
        ["house1arm"] = "barracks",
        ["house2arm"] = "watch tower",
        ["houseA_arm"] = "building",
        ["HQ-7_LN_P"] = "HQ-7 SHORAD",
        ["HQ-7_LN_SP"] = "HQ-7B SHORAD",
        ["HQ-7_STR_SP"] = "HQ-7B SHORAD search radar",
        ["Hummer"] = "Hummer",
        ["hy_launcher"] = "Silkworm missile",
        ["I-16"] = "I-16",
        ["Igla manpad INS"] = "MANPADS",
        ["IKARUS Bus"] = "IKARUS-280 bus",
        ["IL-76MD"] = "IL-76MD",
        ["IL-78M"] = "IL-78M",
        ["IMPROVED_KILO"] = "Kilo-class submarine",
        ["Infantry AK Ins"] = "infantry",
        ["Infantry AK ver2"] = "infantry",
        ["Infantry AK ver3"] = "infantry",
        ["Infantry AK"] = "infantry",
        ["J-11A"] = "J-11A",
        ["Jagdpanther_G1"] = "Jagdpanther",
        ["JagdPz_IV"] = "Jagdpanzer IV",
        ["JF-17"] = "JF-17",
        ["JTAC"] = "JTAC",
        ["Ju-88A4"] = "Junkers Ju 88",
        ["Ka-27"] = "Ka-27",
        ["Ka-50"] = "Ka-50",
        ["Ka-50_3"] = "Ka-50",
        ["KAMAZ Truck"] = "KAMAZ 43101 truck",
        ["KC-135"] = "KC-135",
        ["KC130"] = "KC-130",
        ["KC135MPRS"] = "KC-135MPRS",
        ["KDO_Mod40"] = "Kommandogerät 40 AAA radar",
        ["KILO"] = "Kilo-class submarine",
        ["KJ-2000"] = "KJ-2000",
        ["KrAZ6322"] = "KrAZ-6322 truck",
        ["KS-19"] = "KS-19 AAA",
        ["Kub 1S91 str"] = "SA-6 \"Kub\" radar",
        ["Kub 2P25 ln"] = "SA-6 \"Kub\" launcher",
        ["Kubelwagen_82"] = "Kübelwagen Jeep",
        ["KUZNECOW"] = "Kuznetsov-class carrier",
        ["L-39C"] = "L-39C",
        ["L-39ZA"] = "L-39ZA",
        ["L118_Unit"] = "L118 light gun",
        ["La_Combattante_II"] = "La Combattante-class missile boat",
        ["Land_Rover_101_FC"] = "Land Rover 101 truck",
        ["Land_Rover_109_S3"] = "Land Rover 109 truck",
        ["LARC-V"] = "LARC-V truck",
        ["LAV-25"] = "LAV-25 IFV",
        ["LAZ Bus"] = "LAZ-695 bus",
        ["leander-gun-achilles"] = "Leander-class frigate",
        ["leander-gun-andromeda"] = "Leander-class frigate",
        ["leander-gun-ariadne"] = "Leander-class frigate",
        ["leander-gun-condell"] = "Condell-class frigate",
        ["leander-gun-lynch"] = "Duke-class frigate",
        ["Leclerc"] = "Leclerc MBT",
        ["LeFH_18-40-105"] = "leFH 18 howitzer",
        ["Leopard-2"] = "Leopard 2 MBT",
        ["leopard-2A4"] = "Leopard 2 MBT",
        ["leopard-2A4_trs"] = "Leopard 2 MBT",
        ["Leopard-2A5"] = "Leopard 2 MBT",
        ["Leopard1A3"] = "Leopard MBT",
        ["LHA_Tarawa"] = "Tarawa-class landing ship",
        ["LiAZ Bus"] = "LiAZ-677 bus",
        ["Locomotive"] = "locomotive",
        ["LST_Mk2"] = "Landing Ship Tank",
        ["M 818"] = "M939 truck",
        ["M-1 Abrams"] = "M1 Abrams MBT",
        ["M-109"] = "M109 Paladin howitzer",
        ["M-113"] = "M113 APC",
        ["M-2 Bradley"] = "M2 Bradley IFV",
        ["M-2000C"] = "Mirage 2000C",
        ["M-60"] = "M60 Patton MBT",
        ["M1043 HMMWV Armament"] = "Humvee",
        ["M1045 HMMWV TOW"] = "Humvee",
        ["M1097 Avenger"] = "Avenger SAM",
        ["M10_GMC"] = "M10 tank destroyer",
        ["M1126 Stryker ICV"] = "Stryker IFV",
        ["M1128 Stryker MGS"] = "Stryker mobile gun",
        ["M1134 Stryker ATGM"] = "Stryker ATGM",
        ["M12_GMC"] = "M12 gun motor carriage",
        ["M1_37mm"] = "M1 37mm AAA",
        ["M1A2C_SEP_V3"] = "M1 Abrams MBT",
        ["M2A1-105"] = "M2A1 howitzer",
        ["M2A1_halftrack"] = "M2A1 half-track",
        ["M30_CC"] = "M30 cargo carrier",
        ["M45_Quadmount"] = "M45 quad mount AAA",
        ["M48 Chaparral"] = "M48 Chaparral SAM",
        ["M4_Sherman"] = "M4 Sherman tank",
        ["M4_Tractor"] = "M4 tractor",
        ["M4A4_Sherman_FF"] = "M4 Sherman tank",
        ["M6 Linebacker"] = "Linebacker SAM",
        ["M8_Greyhound"] = "M8 Greyhound scout",
        ["M978 HEMTT Tanker"] = "M978 HEMTT fuel truck",
        ["Marder"] = "Marder IFV",
        ["Maschinensatz_33"] = "generator",
        ["MaxxPro_MRAP"] = "MRAP MaxxPro APC",
        ["MAZ-6303"] = "MAZ-6303 truck",
        ["MB-339A"] = "MB-339A",
        ["MB-339APAN"] = "MB-339A",
        ["MCV-80"] = "FV510 Warrior IFV",
        ["Merkava_Mk4"] = "Merkava IV MBT",
        ["Mi-24P"] = "Mi-24P",
        ["Mi-24V"] = "Mi-24V",
        ["Mi-26"] = "Mi-26",
        ["Mi-28N"] = "Mi-28N",
        ["Mi-8MT"] = "Mi-8MT",
        ["MiG-15bis"] = "MiG-15bis",
        ["MiG-15bis_FC"] = "MiG-15bis",
        ["MiG-19P"] = "MiG-19P",
        ["MiG-21Bis"] = "MiG-21Bis",
        ["MiG-23MLD"] = "MiG-23MLD",
        ["MiG-25PD"] = "MiG-25PD",
        ["MiG-25RBT"] = "MiG-25RBT",
        ["MiG-27K"] = "MiG-27K",
        ["MiG-29A"] = "MiG-29A",
        ["MiG-29G"] = "MiG-29G",
        ["MiG-29S"] = "MiG-29S",
        ["MiG-31"] = "MiG-31",
        ["Mirage 2000-5"] = "Mirage 2000-5",
        ["Mirage-F1AD"] = "Mirage F1AD",
        ["Mirage-F1AZ"] = "Mirage F1AZ",
        ["Mirage-F1B"] = "Mirage F1B",
        ["Mirage-F1BD"] = "Mirage F1BD",
        ["Mirage-F1BE"] = "Mirage F1BE",
        ["Mirage-F1BQ"] = "Mirage F1BQ",
        ["Mirage-F1C"] = "Mirage F1C",
        ["Mirage-F1C-200"] = "Mirage F1C-200",
        ["Mirage-F1CE"] = "Mirage F1CE",
        ["Mirage-F1CG"] = "Mirage F1CG",
        ["Mirage-F1CH"] = "Mirage F1CH",
        ["Mirage-F1CJ"] = "Mirage F1CJ",
        ["Mirage-F1CK"] = "Mirage F1CK",
        ["Mirage-F1CR"] = "Mirage F1CR",
        ["Mirage-F1CT"] = "Mirage F1CT",
        ["Mirage-F1CZ"] = "Mirage F1CZ",
        ["Mirage-F1DDA"] = "Mirage F1DDA",
        ["Mirage-F1ED"] = "Mirage F1ED",
        ["Mirage-F1EDA"] = "Mirage F1EDA",
        ["Mirage-F1EE"] = "Mirage F1EE",
        ["Mirage-F1EH"] = "Mirage F1EH",
        ["Mirage-F1EQ"] = "Mirage F1EQ",
        ["Mirage-F1JA"] = "Mirage F1JA",
        ["Mirage-F1M-CE"] = "Mirage F1M",
        ["Mirage-F1M-EE"] = "Mirage F1M",
        ["MJ-1_drivable"] = "tug",
        ["MLRS FDDM"] = "Hummer",
        ["MLRS"] = "M270 MLRS",
        ["MOLNIYA"] = "Tarantul-class corvette",
        ["MOSCOW"] = "Slava-class cruiser",
        ["MosquitoFBMkVI"] = "DH.98 Mosquito",
        ["MQ-9 Reaper"] = "MQ-9 Reaper",
        ["MTLB"] = "MTLB APC",
        ["NASAMS_Command_Post"] = "NASAMS SAM CC",
        ["NASAMS_LN_B"] = "NASAMS SAM launcher",
        ["NASAMS_LN_C"] = "NASAMS SAM launcher",
        ["NASAMS_Radar_MPQ64F1"] = "NASAMS SAM search radar",
        ["NEUSTRASH"] = "Neustrashimy-class frigate",
        ["OH-58D"] = "OH-58D",
        ["OH58D"] = "OH-58D",
        ["Osa 9A33 ln"] = "SA-8 \"Gecko\"",
        ["outpost"] = "outpost",
        ["outpost_road"] = "outpost",
        ["outpost_road_l"] = "outpost",
        ["outpost_road_r"] = "outpost",
        ["p-19 s-125 sr"] = "\"Flat Face\" SAM search radar",
        ["P-47D-30"] = "P-47D",
        ["P-47D-30bl1"] = "P-47D",
        ["P-47D-40"] = "P-47D",
        ["P-51D"] = "P-51D",
        ["P-51D-30-NA"] = "P-51D",
        ["P20_drivable"] = "M92 truck",
        ["Pak40"] = "Pak40 antitank gun",
        ["Paratrooper AKS-74"] = "paratrooper",
        ["Paratrooper RPG-16"] = "paratrooper",
        ["Patriot AMG"] = "Patriot SAM antenna mast group",
        ["Patriot cp"] = "Patriot SAM command post",
        ["Patriot ECS"] = "Patriot SAM engagement control station",
        ["Patriot EPP"] = "Patriot SAM electric power plant",
        ["Patriot ln"] = "Patriot SAM launcher",
        ["Patriot str"] = "Patriot SAM search and tracking radar",
        ["PERRY"] = "Perry-class frigate",
        ["PIOTR"] = "Kirov-class battlecruiser",
        ["PL5EII Loadout"] = "PL-5EII missile",
        ["PL8 Loadout"] = "PL-8 missile",
        ["PLZ05"] = "PLZ-05 howitzer",
        ["Predator GCS"] = "Predator control station",
        ["Predator TrojanSpirit"] = "Predator control link",
        ["PT_76"] = "PT-76 light tank",
        ["Pz_IV_H"] = "Panzer IV tank",
        ["Pz_V_Panther_G"] = "Panzer V tank",
        ["QF_37_AA"] = "3.7-inch AA gun",
        ["r11_volvo_drivable"] = "truck",
        ["rapier_fsa_blindfire_radar"] = "Rapier SAM tracking radar",
        ["rapier_fsa_launcher"] = "Rapier SAM launcher",
        ["rapier_fsa_optical_tracker_unit"] = "Rapier SAM optical tracker",
        ["RD_75"] = "SA-2 \"Guideline\" rangefinder radar",
        ["REZKY"] = "Gnevny-class destroyer",
        ["RLS_19J6"] = "SA-5 \"Gammon\" search radar",
        ["Roland ADS"] = "Roland SAM",
        ["Roland Radar"] = "Roland SAM early-warning radar",
        ["RPC_5N62V"] = "SA-5 \"Gammon\" tracking radar",
        ["RQ-1A Predator"] = "MQ-1A Predator",
        ["S-200_Launcher"] = "SA-5 \"Gammon\" launcher",
        ["S-300PS 40B6M tr"] = "SA-10 (S-300) tracking radar",
        ["S-300PS 40B6MD sr"] = "SA-10 (S-300)  search radar",
        ["S-300PS 40B6MD sr_19J6"] = "SA-10 (S-300) search radar",
        ["S-300PS 54K6 cp"] = "SA-10 (S-300) command post",
        ["S-300PS 5H63C 30H6_tr"] = "SA-10 (S-300) tracking radar",
        ["S-300PS 5P85C ln"] = "SA-10 (S-300) launcher",
        ["S-300PS 5P85D ln"] = "SA-10 (S-300) launcher",
        ["S-300PS 64H6E sr"] = "SA-10 (S-300) search radar",
        ["S-3B Tanker"] = "S-3B",
        ["S-3B"] = "S-3B",
        ["S-60_Type59_Artillery"] = "S-60 57mm AAA",
        ["S_75_ZIL"] = "S-75 truck",
        ["S_75M_Volhov"] = "SA-2 \"Guideline\" launcher",
        ["SA-11 Buk CC 9S470M1"] = "SA-11 \"Buk\" command post",
        ["SA-11 Buk LN 9A310M1"] = "SA-11 \"Buk\" launcher",
        ["SA-11 Buk SR 9S18M1"] = "SA-11 \"Buk\" search radar",
        ["SA-18 Igla comm"] = "MANPADS",
        ["SA-18 Igla manpad"] = "MANPADS",
        ["SA-18 Igla-S comm"] = "MANPADS",
        ["SA-18 Igla-S manpad"] = "MANPADS",
        ["SA342L"] = "SA342L",
        ["SA342M"] = "SA342M",
        ["SA342Minigun"] = "SA342",
        ["SA342Mistral"] = "SA342",
        ["Sandbox"] = "Bunker",
        ["santafe"] = "Balao-class submarine",
        ["SAU 2-C9"] = "2S9 Nona mortar",
        ["SAU Akatsia"] = "2S3 Akatsia howitzer",
        ["SAU Gvozdika"] = "2S1 Gvozdika howitzer",
        ["SAU Msta"] = "2S19 Msta howitzer",
        ["Schnellboot_type_S130"] = "Schnellboot S130",
        ["Scud_B"] = "SS-1 Scud missile",
        ["SD10 Loadout"] = "SD-10 missile",
        ["Sd_Kfz_2"] = "Kettenrad motorcycle",
        ["Sd_Kfz_234_2_Puma"] = "Sd.Kfz. 234 armoured car",
        ["Sd_Kfz_251"] = "Sd.Kfz.251 Halftrack",
        ["Sd_Kfz_7"] = "Sd.Kfz.7 tractor",
        ["Seawise_Giant"] = "bulk tanker",
        ["SH-3W"] = "SH-3W",
        ["SH-60B"] = "SH-60B",
        ["Ship_Tilde_Supply"] = "supply ship",
        ["Silkworm_SR"] = "Silkworm missile search radar",
        ["SK_C_28_naval_gun"] = "SK C/28 naval gun",
        ["SKP-11"] = "SKP-11 truck",
        ["Smerch"] = "BM-30 Smerch MLRS",
        ["Smerch_HE"] = "BM-30 Smerch MLRS",
        ["snr s-125 tr"] = "SA-3 \"Goa\" tracking radar",
        ["SNR_75V"] = "SA-2 \"Guideline\" tracking radar",
        ["Soldier AK"] = "infantry",
        ["Soldier M249"] = "infantry",
        ["Soldier M4 GRG"] = "infantry",
        ["Soldier M4"] = "infantry",
        ["Soldier RPG"] = "infantry",
        ["Soldier stinger"] = "MANPADS",
        ["soldier_mauser98"] = "infantry",
        ["soldier_wwii_br_01"] = "infantry",
        ["soldier_wwii_us"] = "infantry",
        ["SOM"] = "Tango-class submarine",
        ["SON_9"] = "SON-9 AAA radar",
        ["speedboat"] = "speedboat",
        ["SpGH_Dana"] = "Dana howitzer",
        ["SpitfireLFMkIX"] = "Spitfire",
        ["SpitfireLFMkIXCW"] = "Spitfire",
        ["Stennis"] = "Nimitz-class carrier",
        ["Stinger comm dsr"] = "MANPADS",
        ["Stinger comm"] = "MANPADS",
        ["Strela-1 9P31"] = "SA-9 \"Strela\" launcher",
        ["Strela-10M3"] = "SA-13 \"Gopher\" launcher",
        ["Stug_III"] = "Sturmgeschütz III assault gun",
        ["Stug_IV"] = "Sturmgeschütz IV assault gun",
        ["SturmPzIV"] = "Sturmpanzer heavy assault gun",
        ["Su-17M4"] = "Su-17M",
        ["Su-24M"] = "Su-24M",
        ["Su-24MR"] = "Su-24MR",
        ["Su-25"] = "Su-25",
        ["Su-25T"] = "Su-25T",
        ["Su-25TM"] = "Su-25TM",
        ["Su-27"] = "Su-27",
        ["Su-30"] = "Su-30",
        ["Su-33"] = "Su-33",
        ["Su-34"] = "Su-34",
        ["Suidae"] = "Suidae", -- TODO: what is this thing???
        ["T-55"] = "T-55 MBT",
        ["T-72B"] = "T-72B MBT",
        ["T-72B3"] = "T-72B MBT",
        ["T-80UD"] = "T-80U MBT",
        ["T-90"] = "T-90 MBT",
        ["T155_Firtina"] = "T-155 Firtina howitzer",
        ["TACAN_beacon"] = "portable TACAN beacon",
        ["tacr2a"] = "fire truck",
        ["Tankcartrinity"] = "Cartrinity truck",
        ["Tetrarch"] = "Tetrach tank",
        ["TF-51D"] = "TF-51D",
        ["TICONDEROG"] = "Ticonderoga-class cruiser",
        ["Tiger_I"] = "Tiger I tank",
        ["Tiger_II_H"] = "Tiger II tank",
        ["Tigr_233036"] = "Tigr IFV",
        ["Tor 9A331"] = "SA-15 \"Tor\" launcher",
        ["Tornado GR4"] = "Tornado GR4",
        ["Tornado IDS"] = "Tornado IDS",
        ["TPZ"] = "Transportpanzer Fuchs APC",
        ["Trolley bus"] = "ZIU-9 trolleybus",
        ["tt_B8M1"] = "MLRS on technical",
        ["tt_DSHK"] = "technical",
        ["tt_KORD"] = "technical",
        ["tt_ZU-23"] = "ZU-23 AAA on technical",
        ["Tu-142"] = "Tu-142",
        ["Tu-160"] = "Tu-160",
        ["Tu-22M3"] = "Tu-22M3",
        ["Tu-95MS"] = "Tu-95MS",
        ["TugHarlan_drivable"] = "M92 tug",
        ["TYPE-59"] = "Type 59 MBT",
        ["Type_052B"] = "Type 052B destroyer",
        ["Type_052C"] = "Type 052C destroyer",
        ["Type_054A"] = "Type 054A frigate",
        ["Type_071"] = "Type 071 amphibious transport dock",
        ["Type_093"] = "Type 093 submarine",
        ["Type_3_80mm_AA"] = "Type 3 80mm Flak",
        ["Type_88_75mm_AA"] = "Type 88 Flak",
        ["Type_89_I_Go"] = "Type 89 I Go tank",
        ["Type_94_25mm_AA_Truck"] = "Type 94 AAA",
        ["Type_94_Truck"] = "Truck Type 94",
        ["Type_96_25mm_AA"] = "Type 96 25mm AAA",
        ["Type_98_Ke_Ni"] = "Type 98 Ke Ni tank",
        ["Type_98_So_Da"] = "Type 98 So Da APC",
        ["TZ-22_KrAZ"] = "TZ-22 fuel truck",
        ["UAZ-469"] = "UAZ-469 jeep",
        ["Uboat_VIIC"] = "VIIC U-boat",
        ["UH-1H"] = "UH-1H",
        ["UH-60A"] = "UH-60A",
        ["Uragan_BM-27"] = "BM-27 Uragan MLRS",
        ["Ural ATsP-6"] = "Ural ATsP-6 fire truck",
        ["Ural-375 PBU"] = "Ural-4320 truck",
        ["Ural-375 ZU-23 Insurgent"] = "ZU-23 AAA",
        ["Ural-375 ZU-23"] = "ZU-23 AAA",
        ["Ural-375"] = "Ural-4320 truck",
        ["Ural-4320 APA-5D"] = "Ural 4320 truck",
        ["Ural-4320-31"] = "Ural-4320 truck",
        ["Ural-4320T"] = "Ural-4320 truck",
        ["USS_Arleigh_Burke_IIa"] = "Arleigh Burke-class destroyer",
        ["USS_Samuel_Chase"] = "Arthur Middleton-class attack transport",
        ["v1_launcher"] = "V-1 launch ramp",
        ["VAB_Mephisto"] = "Mephisto tank hunter",
        ["VAZ Car"] = "car",
        ["VINSON"] = "CVN-70 Carl Vinson",
        ["Vulcan"] = "M163 Vulcan AAA",
        ["Wellcarnsc"] = "railroad car",
        ["Wespe124"] = "Sd.Kfz. 124 self propelled gun",
        ["Willys_MB"] = "Willys MB jeep",
        ["WingLoong-I"] = "WingLoong-I UAV",
        ["Yak-40"] = "Yak-40",
        ["Yak-52"] = "Yak-52",
        ["ZBD04A"] = "ZBD-04A IFV",
        ["ZiL-131 APA-80"] = "ZIL-131 truck",
        ["ZIL-131 KUNG"] = "ZIL-131 truck",
        ["ZIL-135"] = "ZIL-135 truck",
        ["ZIL-4331"] = "ZIL-4331 truck",
        ["ZSU-23-4 Shilka"] = "ZSU-23-4 AAA",
        ["ZSU_57_2"] = "ZSU-57-2 AAA",
        ["ZTZ96B"] = "Type 96B MBT",
        ["ZU-23 Closed Insurgent"] = "ZU-23 AAA emplacement",
        ["ZU-23 Emplacement Closed"] = "ZU-23 AAA emplacement",
        ["ZU-23 Emplacement"] = "ZU-23 AAA emplacement",
        ["ZU-23 Insurgent"] = "ZU-23 AAA emplacement",
        ["ZWEZDNY"] = "civilian boat"
    }

    function Library.objectNames.get(obj)
        if not obj then return "nothing" end

        -- First, try to find a custom name in the names table
        local typeName = obj:getTypeName()
        if typeName and namesTable[typeName] then
            return namesTable[typeName]
        end

        -- Else, try to find a display name in the description
        local desc = obj:getDesc()
        if desc and desc.DisplayName then
            return desc.DisplayName
        end

        -- If nothing else was found, return the internal typename
        if not typeName then return "unknown" end
        return typeName
    end

    function Library.objectNames.getGeneric(obj, imprecise)
        imprecise = imprecise or false
        if not obj then return "nothing" end

        if Object.getCategory(obj) == Object.Category.SCENERY then
            return DCSEx.table.getRandom({"building", "structure"})
        elseif Object.getCategory(obj) == Object.Category.STATIC then
            return DCSEx.table.getRandom({"building", "structure"})
        elseif Object.getCategory(obj) == Object.Category.UNIT then
            local objDesc = obj:getDesc()

            if objDesc.category == Unit.Category.AIRPLANE then
                if imprecise then return "aircraft" end

                if obj:hasAttribute("AWACS") then
                    return "AWACS"
                elseif obj:hasAttribute("Tankers") then
                    return "tanker"
                elseif obj:hasAttribute("Transports") then
                    return "transport"
                elseif obj:hasAttribute("Bombers") then
                    return "bomber"
                elseif obj:hasAttribute("Multirole fighters") or obj:hasAttribute("Fighters") then
                    return "fighter"
                elseif obj:hasAttribute("Interceptors") then
                    return "interceptor"
                elseif obj:hasAttribute("UAVs") then
                    return "UAV"
                else
                    return "aircraft"
                end
            elseif objDesc.category == Unit.Category.HELICOPTER then
                if imprecise then return "helicopter" end

                if obj:hasAttribute("Attack helicopters") then
                    return "attack helicopter"
                elseif obj:hasAttribute("Transport helicopters") then
                    return "transport helicopter"
                else
                    return "helicopter"
                end
            elseif objDesc.category == Unit.Category.GROUND_UNIT then
                if imprecise then
                    if obj:hasAttribute("Infantry") then
                        return "infantry"
                    else
                        return "vehicle"
                    end
                end

                if obj:hasAttribute("MANPADS") then
                    return "MANPADS"
                elseif obj:hasAttribute("Infantry") then
                    return "infantry"
                elseif obj:hasAttribute("IR Guided SAM") then
                    return "IR SAM"
                elseif obj:hasAttribute("SR SAM") then
                    return "SHORAD"
                elseif obj:hasAttribute("SAM SR") then
                    return "SAM search radar"
                elseif obj:hasAttribute("SAM TR") then
                    return "SAM tracking radar"
                elseif obj:hasAttribute("SAM LL") then
                    return "SAM launcher"
                elseif obj:hasAttribute("AAA") then
                    return "AAA"
                elseif obj:hasAttribute("Air Defence") then
                    return "air defense"
                elseif obj:hasAttribute("Artillery") then
                    return "artillery"
                elseif obj:hasAttribute("Armored vehicles") then
                    return "armor"
                elseif obj:hasAttribute("Trucks") then
                    return "truck"
                else
                    return "vehicle"
                end
            elseif objDesc.category == Unit.Category.SHIP then
                if obj:getTypeName() == "speedboat" then return "speedboat" end
                if imprecise then return "ship" end

                if obj:hasAttribute("Submarines") then
                    return "submarine"
                elseif obj:hasAttribute("Aircraft Carriers") then
                    return "carrier"
                elseif obj:hasAttribute("Heavy armed ships") then
                    return "warship"
                elseif obj:hasAttribute("Light armed ships") then
                    if (TUM.settings.getValue(TUM.settings.id.TIME_PERIOD, DCSEx.enums.timePeriod.WORLD_WAR_2)) then
                        return "armed ship"
                    else
                        return "missile boat"
                    end
                elseif obj:hasAttribute("Unarmed ships") then
                    return "cargo ship"
                else
                    return "ship"
                end
            elseif objDesc.category == Unit.Category.STRUCTURE then
                return DCSEx.table.getRandom({"building", "structure"})
            end
        end

        return "unknown"
    end

    function Library.objectNames.getGenericGroup(grp, imprecise)
        if not grp then return "nothing" end

        -- Establish a list of all unit names
        local unitNames = {}
        for _,u in ipairs(grp:getUnits()) do
            table.insert(unitNames, Library.objectNames.getGeneric(u, imprecise))
        end
        if #unitNames == 0 then return "unknown" end

        -- Pick the unit name highest in priority
        local groupName = nil
        for _,n in ipairs(GROUP_PRIORITY) do
            if DCSEx.table.contains(unitNames, n) then
                groupName = n
                break
            end
        end
        if not groupName then return "unknown" end

        if groupName == "SAM search radar" or groupName == "SAM launcher" or groupName == "SAM tracking radar" then
            return "SAM element"
        end

        return groupName
    end
end