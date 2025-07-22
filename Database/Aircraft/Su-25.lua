Library.aircraft["Su-25"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 128,flare = 128,fuel = 2835,gun = 100 },
    pylons = {
        default = {
         [1] = { CLSID = "{682A481F-0CB5-4693-A382-D00DD4A156D7}" },
         [2] = { CLSID = "{FC56DF80-9B09-44C5-8976-DCFAFF219062}" },
         [3] = { CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}" },
         [4] = { CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}" },
         [5] = { CLSID = "{E92CBFE5-C153-11d8-9897-000476191836}" },
         [6] = { CLSID = "{E92CBFE5-C153-11d8-9897-000476191836}" },
         [7] = { CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}" },
         [8] = { CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}" },
         [9] = { CLSID = "{FC56DF80-9B09-44C5-8976-DCFAFF219062}" },
         [10] = { CLSID = "{682A481F-0CB5-4693-A382-D00DD4A156D7}" },
        }
    }
}
