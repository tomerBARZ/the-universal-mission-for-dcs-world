Library.aircraft["L-39C"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 0,flare = 0,fuel = 823.2,gun = 100 },
    pylons = {
        default = {
         [1] = { CLSID = "{UB-16-57UMP}" },
         [2] = { CLSID = "{FB3CE165-BF07-4979-887C-92B87F13276B}" },
         [4] = { CLSID = "{FB3CE165-BF07-4979-887C-92B87F13276B}" },
         [5] = { CLSID = "{UB-16-57UMP}" },
         -- Payload.Decade2000.Task.AirToAir.Pylon01={APU-60-1_R_60M}
         -- Payload.Decade2000.Task.AirToAir.Pylon02={PK-3}
         -- Payload.Decade2000.Task.AirToAir.Pylon04={PK-3}
         -- Payload.Decade2000.Task.AirToAir.Pylon05={APU-60-1_R_60M}
        }
    }
}
