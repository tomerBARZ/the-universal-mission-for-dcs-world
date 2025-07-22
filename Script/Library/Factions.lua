Library.factions = {}
Library.factions.defaults = { "USA", "Russia" }
Library.factions.tables = {}

--{{FACTIONS}}--

-- If default red faction is "Russia" and "Russia" is named "USSR" in this time period, change its name in the default
if Library.factions.tables["USSR"] and Library.factions.defaults[coalition.side.RED] == "Russia" then
    Library.factions.defaults[coalition.side.RED] = "USSR"
end

function Library.factions.getUnits(faction, unitFamilies, count, singleType)
    singleType = singleType or false
    local timePeriod = TUM.settings.getValue(TUM.settings.id.TIME_PERIOD)

    if not unitFamilies then return nil end
    if not Library.factions.tables[faction] then return nil end
    if not Library.factions.tables[faction].units then return nil end
    if not Library.factions.tables[faction].units[timePeriod] then return nil end

    if type(unitFamilies) == "number" then unitFamilies = { unitFamilies } end
    count = math.max(1, count or 1)

    local validUnits = {}
    for _,f in ipairs(unitFamilies) do
        local unitList = Library.factions.tables[faction].units[timePeriod][f]

        if unitList and #unitList > 0 then
            for __,u in ipairs(unitList) do
                if not DCSEx.table.contains(validUnits, u) then
                    table.insert(validUnits, u)
                end
            end
        end
    end
    if #validUnits == 0 then return nil end

    local selectedUnits = {}
    if singleType then
        local unitType = DCSEx.table.getRandom(validUnits)
        for _=1,count do
            table.insert(selectedUnits, unitType)
        end
    else
        for _=1,count do
            table.insert(selectedUnits, DCSEx.table.getRandom(validUnits))
        end
    end

    return selectedUnits
end

do
    -- local function mergeFactions()
    -- end

    -- local function setDefaultUnitsIfMissing(unitTypes, defaults)
    --     if not unitTypes or #unitTypes == 0 then
    --         return defaults
    --     end

    --     return unitTypes
    -- end

    -- for k,_ in pairs(Library.factions) do
        

    --     if not Library.factions[k][DCSEx.enums.unitFamily.SHIP_CARGO] = { "Dry-cargo ship-1", "Dry-cargo ship-2", "ELNYA", "Ship_Tilde_Supply" },
    -- end
end
