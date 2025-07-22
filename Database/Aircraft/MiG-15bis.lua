Library.aircraft["MiG-15bis"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 0,flare = 0,fuel = 1172,gun = 100 },
    pylons = {
        default = {
         [1] = { CLSID = "{PTB600_MIG15}" },
         [2] = { CLSID = "{PTB600_MIG15}" },
         -- Payload.Decade2000.Task.AirToGround.Pylon01={FAB_50}
         -- Payload.Decade2000.Task.AirToGround.Pylon02={FAB_50}
        }
    }
}
