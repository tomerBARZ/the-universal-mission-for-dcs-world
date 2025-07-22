Library.aircraft["AH-64D"] = {
    altitude = DCSEx.converter.feetToMeters(1500),
    speed = DCSEx.converter.knotsToMps(90),
    payload = { chaff = 30,flare = 30,fuel = 1157 },
    pylons = {
        default = {
         [1] = { CLSID = "{88D18A5E-99C8-4B04-B40B-1C02F2018B6E}" },
         [2] = { CLSID = "{3DFB7321-AB0E-11d7-9897-000476191836}" },
         [3] = { CLSID = "{3DFB7321-AB0E-11d7-9897-000476191836}" },
         [4] = { CLSID = "{88D18A5E-99C8-4B04-B40B-1C02F2018B6E}" },
        }
    }
}
