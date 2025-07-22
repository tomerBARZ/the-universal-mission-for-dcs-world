Library.aircraft["OH-58D"] = {
    altitude = DCSEx.converter.feetToMeters(1500),
    speed = DCSEx.converter.knotsToMps(90),
    payload = { chaff = 30,flare = 30,fuel = 454 },
    pylons = {
        default = {
         [1] = { CLSID = "{AGM114x2_OH_58}" },
         [2] = { CLSID = "{M260_HYDRA}" },
        }
    }
}
