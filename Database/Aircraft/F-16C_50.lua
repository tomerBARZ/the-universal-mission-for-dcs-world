Library.aircraft["F-16C_50"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { ammo_type = 5,chaff = 60,flare = 60,fuel = 3249,gun = 100 },
    properties = { LaserCode1 = 8, LaserCode100 = 6, LAU3ROF = 0, LaserCode10 = 8, HelmetMountedDevice = 1 },
    pylons = {
        default = {
            [1] = { CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" },
            [2] = { CLSID = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}" },
            [3] = { CLSID = "{TER_9A_2L*GBU-12}" },
            [4] = { CLSID = "{F376DBEE-4CAE-41BA-ADD9-B2910AC95DEC}" },
            [5] = { CLSID = "<CLEAN>" },
            [6] = { CLSID = "{F376DBEE-4CAE-41BA-ADD9-B2910AC95DEC}" },
            [7] = { CLSID = "{TER_9A_2R*GBU-12}" },
            [8] = { CLSID = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}" },
            [9] = { CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" },
            [11] = { CLSID = "{A111396E-D3E8-4b9c-8AC9-2432489304D5}" },
        },
        cap = {
            [1] = { CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" },
            [2] = { CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" },
            [3] = { CLSID = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}" },
            [4] = { CLSID = "{F376DBEE-4CAE-41BA-ADD9-B2910AC95DEC}" },
            [5] = { CLSID = "<CLEAN>" },
            [6] = { CLSID = "{F376DBEE-4CAE-41BA-ADD9-B2910AC95DEC}" },
            [7] = { CLSID = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}" },
            [8] = { CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" },
            [9] = { CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" },
        },
    }
}
