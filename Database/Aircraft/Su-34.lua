Library.aircraft["Su-34"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 64,flare = 64,fuel = 9800,gun = 100 },
    pylons = {
        default = {
         [1] = { CLSID = "{44EE8698-89F9-48EE-AF36-5FD31896A82F}" },
         [2] = { CLSID = "{FBC29BFE-3D24-4C64-B81D-941239D12249}" },
         [3] = { CLSID = "{FC56DF80-9B09-44C5-8976-DCFAFF219062}" },
         [4] = { CLSID = "{FC56DF80-9B09-44C5-8976-DCFAFF219062}" },
         [5] = { CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}" },
         [6] = { CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}" },
         [7] = { CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}" },
         [8] = { CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}" },
         [9] = { CLSID = "{FC56DF80-9B09-44C5-8976-DCFAFF219062}" },
         [10] = { CLSID = "{FC56DF80-9B09-44C5-8976-DCFAFF219062}" },
         [11] = { CLSID = "{FBC29BFE-3D24-4C64-B81D-941239D12249}" },
         [12] = { CLSID = "{44EE8698-89F9-48EE-AF36-5FD31896A82A}" },
        }
    }
}
