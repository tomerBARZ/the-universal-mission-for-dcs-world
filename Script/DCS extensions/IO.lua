-- ====================================================================================
-- DCSEX.IO - HANDLES READING/WRITING FILES
-- ====================================================================================
-- DCSEx.io.canReadAndWrite()
-- DCSEx.io.load(fileName)
-- DCSEx.io.save(fileName, str)
-- ====================================================================================

DCSEx.io = {}

-------------------------------------
-- Returns true if the IO table has been unsanitized (allowing IO operations) and false if it hasn't been
-------------------------------------
-- @return A boolean
-------------------------------------
function DCSEx.io.canReadAndWrite()
    return io ~= nil
end

-------------------------------------
-- Loads a string from a text file
-------------------------------------
-- @param fileName Name of the file to read
-- @return A string, or nil if something went wrong
-------------------------------------
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
-- Writes a string to a text file
-------------------------------------
-- @param fileName Name of the file to write to. It will be overwritten if it exists.
-- @param values Key/value table containing the values to save
-- @param str String to write
-- @return True if everything went right, false otherwise
-------------------------------------
function DCSEx.io.save(fileName, str)
    -- IO table is sanitized, cannot read/write to disk
    if not DCSEx.io.canReadAndWrite() then return false end

    local saveFile = io.open(fileName, "w")
    if not saveFile then return false end
    saveFile:write(str)
    saveFile:close()

    return true
end
