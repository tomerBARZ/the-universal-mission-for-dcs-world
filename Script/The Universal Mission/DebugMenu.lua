-- ====================================================================================
-- TUM.DEBUGMENU - HANDLES THE F10 DEBUG MENU
-- ====================================================================================
-- (local) doMarkersBoom()
-- TUM.debugMenu.onStartUp()
-- ====================================================================================

TUM.debugMenu = {}

do
    local function doMarkersAirBoom()
        local panels = world.getMarkPanels()
        local boomCount = 0

        for _,p in pairs(panels) do
            local nearestPoint = nil
            local nearestDistance = 99999999

            if p.text:lower() == "airboom" then
                for _,c in pairs({ Unit.Category.AIRPLANE, Unit.Category.HELICOPTER}) do
                    for _,u in DCSEx.world.getAllUnits(nil, c) do
                        local distance = DCSEx.math.getDistance3D(p.pos, u:getPoint())
                        if distance < nearestDistance then
                            nearestDistance = distance
                            nearestPoint = u:getPoint()
                        end
                    end
                end

                if nearestPoint then
                    trigger.action.explosion(nearestPoint, 1024)
                    boomCount = boomCount + 1
                end
            end
        end

        TUM.log("Detonated "..tostring(boomCount).. " \"airboom\" marker(s).")
    end

    local function doMarkersBoom()
        local panels = world.getMarkPanels()
        local boomCount = 0
        for _,p in pairs(panels) do
            if p.text:lower() == "boom" then
                trigger.action.explosion(p.pos, 8192)
                boomCount = boomCount + 1
            end
        end

        TUM.log("Detonated "..tostring(boomCount).. " \"boom\" marker(s).")
    end

    local function doAwardPointsAndObjectives()
        TUM.playerScore.award(100, "debug cheat")
        TUM.playerScore.awardCompletedObjective()
    end

    local function doSimulatePlayerLanding()
        local playerUnit = coalition.getPlayers(TUM.settings.getPlayerCoalition())[1]

        local runwayTouchEvent = { id = world.event.S_EVENT_RUNWAY_TOUCH, initiator = playerUnit }
        TUM.onEvent(runwayTouchEvent)

        local landingEvent = { id = world.event.S_EVENT_LAND, initiator = playerUnit }
        timer.scheduleFunction(TUM.onEvent, landingEvent, timer.getTime() + 1)
    end

    function TUM.debugMenu.createMenu()
        if not TUM.DEBUG_MODE then return end

        local rootMenu = missionCommands.addSubMenu("[DEBUG]")
        missionCommands.addCommand("Detonate \"boom\" map markers", rootMenu, doMarkersBoom, nil)
        missionCommands.addCommand("Detonate aircraft near \"airboom\" map markers", rootMenu, doMarkersAirBoom, nil)
        missionCommands.addCommand("Award 100 points and 1 objective", rootMenu, doAwardPointsAndObjectives, nil)
        missionCommands.addCommand("Simulate player landing", rootMenu, doSimulatePlayerLanding, nil)
        missionCommands.addCommand("Reset player stats", rootMenu, TUM.playerCareer.reset, nil)
    end
end
