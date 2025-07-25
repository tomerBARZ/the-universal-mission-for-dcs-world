-- ====================================================================================
-- TUM.MIZCLEANER - REMOVED UNWANTED UNIT GROUPS FROM THE MIZ FILE
-- ====================================================================================
-- (local) removeAIWingmen()
-- TUM.mizCleaner.onStartUp()
-- ====================================================================================

TUM.mizCleaner = {}

do
    -------------------------------------
    -- Removes all AI wingmen units
    -------------------------------------
    local function removeAIWingmen()
        local groups = DCSEx.envMission.getGroups(TUM.settings.getPlayerCoalition())

        local aiWingMenToRemove = {}
        for _,g in ipairs(groups) do
            if g.units then
                local isPlayerGroup = false

                for _,u in ipairs(g.units) do
                    if u.skill == "Player" or u.skill == "Client" then
                        isPlayerGroup = true
                    end
                end

                if isPlayerGroup then
                    for _,u in ipairs(g.units) do
                        if u.skill ~= "Player" and u.skill ~= "Client" then
                            table.insert(aiWingMenToRemove, u.unitId)
                        end
                    end
                end
            end
        end

        if #aiWingMenToRemove > 0 then
            for _,id in ipairs(aiWingMenToRemove) do
                local u = DCSEx.world.getUnitByID(id)
                if u then u:destroy() end
            end
            TUM.log("Removed "..tostring(#aiWingMenToRemove).." AI wingmen from the mission.\nPlease do not add AI wingmen to the mission, The Universal Mission uses its own wingman system.", TUM.logLevel.WARNING)
        end
    end

    -------------------------------------
    -- Called on mission start up
    -- @return True if started up properly, false if an error happened
    -------------------------------------
    function TUM.mizCleaner.onStartUp()
        removeAIWingmen()
        return true
    end
end
