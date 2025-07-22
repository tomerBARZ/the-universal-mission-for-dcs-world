Library.aircraft["C-101CC"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 0,flare = 0,fuel = 1881.5 },
    properties = { SoloFlight = false, MountIFRHood = false, CameraRecorder = false, SightSunFilter = false, NetCrewControlPriority = 1, NS430allow = 1 },
    pylons = {
        default = {
         [1] = { CLSID = "{9BFD8C90-F7AE-4e90-833B-BFD0CED0E536}" },
         [2] = { CLSID = "{BR_250}" },
         [3] = { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },
         [4] = { CLSID = "{C-101-DEFA553}" },
         [5] = { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },
         [6] = { CLSID = "{BR_250}" },
         [7] = { CLSID = "{9BFD8C90-F7AE-4e90-833B-BFD0CED0E536}" },
        }
    }
}
