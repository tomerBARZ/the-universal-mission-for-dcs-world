Library.aircraft["SA342Mistral"] = {
    altitude = DCSEx.converter.feetToMeters(1500),
    speed = DCSEx.converter.knotsToMps(90),
    payload = { chaff = 0,flare = 32,fuel = 416.33,gun = 100 },
    properties = { NS430allow = true },
    pylons = {
        default = {
         [1] = { CLSID = "{MBDA_MistralD}" },
         [2] = { CLSID = "{MBDA_MistralG}" },
         [3] = { CLSID = "{MBDA_MistralD}" },
         [4] = { CLSID = "{MBDA_MistralG}" },
         [5] = { CLSID = "{FAS}" },
         [6] = { CLSID = "{IR_Deflector}" },
        }
    }
}
