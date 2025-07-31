-- ====================================================================================
-- DCSEX.STRING - FUNCTIONS RELATED TO STRING MANIPULATION
-- ====================================================================================
-- DCSEx.string.firstToUpper(str)
-- DCSEx.string.getReadingTime(message)
-- DCSEx.string.join(table, separator)
-- DCSEx.string.getTimeString(timeInSeconds, separator)
-- DCSEx.string.toStringNumber(number, firstToUpper)
-- DCSEx.string.toStringThousandsSeparator(number)
-- DCSEx.string.split(str, separator)
-- DCSEx.string.startsWith(haystack, needle)
-- DCSEx.string.trim(str)
-- ====================================================================================

DCSEx.string = {}

-------------------------------------
-- Uppercases the fist letter of a string
-------------------------------------
-- @param str A string
-- @return A string, with the first letter cast to upper case
-------------------------------------
function DCSEx.string.firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

-------------------------------------
-- Estimates the time (in seconds) required to read a string
-------------------------------------
-- @param message A text message
-- @return A duration in seconds
-------------------------------------
function DCSEx.string.getReadingTime(message)
    message = message or ""
    message = tostring(message)

    return DCSEx.math.clamp(#message / 8.7, 3.0, 15.0) -- 10.7 letters per second, minimum length 3 seconds, max length 15 seconds
end

-------------------------------------
-- Joins a table of string into a single string
-------------------------------------
-- @param table A table of strings
-- @param separator Separator used to glue table entries (default: "")
-- @return A string
-------------------------------------
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

-------------------------------------
-- Converts a time of day (in seconds since midnight) to a human-readable time string
-------------------------------------
-- @param timeInSeconds Number of seconds since midnight (default: current time)
-- @param separator Separator between minutes and seconds (":", "h"...) (default: "")
-- @return The time, as as string
-------------------------------------
function DCSEx.string.getTimeString(timeInSeconds, separator)
    timeInSeconds = timeInSeconds or timer.getAbsTime()
    separator = separator or ""

    timeInSeconds = math.max(0, timeInSeconds) % 86400

    local hours = math.floor(timeInSeconds / 3600)
    local minutes = math.floor(timeInSeconds / 60 - hours * 60)

    local hoursStr = tostring(hours)
    if #hoursStr == 1 then hoursStr = "0"..hoursStr end

    local minutesStr = tostring(minutes)
    if #minutesStr == 1 then minutesStr = "0"..minutesStr end

    return hoursStr..separator..minutesStr
end

-------------------------------------
-- Converts a numeric value between 0 and 20 into its word/string representation
-------------------------------------
-- @param number A number (>=0, <=20)
-- @return A string
-------------------------------------
function DCSEx.string.toStringNumber(number, firstToUpper)
    firstToUpper = firstToUpper or false
    local NUMBERS = { "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen", "twenty" }

    if number + 1 <= #NUMBERS then
        local str = NUMBERS[number + 1]
        if firstToUpper then str = DCSEx.string.firstToUpper(str) end
        return str
    end

    return DCSEx.string.toStringThousandsSeparator(number)
end

-------------------------------------
-- Converts a numeric value to a string, with proper thousands separators
-- (Code taken from https://stackoverflow.com/questions/10989788/format-integer-in-lua)
-------------------------------------
-- @param number A number
-- @return A string
-------------------------------------
function DCSEx.string.toStringThousandsSeparator(number)
  local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
  int = int:reverse():gsub("(%d%d%d)", "%1,")
  return minus .. int:reverse():gsub("^,", "") .. fraction
end

-------------------------------------
-- Splits a string into a table
-------------------------------------
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
-------------------------------------
-- @param haystack The string
-- @param needle The substring to look for
-- @return True if it starts with the substring, false otherwise
-------------------------------------
function DCSEx.string.startsWith(haystack, needle)
    return haystack:sub(1, #needle) == needle
end

-------------------------------------
-- Trims a string
-------------------------------------
-- @param str A string
-- @return A string
-------------------------------------
function DCSEx.string.trim(str)
    return (str:gsub("^%s*(.-)%s*$", "%1"))
end
