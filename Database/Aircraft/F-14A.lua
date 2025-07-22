Library.aircraft["F-14A"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 30,flare = 15,fuel = 7348 },
    pylons = {
        default = {
         [1] = { CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}" },
         [2] = { CLSID = "{7575BA0B-7294-4844-857B-031A144B2595}" },
         [4] = { CLSID = "{7575BA0B-7294-4844-857B-031A144B2595}" },
         [5] = { CLSID = "{7575BA0B-7294-4844-857B-031A144B2595}" },
         [8] = { CLSID = "{7575BA0B-7294-4844-857B-031A144B2595}" },
         [9] = { CLSID = "{7575BA0B-7294-4844-857B-031A144B2595}" },
         [11] = { CLSID = "{7575BA0B-7294-4844-857B-031A144B2595}" },
         [12] = { CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}" },
         -- Payload.Decade2000.Task.AirToGround.Pylon01={9BFD8C90-F7AE-4e90-833B-BFD0CED0E536}
         -- Payload.Decade2000.Task.AirToGround.Pylon02={BCE4E030-38E9-423E-98ED-24BE3DA87C32}
         -- Payload.Decade2000.Task.AirToGround.Pylon03={BCE4E030-38E9-423E-98ED-24BE3DA87C32}
         -- Payload.Decade2000.Task.AirToGround.Pylon04={0395076D-2F77-4420-9D33-087A4398130B}
         -- Payload.Decade2000.Task.AirToGround.Pylon05={BCE4E030-38E9-423E-98ED-24BE3DA87C32}
         -- Payload.Decade2000.Task.AirToGround.Pylon06={BCE4E030-38E9-423E-98ED-24BE3DA87C32}
         -- Payload.Decade2000.Task.AirToGround.Pylon07={9BFD8C90-F7AE-4e90-833B-BFD0CED0E536}
        }
    }
}
