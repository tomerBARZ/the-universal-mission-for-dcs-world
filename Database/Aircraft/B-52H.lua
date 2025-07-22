Library.aircraft["B-52H"] = {
    altitude = DCSEx.converter.feetToMeters(30000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 1125,flare = 192,fuel = 141135,gun = 100 },
    pylons = {
        default = {
         [1] = { CLSID = "{585D626E-7F42-4073-AB70-41E728C333E2}" },
         [2] = { CLSID = "{6C47D097-83FF-4FB2-9496-EAB36DDF0B05}" },
         [3] = { CLSID = "{585D626E-7F42-4073-AB70-41E728C333E2}" },
        }
    }
}
