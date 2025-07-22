Library.aircraft["AH-1W"] = {
    altitude = DCSEx.converter.feetToMeters(1500),
    speed = DCSEx.converter.knotsToMps(90),
    payload = { chaff = 30,flare = 30,fuel = 1250 },
    pylons = {
        default = {
         [1] = { CLSID = "{3EA17AB0-A805-4D9E-8732-4CE00CB00F17}" },
         [2] = { CLSID = "[M260_HYDRA}" },
         [3] = { CLSID = "[M260_HYDRA}" },
         [4] = { CLSID = "{3EA17AB0-A805-4D9E-8732-4CE00CB00F17}" },
        }
    }
}
