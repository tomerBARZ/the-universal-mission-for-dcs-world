Library.aircraft["Tu-22M3"] = {
    altitude = DCSEx.converter.feetToMeters(30000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 48,flare = 48,fuel = 50000 },
    pylons = {
        default = {
         [3] = { CLSID = "{AD5E5863-08FC-4283-B92C-162E2B2BD3FF}" },
        }
    }
}
