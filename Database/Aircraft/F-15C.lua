Library.aircraft["F-15C"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 120,flare = 60,fuel = 6103 },
    pylons = {
        default = {
         [1] = { CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" },
         [3] = { CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" },
         [4] = { CLSID = "{C8E06185-7CD6-4C90-959F-044679E90751}" },
         [5] = { CLSID = "{C8E06185-7CD6-4C90-959F-044679E90751}" },
         [6] = { CLSID = "{E1F29B21-F291-4589-9FD8-3272EEC69506}" },
         [7] = { CLSID = "{C8E06185-7CD6-4C90-959F-044679E90751}" },
         [8] = { CLSID = "{C8E06185-7CD6-4C90-959F-044679E90751}" },
         [9] = { CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" },
         [11] = { CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" },
        }
    }
}
