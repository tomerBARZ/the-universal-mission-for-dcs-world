Library.aircraft["F-117A"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 0,flare = 0,fuel = 3840 },
    pylons = {
        default = {
         [1] = { CLSID = "{EF0A9419-01D6-473B-99A3-BEBDB923B14D}" },
         [2] = { CLSID = "{EF0A9419-01D6-473B-99A3-BEBDB923B14D}" },
        }
    }
}
