Library.aircraft["Mi-24V"] = {
    altitude = DCSEx.converter.feetToMeters(1500),
    speed = DCSEx.converter.knotsToMps(90),
    payload = { chaff = 0,flare = 192,fuel = 1704 },
    pylons = {
        default = {
         [1] = { CLSID = "{B919B0F4-7C25-455E-9A02-CEA51DB895E3}" },
         [3] = { CLSID = "{B_8V20A_CM}" },
         [4] = { CLSID = "{B_8V20A_CM}" },
         [6] = { CLSID = "{B919B0F4-7C25-455E-9A02-CEA51DB895E3}" },
        }
    }
}
