Library.aircraft["B-1B"] = {
    altitude = DCSEx.converter.feetToMeters(30000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 60,flare = 30,fuel = 88450,gun = 100 },
    pylons = {
        default = {
         [1] = { CLSID = "GBU-38*16" },
         [2] = { CLSID = "GBU-38*16" },
         [3] = { CLSID = "GBU-38*16" },
        }
    }
}
