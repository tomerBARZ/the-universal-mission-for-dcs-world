Library.aircraft["F-15E"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 120,flare = 60,fuel = 10246 },
    pylons = {
        default = {
         [1] = { CLSID = "{C8E06185-7CD6-4C90-959F-044679E90751}" },
         [2] = { CLSID = "{9BCC2A2B-5708-4860-B1F1-053A18442067}" },
         [3] = { CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}" },
         [4] = { CLSID = "{GBU-38}" },
         [6] = { CLSID = "{GBU-38}" },
         [7] = { CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}" },
         [9] = { CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}" },
         [10] = { CLSID = "{E1F29B21-F291-4589-9FD8-3272EEC69506}" },
         [11] = { CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}" },
         [13] = { CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}" },
         [14] = { CLSID = "{GBU-38}" },
         [16] = { CLSID = "{GBU-38}" },
         [17] = { CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}" },
         [18] = { CLSID = "{9BCC2A2B-5708-4860-B1F1-053A18442067}" },
         [19] = { CLSID = "{C8E06185-7CD6-4C90-959F-044679E90751}" },
        }
    }
}
