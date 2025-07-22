Library.aircraft["MiG-25RBT"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 64,flare = 64,fuel = 15245,gun = 100 },
    pylons = {
        default = {
         [1] = { CLSID = "{682A481F-0CB5-4693-A382-D00DD4A156D7}" },
         [2] = { CLSID = "{37DCC01E-9E02-432F-B61D-10C166CA2798}" },
         [3] = { CLSID = "{37DCC01E-9E02-432F-B61D-10C166CA2798}" },
         [4] = { CLSID = "{682A481F-0CB5-4693-A382-D00DD4A156D7}" },
        }
    }
}
