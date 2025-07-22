Library.aircraft["SA342L"] = {
    altitude = DCSEx.converter.feetToMeters(1500),
    speed = DCSEx.converter.knotsToMps(90),
    payload = { chaff = 0,flare = 32,fuel = 416.33,gun = 100 },
    properties = { NS430allow = true },
    pylons = {
        default = {
         [2] = { CLSID = "{LAU_SNEB68G}" },
         [5] = { CLSID = "{FAS}" },
         [6] = { CLSID = "{IR_Deflector}" },
        }
    }
}
