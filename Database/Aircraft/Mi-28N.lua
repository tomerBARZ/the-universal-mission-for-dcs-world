Library.aircraft["Mi-28N"] = {
    altitude = DCSEx.converter.feetToMeters(1500),
    speed = DCSEx.converter.knotsToMps(90),
    payload = { chaff = 0,flare = 128,fuel = 1500 },
    pylons = {
        default = {
         [1] = { CLSID = "{57232979-8B0F-4db7-8D9A-55197E06B0F5}" },
         [2] = { CLSID = "{FC56DF80-9B09-44C5-8976-DCFAFF219062}" },
         [3] = { CLSID = "{FC56DF80-9B09-44C5-8976-DCFAFF219062}" },
         [4] = { CLSID = "{57232979-8B0F-4db7-8D9A-55197E06B0F5}" },
        }
    }
}
