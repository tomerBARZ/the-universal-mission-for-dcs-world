Library.aircraft["A-10A"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    liveries = {
        [coalition.side.BLUE] = { "104th FS Maryland ANG, Baltimore (MD)", "118th FS Bradley ANGB, Connecticut (CT)", "118th FS Bradley ANGB, Connecticut (CT) N621", "172nd FS Battle Creek ANGB, Michigan (BC)", "184th FS Arkansas ANG, Fort Smith (FS)", "190th FS Boise ANGB, Idaho (ID)", "23rd TFW England AFB (EL)", "25th FS Osan AB, Korea (OS)", "354th FS Davis Monthan AFB, Arizona (DM)", "355th FS Eielson AFB, Alaska (AK)", "357th FS Davis Monthan AFB, Arizona (DM)", "358th FS Davis Monthan AFB, Arizona (DM)", "422nd TES Nellis AFB, Nevada (OT)", "47th FS Barksdale AFB, Louisiana (BD)", "66th WS Nellis AFB, Nevada (WA)", "74th FS Moody AFB, Georgia (FT)", "81st FS Spangdahlem AB, Germany (SP) 1", "81st FS Spangdahlem AB, Germany (SP) 2", "A-10 Grey" },
        [coalition.side.RED] = { "Fictional Russian Air Force 1", "Fictional Russian Air Force 2", "Algerian AF Fictional Desert", "Algerian AF Fictional Grey" },
    },
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 240,flare = 120,fuel = 5029,ammo_type = 1,gun = 100 },
    pylons = {
        default = {
         [1] = { CLSID = "{DB434044-F5D0-4F1F-9BA9-B73027E18DD3}" },
         [2] = { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },
         [3] = { CLSID = "{69DC8AE7-8F77-427B-B8AA-B19D3F478B66}" },
         [4] = { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },
         [5] = { CLSID = "{AB8B8299-F1CC-4359-89B5-2172E0CF4A5A}" },
         [7] = { CLSID = "{AB8B8299-F1CC-4359-89B5-2172E0CF4A5A}" },
         [8] = { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },
         [9] = { CLSID = "{69DC8AE7-8F77-427B-B8AA-B19D3F478B66}" },
         [10] = { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },
         [11] = { CLSID = "{6D21ECEA-F85B-4E8D-9D51-31DC9B8AA4EF}" },
        }
    }
}
