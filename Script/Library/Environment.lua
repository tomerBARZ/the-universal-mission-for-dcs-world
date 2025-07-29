Library.environment = {}

Library.environment.windAmount = {
    CALM = 1,
    LIGHT_BREEZE = 2,
    MODERATE_BREEZE = 3,
    STRONG_BREEZE = 4,
    GALE = 5,
    STORM = 6
}

do
    local DAYTIME_TABLE = {
        ["Afghanistan"] = {
            { 05 * 60 + 31, 18 * 60 + 33 },
            { 05 * 60 + 14, 19 * 60 + 00 },
            { 04 * 60 + 40, 19 * 60 + 24 },
            { 03 * 60 + 53, 19 * 60 + 54 },
            { 03 * 60 + 12, 20 * 60 + 27 },
            { 02 * 60 + 54, 20 * 60 + 53 },
            { 03 * 60 + 09, 20 * 60 + 48 },
            { 03 * 60 + 42, 20 * 60 + 12 },
            { 04 * 60 + 11, 19 * 60 + 24 },
            { 04 * 60 + 35, 18 * 60 + 42 },
            { 04 * 60 + 59, 18 * 60 + 15 },
            { 05 * 60 + 22, 18 * 60 + 14 },
        },
        ["Caucasus"] = {
            { 08 * 60 + 26, 17 * 60 + 57 },
            { 07 * 60 + 49, 18 * 60 + 30 },
            { 07 * 60 + 14, 19 * 60 + 01 },
            { 07 * 60 + 30, 19 * 60 + 34 },
            { 06 * 60 + 35, 20 * 60 + 06 },
            { 05 * 60 + 33, 20 * 60 + 40 },
            { 06 * 60 + 06, 20 * 60 + 18 },
            { 06 * 60 + 39, 19 * 60 + 45 },
            { 07 * 60 + 11, 19 * 60 + 13 },
            { 08 * 60 + 02, 18 * 60 + 40 },
            { 08 * 60 + 17, 18 * 60 + 07 },
            { 08 * 60 + 39, 17 * 60 + 45 },
        },
        ["Falklands"] = {
            { 04 * 60 + 42, 20 * 60 + 48 },
            { 05 * 60 + 32, 19 * 60 + 54 },
            { 06 * 60 + 24, 18 * 60 + 43 },
            { 07 * 60 + 18, 17 * 60 + 40 },
            { 08 * 60 + 08, 16 * 60 + 57 },
            { 08 * 60 + 51, 16 * 60 + 56 },
            { 09 * 60 + 04, 17 * 60 + 31 },
            { 08 * 60 + 33, 18 * 60 + 19 },
            { 07 * 60 + 33, 19 * 60 + 07 },
            { 06 * 60 + 24, 20 * 60 + 01 },
            { 05 * 60 + 17, 20 * 60 + 53 },
            { 04 * 60 + 36, 21 * 60 + 17 },
        },
        ["GermanyCW"] = {
            { 08 * 60 + 09, 16 * 60 + 25 },
            { 07 * 60 + 22, 17 * 60 + 19 },
            { 06 * 60 + 20, 18 * 60 + 11 },
            { 06 * 60 + 08, 20 * 60 + 05 },
            { 05 * 60 + 10, 20 * 60 + 56 },
            { 04 * 60 + 42, 21 * 60 + 31 },
            { 05 * 60 + 02, 21 * 60 + 22 },
            { 05 * 60 + 49, 20 * 60 + 31 },
            { 06 * 60 + 40, 19 * 60 + 21 },
            { 07 * 60 + 32, 18 * 60 + 11 },
            { 07 * 60 + 28, 16 * 60 + 13 },
            { 08 * 60 + 11, 15 * 60 + 52 },
        },
        ["Iraq"] = {
            { 07 * 60 + 06, 17 * 60 + 33 },
            { 06 * 60 + 58, 17 * 60 + 58 },
            { 06 * 60 + 30, 18 * 60 + 21 },
            { 05 * 60 + 50, 18 * 60 + 44 },
            { 05 * 60 + 14, 19 * 60 + 06 },
            { 04 * 60 + 53, 19 * 60 + 15 },
            { 04 * 60 + 56, 19 * 60 + 03 },
            { 05 * 60 + 15, 18 * 60 + 28 },
            { 05 * 60 + 36, 17 * 60 + 48 },
            { 05 * 60 + 56, 17 * 60 + 11 },
            { 06 * 60 + 20, 16 * 60 + 54 },
            { 06 * 60 + 47, 17 * 60 + 04 },
        },
        ["Kola"] = {
            { 11 * 60 + 52, 14 * 60 + 02 },
            { 09 * 60 + 15, 16 * 60 + 50 },
            { 07 * 60 + 07, 18 * 60 + 47 },
            { 04 * 60 + 49, 20 * 60 + 48 },
            { 02 * 60 + 10, 23 * 60 + 24 },
            { 00 * 60 + 00, 23 * 60 + 59 },
            { 00 * 60 + 00, 23 * 60 + 59 },
            { 03 * 60 + 59, 21 * 60 + 41 },
            { 06 * 60 + 03, 19 * 60 + 19 },
            { 07 * 60 + 56, 17 * 60 + 08 },
            { 10 * 60 + 16, 14 * 60 + 47 },
            { 12 * 60 + 00, 13 * 60 + 01 },
        },
        ["MarianaIslands"] = {
            { 07 * 60 + 10, 16 * 60 + 15 },
            { 06 * 60 + 50, 16 * 60 + 45 },
            { 06 * 60 + 13, 17 * 60 + 11 },
            { 05 * 60 + 31, 19 * 60 + 35 },
            { 05 * 60 + 00, 19 * 60 + 59 },
            { 04 * 60 + 49, 20 * 60 + 18 },
            { 05 * 60 + 31, 20 * 60 + 17 },
            { 05 * 60 + 24, 19 * 60 + 51 },
            { 05 * 60 + 46, 19 * 60 + 10 },
            { 06 * 60 + 09, 18 * 60 + 28 },
            { 06 * 60 + 37, 15 * 60 + 58 },
            { 07 * 60 + 03, 15 * 60 + 54 },
        },
        ["MarianaIslandsWWII"] = {
            { 07 * 60 + 10, 16 * 60 + 15 },
            { 06 * 60 + 50, 16 * 60 + 45 },
            { 06 * 60 + 13, 17 * 60 + 11 },
            { 05 * 60 + 31, 19 * 60 + 35 },
            { 05 * 60 + 00, 19 * 60 + 59 },
            { 04 * 60 + 49, 20 * 60 + 18 },
            { 05 * 60 + 31, 20 * 60 + 17 },
            { 05 * 60 + 24, 19 * 60 + 51 },
            { 05 * 60 + 46, 19 * 60 + 10 },
            { 06 * 60 + 09, 18 * 60 + 28 },
            { 06 * 60 + 37, 15 * 60 + 58 },
            { 07 * 60 + 03, 15 * 60 + 54 },
        },
        ["Nevada"] = {
            { 07 * 60 + 21, 16 * 60 + 19 },
            { 06 * 60 + 58, 16 * 60 + 51 },
            { 06 * 60 + 21, 17 * 60 + 18 },
            { 06 * 60 + 37, 18 * 60 + 44 },
            { 06 * 60 + 04, 19 * 60 + 10 },
            { 05 * 60 + 53, 19 * 60 + 29 },
            { 06 * 60 + 05, 19 * 60 + 27 },
            { 06 * 60 + 29, 19 * 60 + 00 },
            { 06 * 60 + 53, 18 * 60 + 17 },
            { 07 * 60 + 28, 17 * 60 + 34 },
            { 06 * 60 + 47, 16 * 60 + 02 },
            { 07 * 60 + 14, 15 * 60 + 58 },
        },
        ["Normandy"] = {
            { 09 * 60 + 23, 17 * 60 + 01 },
            { 08 * 60 + 43, 17 * 60 + 52 },
            { 07 * 60 + 48, 18 * 60 + 37 },
            { 06 * 60 + 43, 19 * 60 + 24 },
            { 05 * 60 + 50, 20 * 60 + 09 },
            { 05 * 60 + 26, 20 * 60 + 40 },
            { 05 * 60 + 42, 20 * 60 + 34 },
            { 06 * 60 + 23, 19 * 60 + 51 },
            { 07 * 60 + 08, 18 * 60 + 48 },
            { 07 * 60 + 53, 17 * 60 + 44 },
            { 08 * 60 + 42, 16 * 60 + 52 },
            { 09 * 60 + 21, 16 * 60 + 34 },
        },
        ["PersianGulf"] = {
            { 07 * 60 + 34, 17 * 60 + 17 },
            { 07 * 60 + 22, 17 * 60 + 39 },
            { 06 * 60 + 55, 17 * 60 + 55 },
            { 06 * 60 + 23, 18 * 60 + 09 },
            { 06 * 60 + 01, 18 * 60 + 25 },
            { 05 * 60 + 55, 18 * 60 + 39 },
            { 06 * 60 + 05, 18 * 60 + 40 },
            { 06 * 60 + 20, 18 * 60 + 21 },
            { 06 * 60 + 32, 17 * 60 + 50 },
            { 06 * 60 + 45, 17 * 60 + 19 },
            { 07 * 60 + 04, 16 * 60 + 58 },
            { 07 * 60 + 25, 16 * 60 + 58 },
        },
        ["SinaiMap"] = {
            { 07 * 60 + 10, 16 * 60 + 15 },
            { 06 * 60 + 50, 16 * 60 + 45 },
            { 06 * 60 + 13, 17 * 60 + 11 },
            { 05 * 60 + 31, 19 * 60 + 35 },
            { 05 * 60 + 00, 19 * 60 + 59 },
            { 04 * 60 + 49, 20 * 60 + 18 },
            { 05 * 60 + 31, 20 * 60 + 17 },
            { 05 * 60 + 24, 19 * 60 + 51 },
            { 05 * 60 + 46, 19 * 60 + 10 },
            { 06 * 60 + 09, 18 * 60 + 28 },
            { 06 * 60 + 37, 15 * 60 + 58 },
            { 07 * 60 + 03, 15 * 60 + 54 },
        },
        ["Syria"] = {
            { 07 * 60 + 10, 16 * 60 + 15 },
            { 06 * 60 + 50, 16 * 60 + 45 },
            { 06 * 60 + 13, 17 * 60 + 11 },
            { 05 * 60 + 31, 19 * 60 + 35 },
            { 05 * 60 + 00, 19 * 60 + 59 },
            { 04 * 60 + 49, 20 * 60 + 18 },
            { 05 * 60 + 31, 20 * 60 + 17 },
            { 05 * 60 + 24, 19 * 60 + 51 },
            { 05 * 60 + 46, 19 * 60 + 10 },
            { 06 * 60 + 09, 18 * 60 + 28 },
            { 06 * 60 + 37, 15 * 60 + 58 },
            { 07 * 60 + 03, 15 * 60 + 54 },
        },
        ["TheChannel"] = {
            { 09 * 60 + 23, 17 * 60 + 01 },
            { 08 * 60 + 43, 17 * 60 + 52 },
            { 07 * 60 + 48, 18 * 60 + 37 },
            { 06 * 60 + 43, 19 * 60 + 24 },
            { 05 * 60 + 50, 20 * 60 + 09 },
            { 05 * 60 + 26, 20 * 60 + 40 },
            { 05 * 60 + 42, 20 * 60 + 34 },
            { 06 * 60 + 23, 19 * 60 + 51 },
            { 07 * 60 + 08, 18 * 60 + 48 },
            { 07 * 60 + 53, 17 * 60 + 44 },
            { 08 * 60 + 42, 16 * 60 + 52 },
            { 09 * 60 + 21, 16 * 60 + 34 },
        }
    }

    function Library.environment.getDayTime(monthIndex, sunset)
        monthIndex = DCSEx.math.clamp(monthIndex or env.mission.date.Month, 1, 12)
        sunset = sunset or false

        if not env or not env.mission or not env.mission.theatre then return 0 end
        if not DAYTIME_TABLE[env.mission.theatre] then return 0 end

        local sunIndex = 1
        if sunset then sunIndex = 2 end

        return DAYTIME_TABLE[env.mission.theatre][monthIndex][sunIndex] * 60
    end

    function Library.environment.isItNightTime(timeOfDayInSeconds)
        if not env or not env.mission or not env.mission.theatre then return false end
        if not DAYTIME_TABLE[env.mission.theatre] then return false end

        timeOfDayInSeconds = math.max(0, timeOfDayInSeconds or timer.getAbsTime())

        if timeOfDayInSeconds > 86400 then
            while timeOfDayInSeconds > 86400 do
                timeOfDayInSeconds = timeOfDayInSeconds - 86400
            end
        end

        local sunriseTime = Library.environment.getDayTime(nil, false)
        local sunsetTime = Library.environment.getDayTime(nil, true)

        return timeOfDayInSeconds < sunriseTime or timeOfDayInSeconds > sunsetTime
    end

    function Library.environment.getWindLevel()
        local windSpeed = 0
        local windSpeedValuesCount = 0

        if not env or not env.mission or not env.mission.weather or not env.mission.weather.wind then
            return Library.environment.windAmount.CALM
        end

        for _,v in ipairs({"at8000", "atGround", "at2000"}) do
            if env.mission.weather.wind[v] and env.mission.weather.wind[v].speed then
                windSpeed = windSpeed + env.mission.weather.wind[v].speed
                windSpeedValuesCount = windSpeedValuesCount + 1
            end
        end

        if windSpeedValuesCount == 0 then
            return Library.environment.windAmount.CALM
        end

        windSpeed = windSpeed / windSpeedValuesCount
        if windSpeed < 1 then
            return Library.environment.windAmount.CALM
        elseif windSpeed < 4 then
            return Library.environment.windAmount.LIGHT_BREEZE
        elseif windSpeed < 8 then
            return Library.environment.windAmount.MODERATE_BREEZE
        elseif windSpeed < 14 then
            return Library.environment.windAmount.STRONG_BREEZE
        elseif windSpeed < 21 then
            return Library.environment.windAmount.GALE
        else
            return Library.environment.windAmount.STORM
        end
    end
end