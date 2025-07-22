Library.aircraft["SH-60B"] = {
    altitude = DCSEx.converter.feetToMeters(1500),
    speed = DCSEx.converter.knotsToMps(90),
    payload = { chaff = 30,flare = 30,fuel = 1100 },
    pylons = {
        default = {
         [1] = { CLSID = "{7B8DCEB4-820B-4015-9B48-1028A4195692}" },
        }
    }
}
