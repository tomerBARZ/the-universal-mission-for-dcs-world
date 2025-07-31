-- ====================================================================================
-- DCSEX.ENVMISSION - FUNCTIONS RELATED TO THE ENV.MISSION TABLE
-- ====================================================================================
-- DCSEx.envMission.getDecade(yearOffset)
-- DCSEx.envMission.getDistanceToNearestPlayerSpawnPoint(coalition, point)
-- DCSEx.envMission.getGroup(groupID)
-- DCSEx.envMission.getGroups(sideID)
-- DCSEx.envMission.getPlayerGroups(coalitionId)
-- DCSEx.envMission.getPlayerGroupsCenterPoint(coalitionId)
-- DCSEx.envMission.setBriefing(side, text, picture)
-- ====================================================================================

DCSEx.envMission = {}

-------------------------------------
-- Returns the decade during which the mission takes place (1940 to 2010)
-------------------------------------
-- @param yearOffset An offset to apply to the actual year
-- @return The decade, as a number
-------------------------------------
function DCSEx.envMission.getDecade(yearOffset)
    return DCSEx.math.clamp(math.floor((env.mission.date.Year + (yearOffset or 0)) / 10) * 10, 1940, 2010)
end

-------------------------------------
-- Returns the distance to the nearest player spawn point
-------------------------------------
-- @param coalition Coalition the players belong to
-- @param point A vec3 or vec2
-- @return The distance, in meters, to the nearest player spawn point, or nil if no player spawn points are present
-------------------------------------
function DCSEx.envMission.getDistanceToNearestPlayerSpawnPoint(coalition, point)
    point = DCSEx.math.vec3ToVec2(point)

    local playerSlots = DCSEx.envMission.getPlayerGroups(coalition)
    if #playerSlots == 0 then return nil end

    local nearestPlayer = 999999999999999999999
    for _,p in pairs(playerSlots) do
        local dist = DCSEx.math.getDistance2D(point, p)
        if dist < nearestPlayer then nearestPlayer = dist end
    end
    return nearestPlayer
end

-------------------------------------
-- Gets information about a group
-------------------------------------
-- @param groupID Group ID
-- @return Missiondata group table or nil if ID doesn't exist
-------------------------------------
function DCSEx.envMission.getGroup(groupID)
    local allGroups = DCSEx.envMission.getGroups()

    for _, g in ipairs(allGroups) do
        if g.groupId == groupID then
            return g
        end
    end

    return nil
end

-------------------------------------
-- Gets all unit groups
-------------------------------------
-- @param sideID Coalition ID (coalition.side.*), or nil to return unit groups from all coalitions
-- @return Table of missiondata group tables
-------------------------------------
function DCSEx.envMission.getGroups(sideID)
    -- Group data are located in coalition[COAL_ID_AS_STRING].country[N][UNIT_CATEGORY_AS_STRING].group[]
    -- (e.g. coalition["blue"].country[1]["plane"].group[1])

    local validCoalitions = { [0] = "neutrals", [1] = "red", [2] = "blue"} -- by default, search all coalitions
    if sideID == coalition.side.BLUE then
        validCoalitions = { [2] = "blue"}
    elseif sideID == coalition.side.RED then
        validCoalitions = { [1] = "red" }
    elseif sideID == coalition.side.NEUTRAL then
        validCoalitions = { [0] = "neutrals" }
    end

    local groups = {}

    for coalID, coalName in pairs(validCoalitions) do -- In each coalition...
        if env.mission.coalition[coalName] then -- (if coalition exists)
            for _, countryData in pairs(env.mission.coalition[coalName].country) do -- search each country
                for _, uType in pairs({"helicopter", "plane", "ship", "static", "vehicle"}) do -- for each unit category
                    if countryData[uType] then -- (if unit category exists)
                        for _,g in pairs(countryData[uType].group) do -- for each group
                            local groupInfo = DCSEx.table.deepCopy(g)
                            groupInfo.coalition = coalID -- store coalition side for later reference
                            table.insert(groups, groupInfo)
                        end
                    end
                end
            end
        end
    end

    return groups
end

-------------------------------------
-- Gets all player groups
-------------------------------------
-- @param coalitionId Coalition ID (coalition.side.*), or nil to return unit groups from all coalitions
-- @return Table of missiondata group tables
-------------------------------------
function DCSEx.envMission.getPlayerGroups(coalitionId)
    local allGroups = DCSEx.envMission.getGroups(coalitionId)

    local playerGroups = {}

    for _, g in ipairs(allGroups) do
        local isPlayerGroup = false

        for _, u in pairs(g.units) do
            if u.skill == "Player" or u.skill == "Client" then
                isPlayerGroup = true
                break
            end
        end

        if isPlayerGroup then
            table.insert(playerGroups, DCSEx.table.deepCopy(g))
        end
    end

    return playerGroups
end

-------------------------------------
-- Return the center 2D point of all player groups
-------------------------------------
-- @param coalitionId Coalition ID (coalition.side.*), or nil to use unit groups from all coalitions
-- @return A 2D point, or nil if no player groups
-------------------------------------
function DCSEx.envMission.getPlayerGroupsCenterPoint(coalitionId)
    local pGroups = DCSEx.envMission.getPlayerGroups(coalitionId)
    if #pGroups == 0 then return nil end

    local center = { x = 0, y = 0 }
    for _,g in ipairs(pGroups) do
        center.x = center.x + g.x
        center.y = center.y + g.y
    end

    center.x = center.x / #pGroups
    center.y = center.y / #pGroups

    return center
end

-------------------------------------
-- Sets the text for the briefing description in the briefing panel
-------------------------------------
-- @param side Coalition ID (coalition.side.*) of the coalition
-- @param text Text of the briefing
-- @param picture Resource name of the picture to use for the briefing
-------------------------------------
function DCSEx.envMission.setBriefing(side, text, picture)
    text = text or ""
    text = text:gsub("\n", "\\n")
    picture = picture or ""
    net.dostring_in("mission", string.format("a_set_briefing(\"%s\", getValueResourceByKey(\"%s\"), \"%s\")", DCSEx.dcs.getCoalitionAsString(side):lower(), picture, text))
end
