Library.aircraft["FA-18C_hornet"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 60,flare = 30,fuel = 4900,gun = 100 },
    properties = { OuterBoard = 0, InnerBoard = 0, HelmetMountedDevice = 1 },
    pylons = {
        default = {
            [1] = { CLSID = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}" },
            [2] = { CLSID = "LAU_117_AGM_65F" },
            [3] = { CLSID = "{BRU33_2X_GBU-12}" },
            [4] = { CLSID = "{AAQ-28_LEFT}" },
            [5] = { CLSID = "{FPU_8A_FUEL_TANK}" },
            [6] = { CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" },
            [7] = { CLSID = "{BRU33_2X_GBU-12}" },
            [8] = { CLSID = "{F16A4DE0-116C-4A71-97F0-2CF85B0313EC}" },
            [9] = { CLSID = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}" },
        },
        cap = {
            [1] = { CLSID = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}" },
            [2] = { CLSID = "LAU-115_2*LAU-127_AIM-120C" },
            [3] = { CLSID = "{FPU_8A_FUEL_TANK}" },
            [4] = { CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" },
            [5] = { CLSID = "{FPU_8A_FUEL_TANK}" },
            [6] = { CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" },
            [7] = { CLSID = "{FPU_8A_FUEL_TANK}" },
            [8] = { CLSID = "LAU-115_2*LAU-127_AIM-120C" },
            [9] = { CLSID = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}" },
        },
    }
}
