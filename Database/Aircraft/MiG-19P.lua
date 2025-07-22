Library.aircraft["MiG-19P"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 0,flare = 0,fuel = 1800,gun = 100 },
    properties = { MissileToneVolume = 5,ADF_Selected_Frequency = 1,MountSIRENA = false,ADF_NEAR_Frequency = 303,ADF_FAR_Frequency = 625,NAV_Initial_Hdg = 0 },
    pylons = {
        default = {
         [1] = { CLSID = "{K-13A}" },
         [2] = { CLSID = "{PTB760_MIG19}" },
         [5] = { CLSID = "{PTB760_MIG19}" },
         [6] = { CLSID = "{K-13A}" },
         -- Payload.Decade2000.Task.AirToGround.Pylon02={3C612111-C7AD-476E-8A8E-2485812F4E5C}
         -- Payload.Decade2000.Task.AirToGround.Pylon03={ORO57K_S5M_HEFRAG}
         -- Payload.Decade2000.Task.AirToGround.Pylon04={ORO57K_S5M_HEFRAG}
         -- Payload.Decade2000.Task.AirToGround.Pylon05={3C612111-C7AD-476E-8A8E-2485812F4E5C}
        }
    }
}
