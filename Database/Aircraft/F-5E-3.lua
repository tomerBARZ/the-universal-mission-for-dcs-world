Library.aircraft["F-5E-3"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 30,flare = 15,fuel = 2046,ammo_type = 2,gun = 100, },
    properties = { LAU68ROF = 0,ChaffSalvo = 0,ChaffSalvoInt = 0,LAU3ROF = 0,ChaffBurstInt = 0,LaserCode100 = 6,LaserCode1 = 8,FlareBurstInt = 0,FlareBurst = 0,LaserCode10 = 8,ChaffBurst = 0 },
    pylons = {
        default = {
         [1] = { CLSID = "{AIM-9P5}" },
         [3] = { CLSID = "{0395076D-2F77-4420-9D33-087A4398130B}" },
         [4] = { CLSID = "{0395076D-2F77-4420-9D33-087A4398130B}" },
         [5] = { CLSID = "{0395076D-2F77-4420-9D33-087A4398130B}" },
         [7] = { CLSID = "{AIM-9P5}" },
         -- pylons = {
         -- [1] = { CLSID = "{9BFD8C90-F7AE-4e90-833B-BFD0CED0E536}" },
         -- [2] = { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },
         -- [3] = { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },
         -- [4] = { CLSID = "{0395076D-2F77-4420-9D33-087A4398130B}" },
         -- [5] = { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },
         -- [6] = { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },
         -- [7] = { CLSID = "{9BFD8C90-F7AE-4e90-833B-BFD0CED0E536}" },
        }
    }
}
