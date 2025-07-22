-- ====================================================================================
-- DCSEx.IO - HANDLES READING/WRITING FILES
-- ====================================================================================
-- DCSEx.io.canReadAndWrite()
-- DCSEx.io.load(fileName)
-- DCSEx.io.save(fileName, values)
-- ====================================================================================

DCSEx.io = {}

do
    -------------------------------------
    -- Returns true if the IO table has been unsanitized (allowing IO operations)
    -- and false if it hasn't been
    --
    -- @return A boolean
    -------------------------------------
    function DCSEx.io.canReadAndWrite()
        return io ~= nil
    end

    -------------------------------------
    -- Loads a table from a text file
    --
    -- @param fileName Name of the file to read
    -- @param obfuscate Should the file contents be obfuscated?
    -- @return A table, or nil if something went wrong
    -------------------------------------
    -- function DCSEx.io.load(fileName, obfuscate)
    --     obfuscate = obfuscate or false -- TODO: obfuscation

    --     -- IO table is sanitized, cannot read/write to disk
    --     if not DCSEx.io.canReadAndWrite() then return nil end

    --     local saveFile = io.open(fileName, "r")
    --     if not saveFile then return nil end

    --     local values = {}
    --     local rawText = saveFile:read("*all")
    --     for k, v in string.gmatch(rawText, "(%w+)=(%w+)") do
    --         local numval = tonumber(v)
    --         if numval then
    --             values[k] = tonumber(v)
    --         else
    --             values[k] = v
    --             -- trigger.action.outText("GET value \""..k.."\" AT \""..tostring(v).."\"", 1)
    --         end
    --     end
    --     saveFile:close()

    --     return values
    -- end

    function DCSEx.io.load(fileName)
        -- IO table is sanitized, cannot read/write to disk
        if not DCSEx.io.canReadAndWrite() then return nil end

        local saveFile = io.open(fileName, "r")
        if not saveFile then return nil end
        local str = saveFile:read("*all")
        saveFile:close()

        return str
    end

    -------------------------------------
    -- Saves a table to a text file
    --
    -- @param fileName Name of the file to write to
    -- @param values Key/value table containing the values to save
    -- @param obfuscate Should the file contents be obfuscated?
    -- @return True if everything went right, false otherwise
    -------------------------------------
    -- function DCSEx.io.save(fileName, values, obfuscate)
    --     obfuscate = obfuscate or false -- TODO: obfuscation

    --     -- IO table is sanitized, cannot read/write to disk
    --     if not DCSEx.io.canReadAndWrite() then return false end

    --     -- No values or not a table
    --     if values == nil then return false end
    --     if type(values) ~= "table" then return false end

    --     local saveFile = io.open(fileName, "w")
    --     if not saveFile then return false end

    --     for k,v in pairs(values) do
    --         saveFile:write(k.."="..tostring(v).."\n")
    --         -- trigger.action.outText("SET value \""..k.."\" TO \""..tostring(v).."\"", 1)
    --     end
    --     saveFile:close()

    --     return true
    -- end
    function DCSEx.io.save(fileName, str)
        -- IO table is sanitized, cannot read/write to disk
        if not DCSEx.io.canReadAndWrite() then return false end

        local saveFile = io.open(fileName, "w")
        if not saveFile then return false end
        saveFile:write(str)
        saveFile:close()

        return true
    end
end
