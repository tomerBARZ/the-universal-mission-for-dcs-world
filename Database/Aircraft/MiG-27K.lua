Library.aircraft["MiG-27K"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 60,flare = 60,fuel = 4500,gun = 100 },
    pylons = {
        default = {
         [2] = { CLSID = "{E659C4BE-2CD8-4472-8C08-3F28ACB61A8A}" },
         [3] = { CLSID = "{682A481F-0CB5-4693-A382-D00DD4A156D7}" },
         [4] = { CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}" },
         [5] = { CLSID = "{A5BAEAB7-6FAF-4236-AF72-0FD900F493F9}" },
         [6] = { CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}" },
         [7] = { CLSID = "{682A481F-0CB5-4693-A382-D00DD4A156D7}" },
         [8] = { CLSID = "{E659C4BE-2CD8-4472-8C08-3F28ACB61A8A}" },
        }
    }
}
