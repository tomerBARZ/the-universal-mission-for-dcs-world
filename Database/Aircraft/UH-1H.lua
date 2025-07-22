Library.aircraft["UH-1H"] = {
    altitude = DCSEx.converter.feetToMeters(1500),
    speed = DCSEx.converter.knotsToMps(90),
    payload = { chaff = 0,flare = 60,fuel = 631 },
    properties = { SoloFlight = false, ExhaustScreen = true, GunnersAISkill = 90, NetCrewControlPriority = 0, EngineResource = 90 },
    pylons = {
        default = {
         [1] = { CLSID = "{M134_L}" },
         [2] = { CLSID = "{XM158_MK5}" },
         [5] = { CLSID = "{XM158_MK5}" },
         [6] = { CLSID = "{M134_R}" },
        }
    }
}
