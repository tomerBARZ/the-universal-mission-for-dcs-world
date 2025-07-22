Library.aircraft["Tu-160"] = {
    altitude = DCSEx.converter.feetToMeters(30000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 72,flare = 72,fuel = 157000 },
    pylons = {
        default = {
         [1] = { CLSID = "{0290F5DE-014A-4BB1-9843-D717749B1DED}" },
         [2] = { CLSID = "{0290F5DE-014A-4BB1-9843-D717749B1DED}" },
        }
    }
}
