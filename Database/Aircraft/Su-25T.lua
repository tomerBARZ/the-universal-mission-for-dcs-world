Library.aircraft["Su-25T"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 128,flare = 128,fuel = 3790,gun = 100 },
    pylons = {
        default = {
         [1] = { CLSID = "{44EE8698-89F9-48EE-AF36-5FD31896A82D}" },
         [2] = { CLSID = "{CBC29BFE-3D24-4C64-B81D-941239D12249}" },
         [3] = { CLSID = "{0180F983-C14A-11d8-9897-000476191836}" },
         [4] = { CLSID = "{F789E86A-EE2E-4E6B-B81E-D5E5F903B6ED}" },
         [5] = { CLSID = "{E92CBFE5-C153-11d8-9897-000476191836}" },
         [6] = { CLSID = "{B1EF6B0E-3D91-4047-A7A5-A99E7D8B4A8B}" },
         [7] = { CLSID = "{E92CBFE5-C153-11d8-9897-000476191836}" },
         [8] = { CLSID = "{F789E86A-EE2E-4E6B-B81E-D5E5F903B6ED}" },
         [9] = { CLSID = "{0180F983-C14A-11d8-9897-000476191836}" },
         [10] = { CLSID = "{CBC29BFE-3D24-4C64-B81D-941239D12249}" },
         [11] = { CLSID = "{44EE8698-89F9-48EE-AF36-5FD31896A82C}" },
         -- Payload.Decade2000.Task.SEAD.Pylon01={44EE8698-89F9-48EE-AF36-5FD31896A82D}
         -- Payload.Decade2000.Task.SEAD.Pylon02={CBC29BFE-3D24-4C64-B81D-941239D12249}
         -- Payload.Decade2000.Task.SEAD.Pylon03={79D73885-0801-45a9-917F-C90FE1CE3DFC}
         -- Payload.Decade2000.Task.SEAD.Pylon04={79D73885-0801-45a9-917F-C90FE1CE3DFC}
         -- Payload.Decade2000.Task.SEAD.Pylon05={B5CA9846-776E-4230-B4FD-8BCC9BFB1676}
         -- Payload.Decade2000.Task.SEAD.Pylon06={0519A264-0AB6-11d6-9193-00A0249B6F00}
         -- Payload.Decade2000.Task.SEAD.Pylon07={B5CA9846-776E-4230-B4FD-8BCC9BFB1676}
         -- Payload.Decade2000.Task.SEAD.Pylon08={79D73885-0801-45a9-917F-C90FE1CE3DFC}
         -- Payload.Decade2000.Task.SEAD.Pylon09={79D73885-0801-45a9-917F-C90FE1CE3DFC}
         -- Payload.Decade2000.Task.SEAD.Pylon10={CBC29BFE-3D24-4C64-B81D-941239D12249}
         -- Payload.Decade2000.Task.SEAD.Pylon11={44EE8698-89F9-48EE-AF36-5FD31896A82C}
        }
    }
}
