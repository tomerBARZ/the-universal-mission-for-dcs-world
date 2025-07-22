Library.aircraft["Ka-50"] = {
    altitude = DCSEx.converter.feetToMeters(1500),
    speed = DCSEx.converter.knotsToMps(90),
    payload = { chaff = 0,flare = 128,fuel = 1450,gun = 100 },
    pylons = {
        default = {
         [1] = { CLSID = "{A6FD14D3-6D30-4C85-88A7-8D17BEE120E2}" },
         [2] = { CLSID = "{6A4B9E69-64FE-439a-9163-3A87FB6A4D81}" },
         [3] = { CLSID = "{6A4B9E69-64FE-439a-9163-3A87FB6A4D81}" },
         [4] = { CLSID = "{A6FD14D3-6D30-4C85-88A7-8D17BEE120E2}" },
        }
    }
}
