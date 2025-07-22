Library.aircraft["F-16A"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { ammo_type = 5,chaff = 60,flare = 60,fuel = 3249,gun = 100 },
    properties = { LaserCode1 = 8, LaserCode100 = 6, LAU3ROF = 0, LaserCode10 = 8 },
    pylons = {
        default = {
         [1] = { CLSID = "{C8E06185-7CD6-4C90-959F-044679E90751}" },
         [2] = { CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}" },
         [3] = { CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}" },
         [4] = { CLSID = "{F376DBEE-4CAE-41BA-ADD9-B2910AC95DEC}" },
         [5] = { CLSID = "{CAAC1CFD-6745-416B-AFA4-CB57414856D0}" },
         [6] = { CLSID = "{6D21ECEA-F85B-4E8D-9D51-31DC9B8AA4EF}" },
         [7] = { CLSID = "{F376DBEE-4CAE-41BA-ADD9-B2910AC95DEC}" },
         [8] = { CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}" },
         [9] = { CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}" },
         [10] = { CLSID = "{C8E06185-7CD6-4C90-959F-044679E90751}" },
         -- Payload.Decade2000.Task.AirToAir.Pylon01={C8E06185-7CD6-4C90-959F-044679E90751}
         -- Payload.Decade2000.Task.AirToAir.Pylon02={C8E06185-7CD6-4C90-959F-044679E90751}
         -- Payload.Decade2000.Task.AirToAir.Pylon03={C8E06185-7CD6-4C90-959F-044679E90751}
         -- Payload.Decade2000.Task.AirToAir.Pylon04={F376DBEE-4CAE-41BA-ADD9-B2910AC95DEC}
         -- Payload.Decade2000.Task.AirToAir.Pylon06={6D21ECEA-F85B-4E8D-9D51-31DC9B8AA4EF}
         -- Payload.Decade2000.Task.AirToAir.Pylon07={F376DBEE-4CAE-41BA-ADD9-B2910AC95DEC}
         -- Payload.Decade2000.Task.AirToAir.Pylon08={C8E06185-7CD6-4C90-959F-044679E90751}
         -- Payload.Decade2000.Task.AirToAir.Pylon09={C8E06185-7CD6-4C90-959F-044679E90751}
         -- Payload.Decade2000.Task.AirToAir.Pylon10={C8E06185-7CD6-4C90-959F-044679E90751}
         -- Payload.Decade2000.Task.SEAD.Pylon01={C8E06185-7CD6-4C90-959F-044679E90751}
         -- Payload.Decade2000.Task.SEAD.Pylon02={6CEB49FC-DED8-4DED-B053-E1F033FF72D3}
         -- Payload.Decade2000.Task.SEAD.Pylon03={B06DD79A-F21E-4EB9-BD9D-AB3844618C93}
         -- Payload.Decade2000.Task.SEAD.Pylon04={F376DBEE-4CAE-41BA-ADD9-B2910AC95DEC}
         -- Payload.Decade2000.Task.SEAD.Pylon06={6D21ECEA-F85B-4E8D-9D51-31DC9B8AA4EF}
         -- Payload.Decade2000.Task.SEAD.Pylon07={F376DBEE-4CAE-41BA-ADD9-B2910AC95DEC}
         -- Payload.Decade2000.Task.SEAD.Pylon08={B06DD79A-F21E-4EB9-BD9D-AB3844618C93}
         -- Payload.Decade2000.Task.SEAD.Pylon09={6CEB49FC-DED8-4DED-B053-E1F033FF72D3}
         -- Payload.Decade2000.Task.SEAD.Pylon10={C8E06185-7CD6-4C90-959F-044679E90751}
        }
    }
}
