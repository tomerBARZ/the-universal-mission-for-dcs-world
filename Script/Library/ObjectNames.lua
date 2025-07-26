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

        "SAM tracking radar",
        "SAM launcher",
        "SAM search radar",
        "short-range SAM",
        "AAA",
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
        ["2S6 Tunguska"] = "SA-19",
        ["55G6 EWR"] = "EWR 55G6",
        ["5p73 s-125 ln"] = "SA-3 launcher",
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
        ["ATMZ-5"] = "ATMZ-5 fuel truck",
        ["ATZ-10"] = "ATZ-10 fuel truck",
        ["ATZ-5"] = "ATZ-5 fuel truck",
        ["ATZ-60_Maz"] = "ATZ-60 fuel truck",
        ["AV8BNA"] = "AV-8B",
        ["Allies_Director"] = "Allies Rangefinder",
        ["An-26B"] = "An-26B",
        ["An-30M"] = "An-30M",
        ["B-17G"] = "B-17G",
        ["B-1B"] = "B-1B",
        ["B-52H"] = "B-52H",
        ["B600_drivable"] = "B600 tug",
        ["BDK-775"] = "Ropucha-class landing ship",
        ["BMD-1"] = "BMD-1 IFV",
        ["BMP-1"] = "BMP-1 IFV",
        ["BMP-2"] = "BMP-2 IFV",
        ["BMP-3"] = "BMP-3 IFV",
        ["BRDM-2"] = "BRDM-2 APC",
        ["BTR-80"] = "BTR-80 APC",
        ["BTR-82A"] = "BTR-82A IFV",
        ["BTR_D"] = "BTR-RD APC",
        ["Bedford_MWD"] = "Bedford truck",
        ["Bf-109K-4"] = "Bf 109",
        ["Blitz_36-6700A"] = "Opel Blitz truck",
        ["Boxcartrinity"] = "Flatcar",
        ["Bunker"] = "Bunker",
        ["C-101CC"] = "C-101CC",
        ["C-101EB"] = "C-101EB",
        ["C-130"] = "C-130",
        ["C-17A"] = "C-17A",
        ["C-47"] = "C-47",
        ["CCKW_353"] = "CCKW 353 truck",
        ["CH-47D"] = "CH-47D",
        ["CH-47Fbl1"] = "CH-47F",
        ["CH-53E"] = "CH-53E",
        ["CVN_71"] = "Nimitz-class carrier",
        ["CVN_72"] = "Nimitz-class carrier",
        ["CVN_73"] = "Nimitz-class carrier",
        ["CVN_75"] = "Nimitz-class carrier",
        ["CV_1143_5"] = "Kuznetsov-class carrier",
        ["CastleClass_01"] = "Castle-class ship",
        ["Centaur_IV"] = "Centaur IV tank",
        ["Challenger2"] = "Challenger II MBT",
        ["Chieftain_mk3"] = "Chieftain tank",
        ["Christen Eagle II"] = "Christen Eagle II",
        ["Churchill_VII"] = "Churchill VII tank",
        ["Coach a passenger"] = "passenger car",
        ["Coach a platform"] = "coach",
        ["Coach a tank blue"] = "coach",
        ["Coach a tank yellow"] = "coach",
        ["Coach cargo"] = "freight van",
        ["Coach cargo open"] = "open wagon",
        ["Cobra"] = "Cobra APC",
        ["Cromwell_IV"] = "Cromwell tank",
        ["DRG_Class_86"] = "armored locomotive",
        ["DR_50Ton_Flat_Wagon"] = "armored train wagon",
        ["Daimler_AC"] = "Daimler armoured car",
        ["Dog Ear radar"] = "\"Dog Ear\" search radar",
        ["Dry-cargo ship-1"] = "cargo ship",
        ["Dry-cargo ship-2"] = "cargo ship",
        ["E-2C"] = "E-2D",
        ["E-3A"] = "E-3A",
        ["ELNYA"] = "Altay-class oiler",
        ["ES44AH"] = "locomotive",
        ["Electric locomotive"] = "locomotive",
        ["Elefant_SdKfz_184"] = "Jagdpanzer Elefant",
        ["Essex"] = "Essex-class carrier",
        ["F-117A"] = "F-117A",
        ["F-14A"] = "F-14A",
        ["F-14A-135-GR"] = "F-14A",
        ["F-14B"] = "F-14B",
        ["F-15C"] = "F-15C",
        ["F-15E"] = "F-15E",
        ["F-15ESE"] = "F-15E",
        ["F-16A"] = "F-16A",
        ["F-16A MLU"] = "F-16A",
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
        ["FPS-117"] = "FPS-117 search radar",
        ["FPS-117 Dome"] = "FPS-117 radar dome",
        ["FPS-117 ECS"] = "FPS-117 search radar",
        ["FW-190A8"] = "Fw 190",
        ["FW-190D9"] = "Fw 190",
        ["Falcon_Gyrocopter"] = "gyrocopter",
        ["Flakscheinwerfer_37"] = "Flakscheinwerfer 37",
        ["Forrestal"] = "Forrestal-class carrier",
        ["FuMG-401"] = "Freya radar",
        ["FuSe-65"] = "Würzburg radar",
        ["GAZ-3307"] = "GAZ-3307 truck",
        ["GAZ-3308"] = "GAZ-3308 truck",
        ["GAZ-66"] = "GAZ-66 truck",
        ["GD-20"] = "GD-20 lift truck",
        ["Gepard"] = "Flakpanzer Gepard",
        ["German_covered_wagon_G10"] = "covered wagon",
        ["German_tank_wagon"] = "tank wagon",
        ["Grad-URAL"] = "BM-21 Grad MLRS",
        ["Grad_FDDM"] = "Grad MRL FDDM (FC)", -- TODO
        ["H-6J"] = "H-6J",
        ["HEMTT TFFT"] = "HEMMT TFFT fire truck",
        ["HEMTT_C-RAM_Phalanx"] = "Centurion C-RAM",
        ["HL_B8M1"] = "MLRS HL with B8M1 80mm", -- TODO
        ["HL_DSHK"] = "Scout HL with DSHK 12.7mm", -- TODO
        ["HL_KORD"] = "Scout HL with KORD 12.7mm", -- TODO
        ["HL_ZU-23"] = "SPAAA HL with ZU-23", -- TODO
        ["HQ-7_LN_P"] = "HQ-7 SHORAD",
        ["HQ-7_LN_SP"] = "HQ-7B SHORAD",
        ["HQ-7_STR_SP"] = "HQ-7B SHORAD search radar",
        ["HandyWind"] = "bulker ship",
        ["HarborTug"] = "harbor tug",
        ["Hawk"] = "Hawk",
        ["Hawk cwar"] = "Hawk SAM radar",
        ["Hawk ln"] = "Hawk SAM launcher",
        ["Hawk pcp"] = "Hawk SAM command post",
        ["Hawk sr"] = "Hawk SAM search radar",
        ["Hawk tr"] = "Hawk SAM tracker radar",
        ["Higgins_boat"] = "Higgins landing craft",
        ["Horch_901_typ_40_kfz_21"] = "Horch 901 car",
        ["Hummer"] = "Hummer",
        ["I-16"] = "I-16",
        ["IKARUS Bus"] = "IKARUS-280 bus",
        ["IL-76MD"] = "IL-76MD",
        ["IL-78M"] = "IL-78M",
        ["IMPROVED_KILO"] = "Kilo-class submarine",
        ["Igla manpad INS"] = "SA-18 MANPADS",
        ["Infantry AK"] = "infantry",
        ["Infantry AK Ins"] = "infantry",
        ["Infantry AK ver2"] = "infantry",
        ["Infantry AK ver3"] = "infantry",
        ["J-11A"] = "J-11A",
        ["JF-17"] = "JF-17",
        ["JTAC"] = "JTAC",
        ["JagdPz_IV"] = "Jagdpanzer IV",
        ["Jagdpanther_G1"] = "Jagdpanther",
        ["Ju-88A4"] = "Junkers Ju 88",
        ["KAMAZ Truck"] = "KAMAZ 43101 truck",
        ["KC-135"] = "KC-135",
        ["KC130"] = "KC-130",
        ["KC135MPRS"] = "KC-135MPRS",
        ["KDO_Mod40"] = "AAA Kdo.G.40", -- TODO
        ["KILO"] = "Kilo-class submarine",
        ["KJ-2000"] = "KJ-2000", -- TODO
        ["KS-19"] = "KS-19 AAA",
        ["KUZNECOW"] = "Kuznetsov-class carrier",
        ["Ka-27"] = "Ka-27",
        ["Ka-50"] = "Ka-50",
        ["Ka-50_3"] = "Ka-50",
        ["KrAZ6322"] = "KrAZ-6322 truck",
        ["Kub 1S91 str"] = "SA-6 radar",
        ["Kub 2P25 ln"] = "SA-6 TEL",
        ["Kubelwagen_82"] = "Kübelwagen Jeep",
        ["L-39C"] = "L-39C",
        ["L-39ZA"] = "L-39ZA",
        ["L118_Unit"] = "L118 light gun",
        ["LARC-V"] = "LARC-V truck",
        ["LAV-25"] = "LAV-25 IFV",
        ["LAZ Bus"] = "LAZ-695 bus",
        ["LHA_Tarawa"] = "Tarawa-class landing ship",
        ["LST_Mk2"] = "Landing Ship Tank",
        ["La_Combattante_II"] = "La Combattante-class missile boat",
        ["Land_Rover_101_FC"] = "Land Rover 101 truck",
        ["Land_Rover_109_S3"] = "Land Rover 109 truck",
        ["LeFH_18-40-105"] = "leFH 18 howitzer",
        ["Leclerc"] = "Leclerc MBT",
        ["Leopard-2"] = "Leopard 2 MBT",
        ["Leopard-2A5"] = "Leopard 2 MBT",
        ["Leopard1A3"] = "Leopard MBT",
        ["LiAZ Bus"] = "LiAZ-677 bus",
        ["Locomotive"] = "locomotive",
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
        ["M1A2C_SEP_V3"] = "M1 Abrams MBT",
        ["M1_37mm"] = "M1 37mm AAA",
        ["M2A1-105"] = "M2A1 howitzer",
        ["M2A1_halftrack"] = "M2A1 half-track",
        ["M30_CC"] = "M30 cargo carrier",
        ["M45_Quadmount"] = "M45 quad mount AAA",
        ["M48 Chaparral"] = "M48 Chaparral SAM",
        ["M4A4_Sherman_FF"] = "M4 Sherman tank",
        ["M4_Sherman"] = "M4 Sherman tank",
        ["M4_Tractor"] = "M4 tractor",
        ["M6 Linebacker"] = "Linebacker SAM",
        ["M8_Greyhound"] = "M8 Greyhound scout",
        ["M978 HEMTT Tanker"] = "M978 HEMTT fuel truck",
        ["MAZ-6303"] = "MAZ-6303 truck",
        ["MB-339A"] = "MB-339A",
        ["MB-339APAN"] = "MB-339A",
        ["MCV-80"] = "FV510 Warrior IFV",
        ["MJ-1_drivable"] = "M92 MJ-1 drivable", -- TODO
        ["MLRS"] = "M270 MLRS",
        ["MLRS FDDM"] = "Hummer", -- TODO: weird, check
        ["MOLNIYA"] = "Tarantul-class corvette",
        ["MOSCOW"] = "Slava-class cruiser",
        ["MQ-9 Reaper"] = "MQ-9 Reaper",
        ["MTLB"] = "MTLB APC",
        ["Marder"] = "Marder IFV",
        ["Maschinensatz_33"] = "generator",
        ["MaxxPro_MRAP"] = "MRAP MaxxPro APC",
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
        ["MosquitoFBMkVI"] = "DH.98 Mosquito",
        ["NASAMS_Command_Post"] = "NASAMS SAM CC",
        ["NASAMS_LN_B"] = "NASAMS SAM launcher",
        ["NASAMS_LN_C"] = "NASAMS SAM launcher",
        ["NASAMS_Radar_MPQ64F1"] = "NASAMS SAM search radar",
        ["NEUSTRASH"] = "Neustrashimy-class frigate",
        ["OH-58D"] = "OH-58D",
        ["OH58D"] = "OH-58D",
        ["Osa 9A33 ln"] = "SA-8 SAM",
        ["P-47D-30"] = "P-47D",
        ["P-47D-30bl1"] = "P-47D",
        ["P-47D-40"] = "P-47D",
        ["P-51D"] = "P-51D",
        ["P-51D-30-NA"] = "P-51D",
        ["P20_drivable"] = "M92 P20 drivable", -- TODO
        ["PERRY"] = "Perry-class frigate",
        ["PIOTR"] = "Kirov-class battlecruiser",
        -- TODO: end of the list
        ["PL5EII Loadout"] = "Payload PL-5EII",
        ["PL8 Loadout"] = "Payload PL-8",
        ["PLZ05"] = "PLZ-05",
        ["PT_76"] = "LT PT-76",
        ["Pak40"] = "FH Pak 40 75mm",
        ["Paratrooper AKS-74"] = "Paratrooper AKS",
        ["Paratrooper RPG-16"] = "Paratrooper RPG-16",
        ["Patriot AMG"] = "SAM Patriot CR (AMG AN/MRC-137)",
        ["Patriot ECS"] = "SAM Patriot ECS",
        ["Patriot EPP"] = "SAM Patriot EPP-III",
        ["Patriot cp"] = "SAM Patriot C2 ICC",
        ["Patriot ln"] = "SAM Patriot LN",
        ["Patriot str"] = "SAM Patriot STR",
        ["Predator GCS"] = "MCC Predator UAV CP & GCS",
        ["Predator TrojanSpirit"] = "MCC-COMM Predator UAV CL",
        ["Pz_IV_H"] = "Tk PzIV H",
        ["Pz_V_Panther_G"] = "Tk Panther G (Pz V)",
        ["QF_37_AA"] = "AAA QF 3.7\"",
        ["RD_75"] = "SAM SA-2 S-75 RD-75 Amazonka RF",
        ["REZKY"] = "Frigate 1135M Rezky",
        ["RLS_19J6"] = "SAM SA-5 S-200 ST-68U \"Tin Shield\" SR",
        ["RPC_5N62V"] = "SAM SA-5 S-200 \"Square Pair\" TR",
        ["RQ-1A Predator"] = "MQ-1A Predator",
        ["Roland ADS"] = "SAM Roland ADS",
        ["Roland Radar"] = "SAM Roland EWR",
        ["S-200_Launcher"] = "SAM SA-5 S-200 \"Gammon\" LN",
        ["S-300PS 40B6M tr"] = "SAM SA-10 S-300 \"Grumble\" Flap Lid-A TR",
        ["S-300PS 40B6MD sr"] = "SAM SA-10 S-300 \"Grumble\" Clam Shell SR",
        ["S-300PS 40B6MD sr_19J6"] = "SAM SA-10 S-300 \"Grumble\" Tin Shield SR",
        ["S-300PS 54K6 cp"] = "SAM SA-10 S-300 \"Grumble\" C2",
        ["S-300PS 5H63C 30H6_tr"] = "SAM SA-10 S-300 \"Grumble\" Flap Lid-B TR",
        ["S-300PS 5P85C ln"] = "SAM SA-10 S-300 \"Grumble\" TEL C",
        ["S-300PS 5P85D ln"] = "SAM SA-10 S-300 \"Grumble\" TEL D",
        ["S-300PS 64H6E sr"] = "SAM SA-10 S-300 \"Grumble\" Big Bird SR",
        ["S-3B"] = "S-3B",
        ["S-3B Tanker"] = "S-3B Tanker",
        ["S-60_Type59_Artillery"] = "AAA S-60 57mm",
        ["SA-11 Buk CC 9S470M1"] = "SAM SA-11 Buk \"Gadfly\" C2 ",
        ["SA-11 Buk LN 9A310M1"] = "SAM SA-11 Buk \"Gadfly\" Fire Dome TEL",
        ["SA-11 Buk SR 9S18M1"] = "SAM SA-11 Buk \"Gadfly\" Snow Drift SR",
        ["SA-18 Igla comm"] = "MANPADS SA-18 Igla \"Grouse\" C2",
        ["SA-18 Igla manpad"] = "MANPADS SA-18 Igla \"Grouse\"",
        ["SA-18 Igla-S comm"] = "MANPADS SA-18 Igla-S \"Grouse\" C2",
        ["SA-18 Igla-S manpad"] = "MANPADS SA-18 Igla-S \"Grouse\"",
        ["SA342L"] = "SA342L",
        ["SA342M"] = "SA342M",
        ["SA342Minigun"] = "SA342Minigun",
        ["SA342Mistral"] = "SA342Mistral",
        ["SAU 2-C9"] = "SPM 2S9 Nona 120mm M",
        ["SAU Akatsia"] = "SPH 2S3 Akatsia 152mm",
        ["SAU Gvozdika"] = "SPH 2S1 Gvozdika 122mm",
        ["SAU Msta"] = "SPH 2S19 Msta 152mm",
        ["SD10 Loadout"] = "Payload SD-10",
        ["SH-3W"] = "SH-3W",
        ["SH-60B"] = "SH-60B",
        ["SKP-11"] = "Truck SKP-11 Mobile ATC",
        ["SK_C_28_naval_gun"] = "Gun 15cm SK C/28 Naval in Bunker",
        ["SNR_75V"] = "SAM SA-2 S-75 \"Fan Song\" TR",
        ["SOM"] = "SSK 641B Tango",
        ["SON_9"] = "AAA Fire Can SON-9",
        ["S_75M_Volhov"] = "SAM SA-2 S-75 \"Guideline\" LN",
        ["S_75_ZIL"] = "S-75 Tractor (ZIL-131)",
        ["Sandbox"] = "Bunker 1",
        ["Schnellboot_type_S130"] = "Boat Schnellboot type S130",
        ["Scud_B"] = "SSM SS-1C Scud-B",
        ["Sd_Kfz_2"] = "LUV Kettenrad",
        ["Sd_Kfz_234_2_Puma"] = "Scout Puma AC",
        ["Sd_Kfz_251"] = "APC Sd.Kfz.251 Halftrack",
        ["Sd_Kfz_7"] = "Tractor Sd.Kfz.7 Art'y Tractor",
        ["Seawise_Giant"] = "Tanker Seawise Giant",
        ["Ship_Tilde_Supply"] = "Supply Ship MV Tilde",
        ["Silkworm_SR"] = "AShM Silkworm SR",
        ["Smerch"] = "MLRS 9A52 Smerch CM 300mm",
        ["Smerch_HE"] = "MLRS 9A52 Smerch HE 300mm",
        ["Soldier AK"] = "Infantry AK-74",
        ["Soldier M249"] = "Infantry M249",
        ["Soldier M4"] = "Infantry M4",
        ["Soldier M4 GRG"] = "Infantry M4 Georgia",
        ["Soldier RPG"] = "Infantry RPG",
        ["Soldier stinger"] = "MANPADS Stinger",
        ["SpGH_Dana"] = "SPH Dana vz77 152mm",
        ["SpitfireLFMkIX"] = "Spitfire LF Mk. IX",
        ["SpitfireLFMkIXCW"] = "Spitfire LF Mk. IX CW",
        ["Stennis"] = "CVN-74 John C. Stennis",
        ["Stinger comm"] = "MANPADS Stinger C2",
        ["Stinger comm dsr"] = "MANPADS Stinger C2 Desert",
        ["Strela-1 9P31"] = "SAM SA-9 Strela 1 \"Gaskin\" TEL",
        ["Strela-10M3"] = "SAM SA-13 Strela 10M3 \"Gopher\" TEL",
        ["Stug_III"] = "SPG StuG III G AG",
        ["Stug_IV"] = "SPG StuG IV AG",
        ["SturmPzIV"] = "SPG Brummbaer AG",
        ["Su-17M4"] = "Su-17M4",
        ["Su-24M"] = "Su-24M",
        ["Su-24MR"] = "Su-24MR",
        ["Su-25"] = "Su-25",
        ["Su-25T"] = "Su-25T",
        ["Su-25TM"] = "Su-25TM",
        ["Su-27"] = "Su-27",
        ["Su-30"] = "Su-30",
        ["Su-33"] = "Su-33",
        ["Su-34"] = "Su-34",
        ["Suidae"] = "Suidae",
        ["T-55"] = "MBT T-55",
        ["T-72B"] = "MBT T-72B",
        ["T-72B3"] = "MBT T-72B3",
        ["T-80UD"] = "MBT T-80U",
        ["T-90"] = "MBT T-90",
        ["T155_Firtina"] = "SPH T155 Firtina 155mm",
        ["TACAN_beacon"] = "Beacon TACAN Portable TTS 3030",
        ["TF-51D"] = "TF-51D",
        ["TICONDEROG"] = "CG Ticonderoga",
        ["TPZ"] = "APC TPz Fuchs ",
        ["TYPE-59"] = "MT Type 59",
        ["TZ-22_KrAZ"] = "Refueler TZ-22 Tractor (KrAZ-258B1)",
        ["Tankcartrinity"] = "Tank Cartrinity",
        ["Tetrarch"] = "Tk Tetrach",
        ["Tiger_I"] = "Tk Tiger 1",
        ["Tiger_II_H"] = "Tk Tiger II",
        ["Tigr_233036"] = "LUV Tigr",
        ["Tor 9A331"] = "SAM SA-15 Tor \"Gauntlet\"",
        ["Tornado GR4"] = "Tornado GR4",
        ["Tornado IDS"] = "Tornado IDS",
        ["Trolley bus"] = "ZIU-9 Trolley",
        ["Tu-142"] = "Tu-142",
        ["Tu-160"] = "Tu-160",
        ["Tu-22M3"] = "Tu-22M3",
        ["Tu-95MS"] = "Tu-95MS",
        ["TugHarlan_drivable"] = "M92 Tug Harlan drivable",
        ["Type_052B"] = "Type 052B Destroyer",
        ["Type_052C"] = "Type 052C Destroyer",
        ["Type_054A"] = "Type 054A Frigate",
        ["Type_071"] = "Type 071 Amphibious Transport Dock",
        ["Type_093"] = "Type 093 Attack Submarine",
        ["Type_3_80mm_AA"] = "AAA 80mm Type 3 Flak",
        ["Type_88_75mm_AA"] = "AAA 75mm Type 88 Flak",
        ["Type_89_I_Go"] = "Tk Type 89 I Go",
        ["Type_94_25mm_AA_Truck"] = "AAA 25mm x 2 Type 94 Truck",
        ["Type_94_Truck"] = "Truck Type 94",
        ["Type_96_25mm_AA"] = "AAA 25mm x 2 Type 96",
        ["Type_98_Ke_Ni"] = "Tk Type 98 Ke Ni",
        ["Type_98_So_Da"] = "APC Type 98 So Da",
        ["UAZ-469"] = "LUV UAZ-469 Jeep",
        ["UH-1H"] = "UH-1H",
        ["UH-60A"] = "UH-60A",
        ["USS_Arleigh_Burke_IIa"] = "DDG Arleigh Burke IIa",
        ["USS_Samuel_Chase"] = "LS Samuel Chase",
        ["Uboat_VIIC"] = "U-boat VIIC U-flak",
        ["Uragan_BM-27"] = "MLRS 9K57 Uragan BM-27 220mm",
        ["Ural ATsP-6"] = "Firefighter Ural ATsP-6",
        ["Ural-375"] = "Truck Ural-4320",
        ["Ural-375 PBU"] = "Truck Ural-4320 MCC",
        ["Ural-375 ZU-23"] = "AAA ZU-23 on Ural-4320",
        ["Ural-375 ZU-23 Insurgent"] = "AAA ZU-23 on Ural-4320 Insurgent",
        ["Ural-4320 APA-5D"] = "GPU APA-5D on Ural 4320",
        ["Ural-4320-31"] = "Truck Ural-4320-31 Arm'd",
        ["Ural-4320T"] = "Truck Ural-4320T",
        ["VAB_Mephisto"] = "ATGM VAB Mephisto",
        ["VAZ Car"] = "Car VAZ-2109",
        ["VINSON"] = "CVN-70 Carl Vinson",
        ["Vulcan"] = "SPAAA Vulcan M163",
        ["Wellcarnsc"] = "Well Car",
        ["Wespe124"] = "SPH Sd.Kfz.124 Wespe 105mm",
        ["Willys_MB"] = "Car Willys Jeep",
        ["WingLoong-I"] = "WingLoong-I",
        ["Yak-40"] = "Yak-40",
        ["Yak-52"] = "Yak-52",
        ["ZBD04A"] = "ZBD-04A",
        ["ZIL-131 KUNG"] = "Truck ZIL-131 (C2)",
        ["ZIL-135"] = "Truck ZIL-135",
        ["ZIL-4331"] = "Truck ZIL-4331",
        ["ZSU-23-4 Shilka"] = "SPAAA ZSU-23-4 Shilka \"Gun Dish\"",
        ["ZSU_57_2"] = "SPAAA ZSU-57-2",
        ["ZTZ96B"] = "ZTZ-96B",
        ["ZU-23 Closed Insurgent"] = "AAA ZU-23 Insurgent Closed Emplacement",
        ["ZU-23 Emplacement"] = "AAA ZU-23 Emplacement",
        ["ZU-23 Emplacement Closed"] = "AAA ZU-23 Closed Emplacement",
        ["ZU-23 Insurgent"] = "AAA ZU-23 Insurgent Emplacement",
        ["ZWEZDNY"] = "Boat Zvezdny type",
        ["ZiL-131 APA-80"] = "GPU APA-80 on ZIL-131",
        ["ara_vdm"] = "ARA Veinticinco de Mayo",
        ["atconveyor"] = "SS Atlantic Conveyor",
        ["bofors40"] = "AAA Bofors 40mm",
        ["fire_control"] = "Bunker with Fire Control Center",
        ["flak18"] = "AAA 8,8cm Flak 18",
        ["flak30"] = "AAA Flak 38 20mm",
        ["flak36"] = "AAA 8,8cm Flak 36",
        ["flak37"] = "AAA 8,8cm Flak 37",
        ["flak38"] = "AAA Flak-Vierling 38 Quad 20mm",
        ["flak41"] = "AAA 8,8cm Flak 41",
        ["generator_5i57"] = "Diesel Power Station 5I57A",
        ["hms_invincible"] = "HMS Invincible (R05)",
        ["house1arm"] = "Barracks armed",
        ["house2arm"] = "Watch tower armed",
        ["houseA_arm"] = "Building armed",
        ["hy_launcher"] = "AShM SS-N-2 Silkworm",
        ["leander-gun-achilles"] = "HMS Achilles (F12)",
        ["leander-gun-andromeda"] = "HMS Andromeda (F57)",
        ["leander-gun-ariadne"] = "HMS Ariadne (F72)",
        ["leander-gun-condell"] = "CNS Almirante Condell (PFG-06)",
        ["leander-gun-lynch"] = "CNS Almirante Lynch (PFG-07)",
        ["leopard-2A4"] = "MBT Leopard-2A4",
        ["leopard-2A4_trs"] = "MBT Leopard-2A4 Trs",
        ["outpost"] = "Outpost",
        ["outpost_road"] = "Road outpost",
        ["outpost_road_l"] = "Road outpost_L",
        ["outpost_road_r"] = "Road outpost-R",
        ["p-19 s-125 sr"] = "SAM SA-2/3/5 P19 \"Flat Face\" SR ",
        ["r11_volvo_drivable"] = "M92 R11 Volvo drivable",
        ["rapier_fsa_blindfire_radar"] = "SAM Rapier Blindfire TR",
        ["rapier_fsa_launcher"] = "SAM Rapier LN",
        ["rapier_fsa_optical_tracker_unit"] = "SAM Rapier Tracker",
        ["santafe"] = "ARA Santa Fe S-21",
        ["snr s-125 tr"] = "SAM SA-3 S-125 \"Low Blow\" TR",
        ["soldier_mauser98"] = "Infantry Mauser 98",
        ["soldier_wwii_br_01"] = "Infantry SMLE No.4 Mk-1",
        ["soldier_wwii_us"] = "Infantry M1 Garand",
        ["speedboat"] = "Boat Armed Hi-speed",
        ["tacr2a"] = "Firefighter RAF Rescue",
        ["tt_B8M1"] = "MLRS LC with B8M1 80mm",
        ["tt_DSHK"] = "Scout LC with DSHK 12.7mm",
        ["tt_KORD"] = "Scout LC with KORD 12.7mm",
        ["tt_ZU-23"] = "SPAAA LC with ZU-23",
        ["v1_launcher"] = "V-1 Launch Ramp"
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
                elseif obj:hasAttribute("SR SAM") then
                    return "short-range SAM"
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
            if DCSEx.table.contains(unitNames) then
                groupName = n
                break
            end
        end
        if not groupName then return "unknown" end

        if groupName == "SAM search radar" or groupName == "SAM launcher" or groupName == "SAM tracking radar" then
            return "SAM vehicle"
        end

        return groupName
    end
end