do
    local abInfo = {}

    local airbases = world.getAirbases()

    local function extractAirbaseInfo(ab)
        if ab:getDesc().category ~= Airbase.Category.SHIP then return nil end
        local abDesc = airbases:getDesc()
        if not abDesc then return nil end

        local airbase = {}
        airbase.id = airbase.getID()
        airbase.name = abDesc.displayName
        airbase.coordinates = ab:getPoint()

        local parking = airbases:getParking()
        if not parking then return nil end
        for _,p in ipairs(parking) do
            if p.Term_Type == 16 then
                airbase.runway = p.vTerminalPos
            end
        end

        return airbase
    end

    for _,ab in ipairs(airbases) do
        local airbaseInfo = extractAirbaseInfo(ab)
        if airbaseInfo then
            table.insert(airbases, airbaseInfo)
        end
    end

    local jsonAirbases = net.lua2json(airbases)
    trigger.action.outText(jsonAirbases, 3600, true)
end