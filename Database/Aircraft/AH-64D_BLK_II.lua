Library.aircraft["AH-64D_BLK_II"] = {
    altitude = DCSEx.converter.feetToMeters(1500),
    speed = DCSEx.converter.knotsToMps(90),
    payload = { fuel = 1140, flare = 60, ammo_type = 1, chaff = 30, gun = 100 },
    pylons = {
        default = {
         [1] = { CLSID = "M261_MK151" },
         [2] = { CLSID = "{M299_4xAGM_114L}" },
         [3] = { CLSID = "{M299_4xAGM_114L}" },
         [4] = { CLSID = "M261_MK151" },
         [5] = { CLSID = "{IAFS_ComboPak_100}" },
         [6] = { CLSID = "{AN_APG_78}" },
        }
    }
}
