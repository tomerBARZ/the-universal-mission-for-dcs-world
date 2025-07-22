Library.aircraft["AJS37"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 105,flare = 36,fuel = 4476,gun = 100 },
    properties = { Rb04GroupTarget = 3, WeapSafeHeight = 1, Rb04VinkelHopp = 0, MissionGeneratorSetting = 0 },
    pylons = {
        default = {
         [2] = { CLSID = "{Robot74}" },
         [3] = { CLSID = "{RB75T}" },
         [4] = { CLSID = "{VIGGEN_X-TANK}" },
         [5] = { CLSID = "{RB75T}" },
         [6] = { CLSID = "{Robot74}" },
        }
    }
    -- Payload.Decade2000.Task.AirToAir.pylon02={Robot74}
    -- Payload.Decade2000.Task.AirToAir.pylon03={Robot05}
    -- Payload.Decade2000.Task.AirToAir.pylon04={VIGGEN_X-TANK}
    -- Payload.Decade2000.Task.AirToAir.pylon05={Robot05}
    -- Payload.Decade2000.Task.AirToAir.pylon06={Robot74}
    -- Payload.Decade2000.Task.Antiship.pylon02={RB75T}
    -- Payload.Decade2000.Task.Antiship.pylon03={RB75T}
    -- Payload.Decade2000.Task.Antiship.pylon04={VIGGEN_X-TANK}
    -- Payload.Decade2000.Task.Antiship.pylon05={RB75T}
    -- Payload.Decade2000.Task.Antiship.pylon06={RB75T}
}
