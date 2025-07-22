-- ====================================================================================
-- (DCS LUA ADD-ON) TABLE - EXTENSION TO THE "TABLE" TABLE
--
-- DCSEx.table.contains(t, val)
-- DCSEx.table.containsKey(t, k)
-- DCSEx.table.containsAll(t, values)
-- DCSEx.table.containsAny(t, values)
-- DCSEx.table.countNonNils(t)
-- DCSEx.table.deepCopy(orig)
-- DCSEx.table.dump(t)
-- DCSEx.table.getKeys(t)
-- DCSEx.table.getKeyFromValue(t, val)
-- DCSEx.table.getRandom(t)
-- DCSEx.table.getRandomIndex(t)
-- DCSEx.table.shuffle(t)
-- ====================================================================================

DCSEx.table = {}

-------------------------------------
-- Returns true if table t contains value val
-- @param t A table
-- @param val A value
-- @return True if the table contains the value, false otherwise
-------------------------------------
function DCSEx.table.contains(t, val)
    if not t then return false end

    for _,v in pairs(t) do
        if v == val then return true end
    end

    return false
end

-------------------------------------
-- Returns true if table t contains key k
-- @param t A table
-- @param k A key
-- @return True if the table contains the key, false otherwise
-------------------------------------
function DCSEx.table.containsKey(t, k)
    if not t then return false end
    if t[k] then return true end

    return false
end

-------------------------------------
-- Returns true if table t contains all values in table values
-- @param t A table
-- @param values A table of values
-- @return True if the table contains all values, false otherwise
-------------------------------------
function DCSEx.table.containsAll(t, values)
    if not t then return false end

    for _,v in pairs(values) do
        if not DCSEx.table.contains(t, v) then
            return false
        end
    end

    return true
end

-------------------------------------
-- Returns true if table t contains at least one value in table values
-- @param t A table
-- @param values A table of values
-- @return True if the table contains at least one value, false otherwise
-------------------------------------
function DCSEx.table.containsAny(t, values)
    if not t then return false end

    for _,v in pairs(values) do
        if DCSEx.table.contains(t, v) then
            return true
        end
    end

    return false
end

function DCSEx.table.containsAllKeys(t, keys)
    if not t then return false end

    for _,k in pairs(keys) do
        if not DCSEx.table.containsKey(t, k) then
            return false
        end
    end

    return true
end

function DCSEx.table.containsAnyKeys(t, keys)
    if not t then return false end

    for _,k in pairs(keys) do
        if DCSEx.table.containsKey(t, k) then
            return true
        end
    end

    return false
end

-------------------------------------
-- Returns the number of non-nils elements in a table
-- @param t A table
-- @return A number
-------------------------------------
function DCSEx.table.countNonNils(t)
    local count = 0
    for _,v in pairs(t) do
        if v ~= nil then count = count + 1 end
    end

    return count
end

-------------------------------------
-- Returns a deep copy of the table, doesn't work with recursive tables (code from http://lua-users.org/wiki/CopyTable)
-- @param orig A table
-- @return A deep copied clone of the table
-------------------------------------
function DCSEx.table.deepCopy(orig)
    -- Not a table
    if type(orig) ~= "table" then
        return orig
    end

    local copy = {}
    for orig_key, orig_value in next, orig, nil do
        copy[DCSEx.table.deepCopy(orig_key)] = DCSEx.table.deepCopy(orig_value)
    end
    setmetatable(copy, DCSEx.table.deepCopy(getmetatable(orig)))

    return copy
end

-------------------------------------
-- Dumps the content of a table as a string
-- @param orig A table
-- @return A string representaton of the table
-------------------------------------
function DCSEx.table.dump(t)
    if type(t) == 'table' then
       local s = '{ '
       for k,v in pairs(t) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. DCSEx.table.dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(t)
    end
 end

-------------------------------------
-- Returns the key associated to a value in a table, or nil if not found
-- @param t A table
-- @param val A value
-- @return The key associated to this value in the table, or nil
-------------------------------------
function DCSEx.table.getKeyFromValue(t, val)
    for k, v in pairs(t) do
        if v == val then return k end
    end
    return nil
end

-------------------------------------
-- Returns all the keys in an associative table
-- @param t A table
-- @return An array of keys
-------------------------------------
function DCSEx.table.getKeys(t)
    local keys = {}
    local n = 1

    for k,_ in pairs(t) do
        keys[n] = k
        n = n + 1
    end

    table.sort(keys)
    return keys
end

-------------------------------------
-- Returns a random value from a numerically-indexed table
-- @param t A table
-- @return A random element from the table
-------------------------------------
function DCSEx.table.getRandom(t)
    return t[math.random(#t)]
end

-------------------------------------
-- Returns a random index from a numerically-indexed table
-- @param t A table
-- @return A random index from the table
-------------------------------------
function DCSEx.table.getRandomIndex(t)
    return math.random(#t)
end

-------------------------------------
-- Randomly shuffles a numerically-indexed table
-- @param t A table
-- @return A table with shuffled values
-------------------------------------
function DCSEx.table.shuffle(t)
    local len, random = #t, math.random
    for i = len, 2, -1 do
        local j = random(1, i)
        t[i], t[j] = t[j], t[i]
    end
    return t
end
