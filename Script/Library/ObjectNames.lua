Library.objectNames = {}

do
    local namesTable = {
        ["F-16C_50"] = "F-16C",
        ["FA-18C_hornet"] = "F/A-18C",
        ["speedboat"] = "speedboat"
    }

    function Library.objectNames.get(obj)
        if not obj then return "nothing" end

        -- First, try to find a custom name in the names table
        local typeName = obj:getTypeName()
        if typeName and namesTable[typeName] then
            return namesTable[typeName]
        end

        -- Else, try to find a display name in the description
        local desc = obj:getDesc()
        if desc and desc.DisplayName then
            return desc.DisplayName
        end

        -- If nothing else was found, return the internal typename
        if not typeName then return "unknown" end
        return typeName
    end
end