Library.aircraft["MiG-25PD"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 64,flare = 64,fuel = 15245,gun = 100 },
    pylons = {
        default = {
         [1] = { CLSID = "{682A481F-0CB5-4693-A382-D00DD4A156D7}" },
         [2] = { CLSID = "{4EDBA993-2E34-444C-95FB-549300BF7CAF}" },
         [3] = { CLSID = "{4EDBA993-2E34-444C-95FB-549300BF7CAF}" },
         [4] = { CLSID = "{682A481F-0CB5-4693-A382-D00DD4A156D7}" },
        }
    }
}
