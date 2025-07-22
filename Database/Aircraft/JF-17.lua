Library.aircraft["JF-17"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 36,flare = 32,fuel = 2325,gun = 100 },
    properties = { AARProbe = false,LaserCode100 = 6,LaserCode10 = 8,LaserCode1 = 8 },
    pylons = {
        default = {
         [1] = { CLSID = "DIS_PL-5EII" },
         [2] = { CLSID = "DIS_GBU_12_DUAL" },
         [3] = { CLSID = "DIS_LS_6_500" },
         [4] = { CLSID = "DIS_WMD7" },
         [5] = { CLSID = "DIS_LS_6_500" },
         [6] = { CLSID = "DIS_GBU_12_DUAL" },
         [7] = { CLSID = "DIS_PL-5EII" },
         -- Payload.Decade2000.Task.SEAD.Pylon01=DIS_PL-5EII
         -- Payload.Decade2000.Task.SEAD.Pylon02=DIS_LD-10_DUAL_L
         -- Payload.Decade2000.Task.SEAD.Pylon03=DIS_TANK1100
         -- Payload.Decade2000.Task.SEAD.Pylon04=DIS_SPJ_POD
         -- Payload.Decade2000.Task.SEAD.Pylon05=DIS_TANK1100
         -- Payload.Decade2000.Task.SEAD.Pylon06=DIS_LD-10_DUAL_R
         -- Payload.Decade2000.Task.SEAD.Pylon07=DIS_PL-5EII
         -- Payload.Decade2000.Task.Antiship.Pylon01=DIS_PL-5EII
         -- Payload.Decade2000.Task.Antiship.Pylon02=DIS_C-701IR
         -- Payload.Decade2000.Task.Antiship.Pylon03=DIS_C-802AK
         -- Payload.Decade2000.Task.Antiship.Pylon04=DIS_TANK800
         -- Payload.Decade2000.Task.Antiship.Pylon05=DIS_C-802AK
         -- Payload.Decade2000.Task.Antiship.Pylon06=DIS_C-701IR
         -- Payload.Decade2000.Task.Antiship.Pylon07=DIS_PL-5EII
         -- Payload.Decade2000.Task.AirToAir.Pylon01=DIS_PL-5EII
         -- Payload.Decade2000.Task.AirToAir.Pylon02=DIS_SD-10
         -- Payload.Decade2000.Task.AirToAir.Pylon03=DIS_TANK1100
         -- Payload.Decade2000.Task.AirToAir.Pylon04=DIS_TANK800
         -- Payload.Decade2000.Task.AirToAir.Pylon05=DIS_TANK1100
         -- Payload.Decade2000.Task.AirToAir.Pylon06=DIS_SD-10
         -- Payload.Decade2000.Task.AirToAir.Pylon07=DIS_PL-5EII
        }
    }
}
