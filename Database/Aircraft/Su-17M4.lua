Library.aircraft["Su-17M4"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 96,flare = 96,fuel = 11700,gun = 100 },
    pylons = {
        default = {
         [1] = { CLSID = "{637334E4-AB5A-47C0-83A6-51B7F1DF3CD5}" },
         [2] = { CLSID = "{682A481F-0CB5-4693-A382-D00DD4A156D7}" },
         [3] = { CLSID = "{637334E4-AB5A-47C0-83A6-51B7F1DF3CD5}" },
         [4] = { CLSID = "{E659C4BE-2CD8-4472-8C08-3F28ACB61A8A}" },
         [5] = { CLSID = "{E659C4BE-2CD8-4472-8C08-3F28ACB61A8A}" },
         [6] = { CLSID = "{637334E4-AB5A-47C0-83A6-51B7F1DF3CD5}" },
         [7] = { CLSID = "{682A481F-0CB5-4693-A382-D00DD4A156D7}" },
         [8] = { CLSID = "{637334E4-AB5A-47C0-83A6-51B7F1DF3CD5}" },
        }
    }
}
