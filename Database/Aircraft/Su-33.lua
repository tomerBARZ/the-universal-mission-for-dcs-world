Library.aircraft["Su-33"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 48,flare = 48,fuel = 9500,gun = 100 },
    pylons = {
        default = {
         [1] = { CLSID = "{FBC29BFE-3D24-4C64-B81D-941239D12249}" },
         [2] = { CLSID = "{FBC29BFE-3D24-4C64-B81D-941239D12249}" },
         [3] = { CLSID = "{9B25D316-0434-4954-868F-D51DB1A38DF0}" },
         [4] = { CLSID = "{E8069896-8435-4B90-95C0-01A03AE6E400}" },
         [5] = { CLSID = "{E8069896-8435-4B90-95C0-01A03AE6E400}" },
         [6] = { CLSID = "{E8069896-8435-4B90-95C0-01A03AE6E400}" },
         [7] = { CLSID = "{E8069896-8435-4B90-95C0-01A03AE6E400}" },
         [8] = { CLSID = "{E8069896-8435-4B90-95C0-01A03AE6E400}" },
         [9] = { CLSID = "{E8069896-8435-4B90-95C0-01A03AE6E400}" },
         [10] = { CLSID = "{9B25D316-0434-4954-868F-D51DB1A38DF0}" },
         [11] = { CLSID = "{FBC29BFE-3D24-4C64-B81D-941239D12249}" },
         [12] = { CLSID = "{FBC29BFE-3D24-4C64-B81D-941239D12249}" },
         -- Payload.Decade2000.Task.AirToGround.Pylon01={FBC29BFE-3D24-4C64-B81D-941239D12249}
         -- Payload.Decade2000.Task.AirToGround.Pylon02={FBC29BFE-3D24-4C64-B81D-941239D12249}
         -- Payload.Decade2000.Task.AirToGround.Pylon03={A0648264-4BC0-4EE8-A543-D119F6BA4257}
         -- Payload.Decade2000.Task.AirToGround.Pylon04={A0648264-4BC0-4EE8-A543-D119F6BA4257}
         -- Payload.Decade2000.Task.AirToGround.Pylon05={37DCC01E-9E02-432F-B61D-10C166CA2798}
         -- Payload.Decade2000.Task.AirToGround.Pylon06={37DCC01E-9E02-432F-B61D-10C166CA2798}
         -- Payload.Decade2000.Task.AirToGround.Pylon07={37DCC01E-9E02-432F-B61D-10C166CA2798}
         -- Payload.Decade2000.Task.AirToGround.Pylon08={37DCC01E-9E02-432F-B61D-10C166CA2798}
         -- Payload.Decade2000.Task.AirToGround.Pylon09={A0648264-4BC0-4EE8-A543-D119F6BA4257}
         -- Payload.Decade2000.Task.AirToGround.Pylon10={A0648264-4BC0-4EE8-A543-D119F6BA4257}
         -- Payload.Decade2000.Task.AirToGround.Pylon11={FBC29BFE-3D24-4C64-B81D-941239D12249}
         -- Payload.Decade2000.Task.AirToGround.Pylon12={FBC29BFE-3D24-4C64-B81D-941239D12249}
         -- Payload.Decade2000.Task.AntiShip.Pylon01={FBC29BFE-3D24-4C64-B81D-941239D12249}
         -- Payload.Decade2000.Task.AntiShip.Pylon02={FBC29BFE-3D24-4C64-B81D-941239D12249}
         -- Payload.Decade2000.Task.AntiShip.Pylon03={A0648264-4BC0-4EE8-A543-D119F6BA4257}
         -- Payload.Decade2000.Task.AntiShip.Pylon04={A0648264-4BC0-4EE8-A543-D119F6BA4257}
         -- Payload.Decade2000.Task.AntiShip.Pylon05={37DCC01E-9E02-432F-B61D-10C166CA2798}
         -- Payload.Decade2000.Task.AntiShip.Pylon06={37DCC01E-9E02-432F-B61D-10C166CA2798}
         -- Payload.Decade2000.Task.AntiShip.Pylon07={37DCC01E-9E02-432F-B61D-10C166CA2798}
         -- Payload.Decade2000.Task.AntiShip.Pylon08={37DCC01E-9E02-432F-B61D-10C166CA2798}
         -- Payload.Decade2000.Task.AntiShip.Pylon09={A0648264-4BC0-4EE8-A543-D119F6BA4257}
         -- Payload.Decade2000.Task.AntiShip.Pylon10={A0648264-4BC0-4EE8-A543-D119F6BA4257}
         -- Payload.Decade2000.Task.AntiShip.Pylon11={FBC29BFE-3D24-4C64-B81D-941239D12249}
         -- Payload.Decade2000.Task.AntiShip.Pylon12={FBC29BFE-3D24-4C64-B81D-941239D12249}
         -- Payload.Decade2000.Task.SEAD.Pylon01={FBC29BFE-3D24-4C64-B81D-941239D12249}
         -- Payload.Decade2000.Task.SEAD.Pylon02={FBC29BFE-3D24-4C64-B81D-941239D12249}
         -- Payload.Decade2000.Task.SEAD.Pylon03={A0648264-4BC0-4EE8-A543-D119F6BA4257}
         -- Payload.Decade2000.Task.SEAD.Pylon04={A0648264-4BC0-4EE8-A543-D119F6BA4257}
         -- Payload.Decade2000.Task.SEAD.Pylon05={37DCC01E-9E02-432F-B61D-10C166CA2798}
         -- Payload.Decade2000.Task.SEAD.Pylon06={37DCC01E-9E02-432F-B61D-10C166CA2798}
         -- Payload.Decade2000.Task.SEAD.Pylon07={37DCC01E-9E02-432F-B61D-10C166CA2798}
         -- Payload.Decade2000.Task.SEAD.Pylon08={37DCC01E-9E02-432F-B61D-10C166CA2798}
         -- Payload.Decade2000.Task.SEAD.Pylon09={A0648264-4BC0-4EE8-A543-D119F6BA4257}
         -- Payload.Decade2000.Task.SEAD.Pylon10={A0648264-4BC0-4EE8-A543-D119F6BA4257}
         -- Payload.Decade2000.Task.SEAD.Pylon11={FBC29BFE-3D24-4C64-B81D-941239D12249}
         -- Payload.Decade2000.Task.SEAD.Pylon12={FBC29BFE-3D24-4C64-B81D-941239D12249}
        }
    }
}
