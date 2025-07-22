Library.aircraft["P-47D-30"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(225),
    payload = { chaff = 0,flare = 0,fuel = 557.76,gun = 100,ammo_type = 1 },
    properties = { WaterTankContents = 1 },
    pylons = {
        default = {
         [2] = { CLSID = "{US_150GAL_FUEL_TANK}" },
         [3] = { CLSID = "{US_150GAL_FUEL_TANK}" },
         -- Payload.Decade2000.Task.AirToGround.Pylon01={US_110GAL_FUEL_TANK}
         -- Payload.Decade2000.Task.AirToGround.Pylon02={AN-M64}
         -- Payload.Decade2000.Task.AirToGround.Pylon03={AN-M64}
        }
    }
}
