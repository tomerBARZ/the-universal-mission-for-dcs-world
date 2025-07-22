Library.aircraft["A-10C"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    liveries = {
        [coalition.side.BLUE] = { "104th FS Maryland ANG, Baltimore (MD)", "118th FS Bradley ANGB, Connecticut (CT)", "118th FS Bradley ANGB, Connecticut (CT) N621", "172nd FS Battle Creek ANGB, Michigan (BC)", "184th FS Arkansas ANG, Fort Smith (FS)", "190th FS Boise ANGB, Idaho (ID)", "23rd TFW England AFB (EL)", "25th FS Osan AB, Korea (OS)", "354th FS Davis Monthan AFB, Arizona (DM)", "355th FS Eielson AFB, Alaska (AK)", "357th FS Davis Monthan AFB, Arizona (DM)", "358th FS Davis Monthan AFB, Arizona (DM)", "422nd TES Nellis AFB, Nevada (OT)", "47th FS Barksdale AFB, Louisiana (BD)", "66th WS Nellis AFB, Nevada (WA)", "74th FS Moody AFB, Georgia (FT)", "81st FS Spangdahlem AB, Germany (SP) 1", "81st FS Spangdahlem AB, Germany (SP) 2", "A-10 Grey" },
        [coalition.side.RED] = { "Fictional Russian Air Force 1", "Fictional Russian Air Force 2", "Algerian AF Fictional Desert", "Algerian AF Fictional Grey" },
    },
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 240,flare = 120,fuel = 5029,ammo_type = 1,gun = 100 },
    pylons = {
        default = {
         [1] = { CLSID = "ALQ_184" },
         [3] = { CLSID = "{E6A6262A-CA08-4B3D-B030-E1A993B98452}" },
         [4] = { CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}" },
         [5] = { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },
         [7] = { CLSID = "{GBU-38}" },
         [8] = { CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}" },
         [9] = { CLSID = "{E6A6262A-CA08-4B3D-B030-E1A993B98453}" },
         [10] = { CLSID = "{A111396E-D3E8-4b9c-8AC9-2432489304D5}" },
         [11] = { CLSID = "{DB434044-F5D0-4F1F-9BA9-B73027E18DD3}" },
        }
    }
}
