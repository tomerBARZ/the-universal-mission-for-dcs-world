-- ====================================================================================
-- (DCS LUA ADD-ON) STRING - EXTENSION TO THE "STRING" TABLE
--
-- DCSEx.string.firstToUpper(str)
-- DCSEx.string.getReadingTime(message)
-- DCSEx.string.split(str, separator)
-- DCSEx.string.startsWith(haystack, needle)
-- DCSEx.string.trim(str)
-- ====================================================================================

DCSEx.string = {}

-------------------------------------
-- Uppercases the fist letter of a string
-- @param str A string
-- @return A string, with the first letter cast to upper case
-------------------------------------
function DCSEx.string.firstToUpper(str)
    return (str:gsub("^%l", DCSEx.string.upper))
end

-------------------------------------
-- Estimates the time (in seconds) required to read a string
-- @param message A text message
-- @return A duration in seconds
-------------------------------------
function DCSEx.string.getReadingTime(message)
    message = message or ""
    message = tostring(message)

    return DCSEx.math.clamp(#message / 8.7, 3.0, 15.0) -- 10.7 letters per second, minimum length 3 seconds, max length 15 seconds
end

-- TODO: description, update file header
function DCSEx.string.join(table, separator)
    local joinedString = ""

    for i=1,#table do
        joinedString = joinedString..tostring(table[i])
        if i < #table then
            joinedString = joinedString..separator
        end
    end

    return joinedString
end

-- TODO: description, file header
-- Code from https://stackoverflow.com/questions/10989788/format-integer-in-lua
function DCSEx.string.toStringThousandsSeparator(number)
  local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
  int = int:reverse():gsub("(%d%d%d)", "%1,")
  return minus .. int:reverse():gsub("^,", "") .. fraction
end

-------------------------------------
-- Splits a string
-- @param str The string to split
-- @param separator The string to split
-- @return A table of split strings
-------------------------------------
function DCSEx.string.split(str, separator)
    separator = separator or "%s"

    local t = {}
    for s in DCSEx.string.gmatch(str, "([^"..separator.."]+)") do table.insert(t, s) end
    return t
end

-------------------------------------
-- Does a string starts with the given substring?
-- @param haystack The string
-- @param needle The substring to look for
-- @return True if it starts with the substring, false otherwise
-------------------------------------
function DCSEx.string.startsWith(haystack, needle)
    return haystack:sub(1, #needle) == needle
end

-------------------------------------
-- Trims a string
-- @param str A string
-- @return A string
-------------------------------------
function DCSEx.string.trim(str)
    return (str:gsub("^%s*(.-)%s*$", "%1"))
end
