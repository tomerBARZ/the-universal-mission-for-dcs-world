Library.aircraft["Tu-95MS"] = {
    altitude = DCSEx.converter.feetToMeters(30000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 48,flare = 48,fuel = 87000 },
    pylons = {
        default = {
         [1] = { CLSID = "{0290F5DE-014A-4BB1-9843-D717749B1DED}" },
        }
    }
}
