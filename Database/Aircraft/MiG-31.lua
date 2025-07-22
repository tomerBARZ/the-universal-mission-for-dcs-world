Library.aircraft["MiG-31"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 0,flare = 0,fuel = 15500,gun = 100 },
    pylons = {
        default = {
         [1] = { CLSID = "{4EDBA993-2E34-444C-95FB-549300BF7CAF}" },
         [2] = { CLSID = "{F1243568-8EF0-49D4-9CB5-4DA90D92BC1D}" },
         [3] = { CLSID = "{F1243568-8EF0-49D4-9CB5-4DA90D92BC1D}" },
         [4] = { CLSID = "{F1243568-8EF0-49D4-9CB5-4DA90D92BC1D}" },
         [5] = { CLSID = "{F1243568-8EF0-49D4-9CB5-4DA90D92BC1D}" },
         [6] = { CLSID = "{5F26DBC2-FB43-4153-92DE-6BBCE26CB0FF}" },
        }
    }
}
