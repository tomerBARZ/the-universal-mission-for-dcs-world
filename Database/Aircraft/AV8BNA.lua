Library.aircraft["AV8BNA"] = {
    altitude = DCSEx.converter.feetToMeters(20000),
    liveries = {
        [coalition.side.BLUE] = { "VMA-211", "VMA-211D", "VMA-214", "VMA-214D", "VMA-223D", "VMA-231-1", "VMA-231-2", "VMA-231D", "VMA-311", "VMA-311D", "VMA-513", "VMA-513D", "VMA-542", "VMAT-203", "VMAT-203S" },
        [coalition.side.RED] = { "default" },
    },
    speed = DCSEx.converter.knotsToMps(300),
    payload = { chaff = 60,flare = 120,fuel = 3519.423,gun = 100 },
    properties = { EWDispenserTBL = 2, WpBullseye = 0, EWDispenserBR = 2, AAR_Zone3 = 0, AAR_Zone2 = 0, EWDispenserTFR = 1, AAR_Zone1 = 0, ClockTime = 1, RocketBurst = 1, LaserCode100 = 6, LaserCode1 = 8, EWDispenserTFL = 1, EWDispenserBL = 2, EWDispenserTBR = 2, LaserCode10 = 8, MountNVG = false },
    pylons = {
        default = {
         [1] = { CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}" },
         [2] = { CLSID = "LAU_117_AGM_65G" },
         [3] = { CLSID = "LAU_117_AGM_65G" },
         [4] = { CLSID = "{GAU_12_Equalizer}" },
         [6] = { CLSID = "LAU_117_AGM_65G" },
         [7] = { CLSID = "LAU_117_AGM_65G" },
         [8] = { CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}" },
         -- Payload.Decade2000.Task.sead.pylon01={AGM_122_SIDEARM}
         -- Payload.Decade2000.Task.sead.pylon02=LAU_117_AGM_65G
         -- Payload.Decade2000.Task.sead.pylon03=LAU_117_AGM_65G
         -- Payload.Decade2000.Task.sead.pylon04={GAU_12_Equalizer}
         -- Payload.Decade2000.Task.sead.pylon05={ALQ_164_RF_Jammer}
         -- Payload.Decade2000.Task.sead.pylon06=LAU_117_AGM_65G
         -- Payload.Decade2000.Task.sead.pylon07=LAU_117_AGM_65G
         -- Payload.Decade2000.Task.sead.pylon08={AGM_122_SIDEARM}
        }
    }
}
