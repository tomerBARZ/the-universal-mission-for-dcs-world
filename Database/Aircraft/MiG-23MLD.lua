Library.aircraft["MiG-23MLD"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 60,flare = 60,fuel = 3800,gun = 100 },
    pylons = {
        default = {
         [2] = { CLSID = "{CCF898C9-5BC7-49A4-9D1E-C3ED3D5166A1}" },
         [3] = { CLSID = "{B0DBC591-0F52-4F7D-AD7B-51E67725FB81}" },
         [4] = { CLSID = "{A5BAEAB7-6FAF-4236-AF72-0FD900F493F9}" },
         [5] = { CLSID = "{275A2855-4A79-4B2D-B082-91EA2ADF4691}" },
         [6] = { CLSID = "{CCF898C9-5BC7-49A4-9D1E-C3ED3D5166A1}" },
         -- Payload.Decade2000.Task.AirToGround.Pylon02={37DCC01E-9E02-432F-B61D-10C166CA2798}
         -- Payload.Decade2000.Task.AirToGround.Pylon03={682A481F-0CB5-4693-A382-D00DD4A156D7}
         -- Payload.Decade2000.Task.AirToGround.Pylon04={A5BAEAB7-6FAF-4236-AF72-0FD900F493F9}
         -- Payload.Decade2000.Task.AirToGround.Pylon05={682A481F-0CB5-4693-A382-D00DD4A156D7}
         -- Payload.Decade2000.Task.AirToGround.Pylon06={37DCC01E-9E02-432F-B61D-10C166CA2798}
        }
    }
}
