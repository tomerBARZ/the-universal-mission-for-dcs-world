Library.aircraft["Mi-8MT"] = {
    altitude = DCSEx.converter.feetToMeters(1500),
    speed = DCSEx.converter.knotsToMps(90),
    payload = { chaff = 0,flare = 128,fuel = 1929,gun = 100 },
    properties = { LeftEngineResource = 90, RightEngineResource = 90, NetCrewControlPriority = 1, ExhaustScreen = true, CargoHalfdoor = true, GunnersAISkill = 90, AdditionalArmor = true, NS430allow = true },
    pylons = {
        default = {
         [1] = { CLSID = "{GUV_VOG}" },
         [2] = { CLSID = "{6A4B9E69-64FE-439a-9163-3A87FB6A4D81}" },
         [3] = { CLSID = "{6A4B9E69-64FE-439a-9163-3A87FB6A4D81}" },
         [4] = { CLSID = "{6A4B9E69-64FE-439a-9163-3A87FB6A4D81}" },
         [5] = { CLSID = "{6A4B9E69-64FE-439a-9163-3A87FB6A4D81}" },
         [6] = { CLSID = "{GUV_VOG}" },
        }
    }
}
