Library.aircraft["Su-30"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 96,flare = 96,fuel = 9400,gun = 100 },
    pylons = {
        default = {
         [1] = { CLSID = "{44EE8698-89F9-48EE-AF36-5FD31896A82F}" },
         [2] = { CLSID = "{FBC29BFE-3D24-4C64-B81D-941239D12249}" },
         [3] = { CLSID = "{B4C01D60-A8A3-4237-BD72-CA7655BC0FE9}" },
         [4] = { CLSID = "{B4C01D60-A8A3-4237-BD72-CA7655BC0FE9}" },
         [5] = { CLSID = "{B4C01D60-A8A3-4237-BD72-CA7655BC0FE9}" },
         [6] = { CLSID = "{B4C01D60-A8A3-4237-BD72-CA7655BC0FE9}" },
         [7] = { CLSID = "{B4C01D60-A8A3-4237-BD72-CA7655BC0FE9}" },
         [8] = { CLSID = "{B4C01D60-A8A3-4237-BD72-CA7655BC0FE9}" },
         [9] = { CLSID = "{FBC29BFE-3D24-4C64-B81D-941239D12249}" },
         [10] = { CLSID = "{44EE8698-89F9-48EE-AF36-5FD31896A82A}" },
        }
    }
}
