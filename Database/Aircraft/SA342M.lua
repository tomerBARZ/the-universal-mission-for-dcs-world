Library.aircraft["SA342M"] = {
    altitude = DCSEx.converter.feetToMeters(1500),
    speed = DCSEx.converter.knotsToMps(90),
    payload = { chaff = 0,flare = 32,fuel = 416.33,gun = 100 },
    properties = { NS430allow = true },
    pylons = {
        default = {
         [1] = { CLSID = "{HOT3D}" },
         [2] = { CLSID = "{HOT3D}" },
         [3] = { CLSID = "{HOT3D}" },
         [4] = { CLSID = "{HOT3D}" },
         [5] = { CLSID = "{FAS}" },
         [6] = { CLSID = "{IR_Deflector}" },
        }
    }
}
