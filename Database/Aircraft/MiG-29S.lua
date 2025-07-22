Library.aircraft["MiG-29S"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 30,flare = 30,fuel = 3493,gun = 100 },
    pylons = {
        default = {
         [1] = { CLSID = "{FBC29BFE-3D24-4C64-B81D-941239D12249}" },
         [2] = { CLSID = "{FBC29BFE-3D24-4C64-B81D-941239D12249}" },
         [3] = { CLSID = "{9B25D316-0434-4954-868F-D51DB1A38DF0}" },
         [4] = { CLSID = "{2BEC576B-CDF5-4B7F-961F-B0FA4312B841}" },
         [5] = { CLSID = "{9B25D316-0434-4954-868F-D51DB1A38DF0}" },
         [6] = { CLSID = "{FBC29BFE-3D24-4C64-B81D-941239D12249}" },
         [7] = { CLSID = "{FBC29BFE-3D24-4C64-B81D-941239D12249}" },
         -- Payload.Decade2000.Task.AirToGround.Pylon01={FBC29BFE-3D24-4C64-B81D-941239D12249}
         -- Payload.Decade2000.Task.AirToGround.Pylon02={3858707D-F5D5-4bbb-BDD8-ABB0530EBC7C}
         -- Payload.Decade2000.Task.AirToGround.Pylon03={37DCC01E-9E02-432F-B61D-10C166CA2798}
         -- Payload.Decade2000.Task.AirToGround.Pylon04={2BEC576B-CDF5-4B7F-961F-B0FA4312B841}
         -- Payload.Decade2000.Task.AirToGround.Pylon05={37DCC01E-9E02-432F-B61D-10C166CA2798}
         -- Payload.Decade2000.Task.AirToGround.Pylon06={3858707D-F5D5-4bbb-BDD8-ABB0530EBC7C}
         -- Payload.Decade2000.Task.AirToGround.Pylon07={FBC29BFE-3D24-4C64-B81D-941239D12249}
         -- Payload.Decade2000.Task.AntiShip.Pylon01={FBC29BFE-3D24-4C64-B81D-941239D12249}
         -- Payload.Decade2000.Task.AntiShip.Pylon02={3858707D-F5D5-4bbb-BDD8-ABB0530EBC7C}
         -- Payload.Decade2000.Task.AntiShip.Pylon03={37DCC01E-9E02-432F-B61D-10C166CA2798}
         -- Payload.Decade2000.Task.AntiShip.Pylon04={2BEC576B-CDF5-4B7F-961F-B0FA4312B841}
         -- Payload.Decade2000.Task.AntiShip.Pylon05={37DCC01E-9E02-432F-B61D-10C166CA2798}
         -- Payload.Decade2000.Task.AntiShip.Pylon06={3858707D-F5D5-4bbb-BDD8-ABB0530EBC7C}
         -- Payload.Decade2000.Task.AntiShip.Pylon07={FBC29BFE-3D24-4C64-B81D-941239D12249}
         -- Payload.Decade2000.Task.SEAD.Pylon01={FBC29BFE-3D24-4C64-B81D-941239D12249}
         -- Payload.Decade2000.Task.SEAD.Pylon02={3858707D-F5D5-4bbb-BDD8-ABB0530EBC7C}
         -- Payload.Decade2000.Task.SEAD.Pylon03={37DCC01E-9E02-432F-B61D-10C166CA2798}
         -- Payload.Decade2000.Task.SEAD.Pylon04={2BEC576B-CDF5-4B7F-961F-B0FA4312B841}
         -- Payload.Decade2000.Task.SEAD.Pylon05={37DCC01E-9E02-432F-B61D-10C166CA2798}
         -- Payload.Decade2000.Task.SEAD.Pylon06={3858707D-F5D5-4bbb-BDD8-ABB0530EBC7C}
         -- Payload.Decade2000.Task.SEAD.Pylon07={FBC29BFE-3D24-4C64-B81D-941239D12249}
        }
    }
}
