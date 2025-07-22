Library.aircraft["Su-24M"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 96,flare = 96,fuel = 11700,gun = 100 },
    pylons = {
        default = {
         [1] = { CLSID = "{B0DBC591-0F52-4F7D-AD7B-51E67725FB81}" },
         [2] = { CLSID = "{BA565F89-2373-4A84-9502-A0E017D3A44A}" },
         [3] = { CLSID = "{BA565F89-2373-4A84-9502-A0E017D3A44A}" },
         [6] = { CLSID = "{BA565F89-2373-4A84-9502-A0E017D3A44A}" },
         [7] = { CLSID = "{BA565F89-2373-4A84-9502-A0E017D3A44A}" },
         [8] = { CLSID = "{275A2855-4A79-4B2D-B082-91EA2ADF4691}" },
        }
    }
}
