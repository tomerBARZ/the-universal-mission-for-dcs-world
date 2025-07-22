Library.aircraft["F-14B"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 140,flare = 60,fuel = 7348 },
    properties = { LGB100 = 6, M61BURST = 0, IlsChannel = 1, LGB1 = 8, KY28Key = 1, TacanBand = 0, TacanChannel = 0, LGB1000 = 1, LGB10 = 8, INSAlignmentStored = true, UseLAU138 = true, ALE39Loadout = 0 },
    pylons = {
        default = {
         [1] = { CLSID = "{LAU-138 wtip - AIM-9M}" },
         [2] = { CLSID = "{SHOULDER AIM_54A_Mk47 L}" },
         [3] = { CLSID = "{F14-300gal}" },
         [4] = { CLSID = "{AIM_54A_Mk47}" },
         [5] = { CLSID = "{AIM_54A_Mk47}" },
         [6] = { CLSID = "{AIM_54A_Mk47}" },
         [7] = { CLSID = "{AIM_54A_Mk47}" },
         [8] = { CLSID = "{F14-300gal}" },
         [9] = { CLSID = "{SHOULDER AIM_54A_Mk47 R}" },
         [10] = { CLSID = "{LAU-138 wtip - AIM-9M}" },
         -- Payload.Decade2000.Task.AirToGround.Pylon04={BRU-32 MK-84}
         -- Payload.Decade2000.Task.AirToGround.Pylon05={BRU-32 MK-84}
         -- Payload.Decade2000.Task.AirToGround.Pylon06={BRU-32 MK-84}
         -- Payload.Decade2000.Task.AirToGround.Pylon07={BRU-32 MK-84}
        }
    }
}
