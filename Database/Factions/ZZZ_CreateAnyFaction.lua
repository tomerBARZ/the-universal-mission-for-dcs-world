-- The "Any" faction has access to all units from all other factions
do
    Library.factions.tables["Any"] = {}
    Library.factions.tables["Any"].theaters = {}
    Library.factions.tables["Any"].timePeriods = {}

    Library.factions.tables["Any"].units = {}

    local function copyUnitTableToAny(factionID, timePeriod)
        Library.factions.tables["Any"].units[timePeriod] = {}

        for k,_ in pairs(Library.factions.tables[factionID].units[timePeriod]) do
            Library.factions.tables["Any"].units[timePeriod][k] = Library.factions.tables["Any"].units[timePeriod][k] or {}

            for _,u in ipairs(Library.factions.tables[factionID].units[timePeriod][k]) do
                if not DCSEx.table.contains(Library.factions.tables["Any"].units[timePeriod][k], u) then
                    table.insert(Library.factions.tables["Any"].units[timePeriod][k], u)
                end
            end
        end
    end

    for k,_ in pairs(Library.factions.tables) do
        if k ~= "Any" then
            for _,tp in pairs(DCSEx.enums.timePeriod) do
                copyUnitTableToAny(k, tp)
            end
        end
    end
end
