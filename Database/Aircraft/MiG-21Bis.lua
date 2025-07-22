Library.aircraft["MiG-21Bis"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 18,flare = 40,fuel = 2280,ammo_type = 1,gun = 100 },
    pylons = {
        default = {
         [1] = { CLSID = "{R-60 2L}" },
         [2] = { CLSID = "{R-3R}" },
         [3] = { CLSID = "{PTB_800_MIG21}" },
         [4] = { CLSID = "{R-3R}" },
         [5] = { CLSID = "{R-60 2R}" },
         [6] = { CLSID = "{ASO-2}" },
         -- Payload.Decade2000.Task.AirToGround.Pylon01={3C612111-C7AD-476E-8A8E-2485812F4E5C}
         -- Payload.Decade2000.Task.AirToGround.Pylon02={UB-32_S5M}
         -- Payload.Decade2000.Task.AirToGround.Pylon03={PTB_800_MIG21}
         -- Payload.Decade2000.Task.AirToGround.Pylon04={UB-32_S5M}
         -- Payload.Decade2000.Task.AirToGround.Pylon05={3C612111-C7AD-476E-8A8E-2485812F4E5C}
         -- Payload.Decade2000.Task.AirToGround.Pylon06={ASO-2}
        }
    }
}
