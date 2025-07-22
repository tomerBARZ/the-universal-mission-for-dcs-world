Library.aircraft["F-86F Sabre"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 0,flare = 0,fuel = 1282,gun = 100 },
    pylons = {
        default = {
         [4] = { CLSID = "{PTB_120_F86F35}" },
         [5] = { CLSID = "{GAR-8}" },
         [6] = { CLSID = "{GAR-8}" },
         [7] = { CLSID = "{PTB_120_F86F35}" },
         -- Payload.Decade2000.Task.AirToGround.Pylon01={PTB_200_F86F35}
         -- Payload.Decade2000.Task.AirToGround.Pylon04={F86ANM64}
         -- Payload.Decade2000.Task.AirToGround.Pylon07={F86ANM64}
         -- Payload.Decade2000.Task.AirToGround.Pylon10={PTB_200_F86F35}
        }
    }
}
