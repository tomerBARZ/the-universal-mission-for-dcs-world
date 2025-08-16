-- ====================================================================================
-- DCSEX.DCS - FUNCTIONS HANDLING DCS WORLD'S GAME RULES AND TABLES
-- ====================================================================================
-- DCSEx.dcs.doNothing()
-- DCSEx.dcs.getBRAA(point, refPoint, showAltitude, metricSystem, casualFormat)
-- DCSEx.dcs.getCJTFForCoalition(coalitionID)
-- DCSEx.dcs.getCoalitionAsString(coalitionID)
-- DCSEx.dcs.getCoalitionColor(coalitionID, alpha)
-- DCSEx.dcs.getFirstUnitCallsign(group)
-- DCSEx.dcs.getGroupCenterPoint(group)
-- DCSEx.dcs.getGroupIDAsNumber(group)
-- DCSEx.dcs.getNearestObject(refPoint, objectTable)
-- DCSEx.dcs.getNearestObjects(refPoint, objectTable, maxCount)
-- DCSEx.dcs.getNearestPoints(refPoint, pointsTable, maxCount)
-- DCSEx.dcs.getObjectIDAsNumber(obj)
-- DCSEx.dcs.getOppositeCoalition(coalitionID)
-- DCSEx.dcs.getPlayerUnitsInGroup(group)
-- DCSEx.dcs.getPlayerUnitsInGroupByID(groupID)
-- DCSEx.dcs.getRadioModulationName(modulationID)
-- DCSEx.dcs.getUnitCategoryFromFamily(unitFamily)
-- DCSEx.dcs.loadMission(fileName)
-- DCSEx.dcs.outPicture(fileName, durationSeconds, clearView, startDelay, horizontalAlign, verticalAlign, size, sizeUnits)
-- ====================================================================================

DCSEx.dcs = { }

-------------------------------------
-- Does nothing. Used to create commands that do nothing in the F10 menu
-------------------------------------
function DCSEx.dcs.doNothing()
end

-------------------------------------
-- Gets a BRAA (bearing, range, altitude, aspect) string about a point
-- Format is "[bearing to unit] for [distance] at [altitude]"
-------------------------------------
-- @param unit A unit
-- @param refPoint Reference point for the bearing and distance
-- @param showAltitude Should altitude be displayed?
-- @param metricSystem Should metric system units be used?
-- @param casualFormat Should the format be casual ("32nm northeast" instead of "45 for 32")?
-- @return BRAA, as a string
-------------------------------------
function DCSEx.dcs.getBRAA(point, refPoint, showAltitude, metricSystem, casualFormat)
    casualFormat = casualFormat or false
    metricSystem = metricSystem or false
    showAltitude = showAltitude or false

    if not point.z then point = DCSEx.math.vec2ToVec3(point, "land") end
    if not refPoint.z then refPoint = DCSEx.math.vec2ToVec3(refPoint, "land") end

    local braa = nil

    braa = tostring(DCSEx.math.getBearing(point, refPoint, casualFormat))

    local distance = DCSEx.math.getDistance2D(point, refPoint)
    if metricSystem then
        distance = distance / 1000.0
    else
        distance = DCSEx.converter.metersToNM(distance)
    end

    if casualFormat then 
        if metricSystem then
            braa = math.ceil(distance).."km "..braa
        else
            braa = math.ceil(distance).."nm "..braa
        end
    else
        braa = braa .. " for " .. tostring(math.ceil(distance))
    end

    if showAltitude then
        local altitude = point.y
        if metricSystem then
            altitude = math.floor(point.y / 100) * 100
        else
            altitude = math.floor(DCSEx.converter.metersToFeet(point.y) / 1000) * 1000
        end
        braa = braa .. " at " .. tostring(altitude)
        if casualFormat then
            if metricSystem then
                braa = braa.."m"
            else
                braa = braa.."ft"
            end
        end
    end

    return braa
end

-------------------------------------
-- Returns the CJTF country for a given coalition
-------------------------------------
-- @param A coalition ID
-- @return A country ID (country.id.CJTF_BLUE or country.id.CJTF_RED)
-------------------------------------
function DCSEx.dcs.getCJTFForCoalition(coalitionID)
    if coalitionID == coalition.side.RED then return country.id.CJTF_RED end

    return country.id.CJTF_BLUE
end

-------------------------------------
-- Returns the name of a coalition, as a string ("blue", "red" or "neutral")
-------------------------------------
-- @param A coalition ID
-- @return A string
-------------------------------------
function DCSEx.dcs.getCoalitionAsString(coalitionID)
    if coalitionID == coalition.side.NEUTRAL then return "neutral" end
    if coalitionID == coalition.side.RED then return "red" end
    if coalitionID == coalition.side.BLUE then return "blue" end
    return nil
end

-------------------------------------
-- Returns the RGBA color table for the given coalition, accoding to NATO symbology colors
-------------------------------------
-- @param coalitionID A coalition side
-- @param alpha (optional) Alpha. Default is 1.0
-- @return A RGBA color table
-------------------------------------
function DCSEx.dcs.getCoalitionColor(coalitionID, alpha)
    alpha = alpha or 1.0

    if coalitionID == coalition.side.RED then return {0.97, 0.52, 0.51, alpha}
    elseif coalitionID == coalition.side.BLUE then return {0.52, 0.87, 0.99, alpha}
    else
        return {0.5, 0.5, 0.5, alpha}
    end
end

-------------------------------------
-- Returns the callsign table for the first unit of the group
-------------------------------------
-- @param group A group
-- @return A callsign table, or nil if no units or no group
-------------------------------------
function DCSEx.dcs.getFirstUnitCallsign(group)
    if not group then return nil end

    local units = group:getUnits()
    if not units then return nil end

    local unit0 = units[1]
    if not unit0 then return nil end
    return unit0:getCallsign()
end

-------------------------------------
-- Returns a vec3 point at the center of all units of a group
-------------------------------------
-- @param group A group object
-- @return A vec3
-------------------------------------
function DCSEx.dcs.getGroupCenterPoint(group)
    if not group then return nil end
    local units = group:getUnits()
    if not units or #units == 0 then return nil end

    local centerPoint = { x = 0, y = 0, z = 0}
    for _,u in pairs(units) do
        local uPoint = u:getPoint()
        centerPoint.x = centerPoint.x + uPoint.x
        centerPoint.y = centerPoint.y + uPoint.y
        centerPoint.z = centerPoint.z + uPoint.z
    end

    centerPoint.x = centerPoint.x / #units
    centerPoint.y = centerPoint.y / #units
    centerPoint.z = centerPoint.z / #units

    return centerPoint
end

-------------------------------------
-- Returns the ID of a group as a number (here to fix a bug where sometimes ID is returned as a string)
-------------------------------------
-- @param group A group table
-- @return An ID (as an number) or nil if group is nil or has no ID
-------------------------------------
function DCSEx.dcs.getGroupIDAsNumber(group)
    if not group then
        return nil
    end

    return tonumber(group:getID())
end

-------------------------------------
-- Returns the object nearest (in a 2D plane) from a given point
-------------------------------------
-- @param refPoint A reference point, as a vec2 or vec3
-- @param objectTable A table of DCS objects
-- @return The object nearest from the point, or nil if no object was found
-------------------------------------
function DCSEx.dcs.getNearestObject(refPoint, objectTable)
    local nearestObjects = DCSEx.dcs.getNearestObjects(refPoint, objectTable, 1)
    if #nearestObjects == 0 then return nil end
    return nearestObjects[1]
end

-------------------------------------
-- Returns the nearest objects (in a 2D plane) from a given point
-------------------------------------
-- @param refPoint A reference point, as a vec2 or vec3
-- @param objectTable A table of DCS objects
-- @param maxCount (optional) Maximum number of objects to return
-- @return A table of objects, sorted by distance
-------------------------------------
function DCSEx.dcs.getNearestObjects(refPoint, objectTable, maxCount)
    if not refPoint then return DCSEx.table.deepCopy(objectTable) end

    refPoint = DCSEx.math.vec3ToVec2(refPoint)
    local sortedObjects = {}
    local sortedKeys = {}

    for i,o in pairs(objectTable) do
        local distance = DCSEx.math.getDistance2D(refPoint, o:getPoint())
        sortedObjects[distance] = i
        table.insert(sortedKeys, distance)
    end

    table.sort(sortedKeys)

    local sortedList = {}
    for _,v in ipairs(sortedKeys) do
        if maxCount and #sortedList >= maxCount then break end
        table.insert(sortedList, objectTable[sortedObjects[v]])
    end

    return sortedList
end

-------------------------------------
-- Returns the nearest points (in a 2D plane) from a given point
-------------------------------------
-- @param refPoint A reference point, as a vec2 or vec3
-- @param objectTable A table of points (vec2 or vec3)
-- @param maxCount (optional) Maximum number of points to return
-- @return A table of points, sorted by distance
-------------------------------------
function DCSEx.dcs.getNearestPoints(refPoint, pointsTable, maxCount)
    if not refPoint then return DCSEx.table.deepCopy(pointsTable) end

    refPoint = DCSEx.math.vec3ToVec2(refPoint)
    local sortedPoints = {}
    local sortedKeys = {}

    for i,pt in pairs(pointsTable) do
        local distance = DCSEx.math.getDistance2D(refPoint, pt)
        sortedPoints[distance] = i
        table.insert(sortedKeys, distance)
    end

    table.sort(sortedKeys)

    local sortedList = {}
    for _,v in ipairs(sortedKeys) do
        if maxCount and #sortedList >= maxCount then break end
        table.insert(sortedList, pointsTable[sortedPoints[v]])
    end

    return sortedList
end

-------------------------------------
-- Returns the coalition opposed to the provided coalition (coalition.side.NEUTRAL still returns NEUTRAL)
-------------------------------------
-- @param group A coalition
-- @return Another coalition
-------------------------------------
function DCSEx.dcs.getOppositeCoalition(coalitionID)
    if coalitionID == coalition.side.RED then return coalition.side.BLUE end
    if coalitionID == coalition.side.BLUE then return coalition.side.RED end
    return coalition.side.NEUTRAL
end

-------------------------------------
-- Returns all player-controlled units in a group
-------------------------------------
-- @param group A group object
-- @return A table of unit objects
-------------------------------------
function DCSEx.dcs.getPlayerUnitsInGroup(group)
    if not group then return nil end
    local units = group:getUnits()
    if not units then return { } end

    local players = {}
    for _,u in pairs(units) do
        if u:getPlayerName() then
            table.insert(players, u)
        end
    end

    return players
end

-------------------------------------
-- Returns all player-controlled units in the group with the given ID
-------------------------------------
-- @param groupID A group ID
-- @return A table of unit objects
-------------------------------------
function DCSEx.dcs.getPlayerUnitsInGroupByID(groupID)
    return DCSEx.dcs.getPlayerUnitsInGroup(DCSEx.world.getGroupByID(groupID))
end

-------------------------------------
-- Returns a radio modulation type as a string
-------------------------------------
-- @param modulationID A modulation ID (from radio.modulation enum)
-- @return A string
-------------------------------------
function DCSEx.dcs.getRadioModulationName(modulationID)
    if modulationID == radio.modulation.FM then return "FM" end
    return "AM"
end

-------------------------------------
-- Returns the ID of an object as a number (here to fix a bug where sometimes ID is returned as a string)
-------------------------------------
-- @param obj An object (unit, static object...)
-- @return An ID (as an number) or nil if unit is nil or has no ID
-------------------------------------
function DCSEx.dcs.getObjectIDAsNumber(obj)
    if not obj then return nil end
    return tonumber(obj:getID())
end

-------------------------------------
-- Returns a the unit category (Unit.Category enum) an unit family (DCSEx.enums.unitFamily) belongs to
-------------------------------------
-- @param unitFamily A value from the Unit.Category enum
-- @return A value from the DCSEx.enums.unitFamily enum
-------------------------------------
function DCSEx.dcs.getUnitCategoryFromFamily(unitFamily)
    return math.floor(unitFamily / 100)
end

-------------------------------------
-- Loads another DCS World mission
-------------------------------------
-- @param fileName Filename of the mission
-------------------------------------
function DCSEx.dcs.loadMission(fileName)
    net.dostring_in("mission", string.format("a_load_mission(\"%s\")", fileName))
end

-------------------------------------
-- Displays a picture on the screen of ALL players
-------------------------------------
-- @param fileName Filename/ResourceName of the image in the mission resources
-- @param durationSeconds Duration (in seconds) during which the image should be displayed
-- @param startDelay After how many seconds should the image be displayed? (default: 0)
-- @param horizontalAlign Horizontal alignment of the image (0/1/2=left/center/right) (default: 1)
-- @param verticalAlign Vertical alignment of the image (0/1/2=top/center/bottom) (default: 1)
-- @param size Size of the image, in pixels or % of the screen (see sizeUnits) (default: 100)
-- @param sizeUnits If 0, the size parameter is in pixels. If 1, it's in % of screen size (default: 0)
-------------------------------------
function DCSEx.dcs.outPicture(fileName, durationSeconds, clearView, startDelay, horizontalAlign, verticalAlign, size, sizeUnits)
    clearView = clearView or false
    startDelay = startDelay or 0
    horizontalAlign = horizontalAlign or 1
    verticalAlign = verticalAlign or 1
    size = size or 100
    sizeUnits = sizeUnits or 0

    if clearView then clearView = "true" else clearView = "false" end

    net.dostring_in("mission", string.format("a_out_picture(getValueResourceByKey(\"%s\"), %d, %s, %d, \"%d\", \"%d\", %d, \"%d\")", fileName, durationSeconds, clearView, startDelay, horizontalAlign, verticalAlign, size, sizeUnits))
end
