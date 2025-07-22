-- ====================================================================================
-- (DCS LUA ADD-ON) CONVERTER - UNITS CONVERSION FUNCTIONS
--
-- DCSEx.converter.celsiusToFahrenheit(t)
-- DCSEx.converter.degreesToRadians(degrees)
-- DCSEx.converter.fahrenheitToCelsius(fahrenheit)
-- DCSEx.converter.feetToMeters(feet)
-- DCSEx.converter.kelvinToCelsius(t)
-- DCSEx.converter.kelvinToFahrenheit(t)
-- DCSEx.converter.kmphToMps(kmph)
-- DCSEx.converter.knotsToMps(knots)
-- DCSEx.converter.metersToFeet(meters)
-- DCSEx.converter.metersToNM(meters)
-- DCSEx.converter.mpsToKmph(mps)
-- DCSEx.converter.mpsToKnots(mps)
-- DCSEx.converter.nmToMeters(nm)
-- DCSEx.converter.radiansToDegrees(radians)
-- ====================================================================================

DCSEx.converter = {}

-------------------------------------
-- Converts Celsius degrees to Fahrenheit
-- @param t Temperature in Celsius degrees
-- @return Temperature in Fahrenheit degrees
-------------------------------------
function DCSEx.converter.celsiusToFahrenheit(t)
    return t * (9 / 5) + 32
end

-------------------------------------
-- Converts angle in degrees to radians.
-- @param degrees Angle in degrees
-- @return Angle in radians
-------------------------------------
function DCSEx.converter.degreesToRadians(degrees)
    return degrees * math.pi / 180
end

-------------------------------------
-- Converts Fahrenheit degrees to Celsius
-- @param fahrenheit Temperature in Fahrenheit degrees
-- @return Temperature in Celsius degrees
-------------------------------------
function DCSEx.converter.fahrenheitToCelsius(fahrenheit)
    return (fahrenheit - 32) * (5 / 9)
end

-------------------------------------
-- Converts feet to meters.
-- @param feet Distance in feet
-- @return Distance in meters
-------------------------------------
function DCSEx.converter.feetToMeters(feet)
    return feet * 0.3048
end

-------------------------------------
-- Converts Kelvin degrees to Celsius
-- @param kelvin Temperature in Kelvin degrees
-- @return Temperature in Celsius degrees
-------------------------------------
function DCSEx.converter.kelvinToCelsius(t)
    return t - 273.15
end

-------------------------------------
-- Converts Kelvin degrees to Fahrenheit
-- @param kelvin Temperature in Kelvin degrees
-- @return Temperature in Fahrenheit degrees
-------------------------------------
function DCSEx.converter.kelvinToFahrenheit(t)
    return DCSEx.converter.celsiusToFahrenheit(DCSEx.converter.kelvinToCelsius(t))
end

-------------------------------------
-- Converts kilometers per hour to meters per second.
-- @param kmph speed in km/h
-- @return speed in m/s
-------------------------------------
function DCSEx.converter.kmphToMps(kmph)
    return kmph / 3.6
end

-------------------------------------
-- Converts knots to meters per second.
-- @param knots speed in knots
-- @return speed in m/s
-------------------------------------
function DCSEx.converter.knotsToMps(knots)
    return knots * 1852 / 3600
end

-------------------------------------
-- Converts meters to feet.
-- @param meters distance in meters
-- @return distance in feet
-------------------------------------
function DCSEx.converter.metersToFeet(meters)
    return meters / 0.3048
end

-------------------------------------
-- Converts meters to nautical miles.
-- @param meters distance in meters
-- @return distance in nautical miles
-------------------------------------
function DCSEx.converter.metersToNM(meters)
    return meters / 1852
end

-------------------------------------
-- Converts meters per second to kilometers per hour.
-- @param mps speed in m/s
-- @return speed in km/h
-------------------------------------
function DCSEx.converter.mpsToKmph(mps)
    return mps * 3.6
end

-------------------------------------
-- Converts meters per second to knots.
-- @param mps speed in m/s
-- @return speed in knots
-------------------------------------
function DCSEx.converter.mpsToKnots(mps)
    return mps * 3600 / 1852
end

-------------------------------------
-- Converts nautical miles to meters.
-- @param nm distance in nautical miles
-- @return distance in meters
-------------------------------------
function DCSEx.converter.nmToMeters(nm)
    return nm * 1852
end

-------------------------------------
-- Converts angle in radians to degrees.
-- @param degrees Angle in radians
-- @return Angle in degrees
-------------------------------------
function DCSEx.converter.radiansToDegrees(radians)
    return radians * 180 / math.pi
end
