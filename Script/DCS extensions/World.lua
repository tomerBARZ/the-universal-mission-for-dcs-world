-- ====================================================================================
-- WORLDTOOLS - FUNCTIONS RELATED TO THE GAME WORLD
-- ====================================================================================
-- DCSEx.world.collidesWithScenery(vec2, radius)
-- DCSEx.world.findSpawnPoint(vec2, minRadius, maxRadius, surfaceType, radiusWithoutScenery)
-- DCSEx.world.getAllPlayers()
-- DCSEx.world.getAllSceneryBuildings(minHealth)
-- DCSEx.world.getAllUnits(unitCategory)
-- DCSEx.world.getClosestPointOnRoadsVec2(vec2)
-- DCSEx.world.getCoordinatesAsString(point)
-- DCSEx.world.getCurrentMarkerID()
-- DCSEx.world.getGroupByID(groupID)
-- DCSEx.world.getNextMarkerID()
-- DCSEx.world.getSceneriesInZone(center, radius, minHealth)
-- DCSEx.world.getStaticObjectByID(staticID)
-- DCSEx.world.getTerrainHeightDiff(coord, searchRadius)
-- DCSEx.world.getUnitByID(unitID)
-- DCSEx.world.isGroupAlive(g, unitsMustBeInAir)
-- DCSEx.world.setUnitLifePercent(unitID, life)
-- ====================================================================================

DCSEx.world = { }

do
    -- TODO: get max marker already in use from envMission
    local nextMarkerId = 1 -- Next map marker ID

    function DCSEx.world.collidesWithScenery(vec2, radius)
        local foundOne = false
        radius = radius or 8

        local volS = {
            id = world.VolumeType.SPHERE,
            params = {
            point = DCSEx.math.vec2ToVec3(vec2, "land"),
            radius = radius
            }
        }

        local ifFound = function(foundItem, val)
            foundOne = true
            return true
        end

        world.searchObjects(Object.Category.SCENERY, volS, ifFound)

        return foundOne
    end

    -- function DCSEx.world.findSpawnPoint(vec2, minRadius, maxRadius, surfaceType, radiusWithoutScenery, territorySide, expandSearch)
    --     expandSearch = expandSearch or true

    --     for _=0,16 do
    --         for _=0,16 do
    --             local spawnPoint = nil

    --             spawnPoint = DCSEx.math.randomPointInCircle(
    --                 vec2,
    --                 DCSEx.converter.nmToMeters(maxRadius),
    --                 DCSEx.converter.nmToMeters(minRadius),
    --                 surfaceType)

    --             if spawnPoint and radiusWithoutScenery then
    --                 if DCSEx.world.collidesWithScenery(spawnPoint, radiusWithoutScenery) then
    --                     spawnPoint = nil
    --                 end
    --             end

    --             if spawnPoint and territorySide then
    --                 if scramble.territories.getOwner(spawnPoint) ~= territorySide then
    --                     spawnPoint = nil
    --                 end
    --             end

    --             if spawnPoint then return spawnPoint end
    --         end

    --         if not expandSearch then return nil end

    --         minRadius = minRadius * 0.9
    --         maxRadius = maxRadius * 1.2
    --     end

    --     return nil
    -- end

    
    -------------------------------------
    -- Returns a table of all player-controlled units currently in the game
    -- @return A table of unit objects
    -------------------------------------
    function DCSEx.world.getAllPlayers()
        local players = {}

        for coalitionID=0,2 do
            local coalPlayers = coalition.getPlayers(coalitionID)
            for _,p in pairs(coalPlayers) do
                table.insert(players, p)
            end
        end

        return players
    end

    -------------------------------------
    -- Returns a table of all map scenery buildings.
    -- This function is rather CPU-consuming, better run it once on mission start and store the result in table.
    -- @param minHealth Minimum health a building must have to be included in the table
    -- @return A table of scenery objects
    -------------------------------------
    function DCSEx.world.getAllSceneryBuildings(minHealth)
        minHealth = minHealth or 0
        local sceneries = {}

        local scenerySearchvolume = {
            id = world.VolumeType.SPHERE,
            params = { point = { x = env.mission.map.centerX, y = 0, z = env.mission.map.centerY }, radius = 10000000 }
        }

        local function ifSceneryFound(foundScenery, val)
            local desc = foundScenery:getDesc()
            if desc and desc.attributes and desc.attributes.Buildings then
                if desc.life >= minHealth then
                    table.insert(sceneries, foundScenery)
                end
            end
            return true
        end

        world.searchObjects(Object.Category.SCENERY, scenerySearchvolume, ifSceneryFound)

        return sceneries
    end

    -------------------------------------
    -- Returns all units belonging to a given category
    -- @param coalitionID Coalition ID (coalition.side.XXX) or nil to search all coalitions
    -- @param unitCategory An unit category (Group.Category.XXX)
    -- @return A table of unit tables
    -------------------------------------
    function DCSEx.world.getAllUnits(coalitionID, unitCategory)
        local units = {}

        local searchedCoalitions = { 0, 1, 2 }
        if coalitionID then searchedCoalitions = { coalitionID } end

        for _,c in pairs(searchedCoalitions) do -- Enumerate coalitions
            for _, g in pairs(coalition.getGroups(c, unitCategory)) do
                for __, u in pairs(g:getUnits()) do
                    table.insert(units, u)
                end
            end
        end

        return units
    end

    -------------------------------------
    -- Returns the closest point to roads as a vec2
    -- @param vec2 Coordinates to look for
    -- @return A vec2 with the closest point on roads
    -------------------------------------
    function DCSEx.world.getClosestPointOnRoadsVec2(vec2)
        local roadX, roadY = land.getClosestPointOnRoads("roads", vec2.x, vec2.y)
        return {x = roadX, y = roadY}
    end

    -------------------------------------
    -- Returns the LL/MGRS coordinates of a point, as a string
    -- Based on code by Bushmanni - https://forums.eagle.ru/showthread.php?t=99480
    -- @param point The point, as a vec2 or vec3
    -- @param hideElevation (optional) Show elevation NOT be displayed? Default: false
    -- @return A string
    -------------------------------------
    function DCSEx.world.getCoordinatesAsString(point, hideElevation)
        hideElevation = hideElevation or false

        if not point.z then point = DCSEx.math.vec2ToVec3(point, "land") end
        local cooString = ""

        local LLposN, LLposE, alt = coord.LOtoLL(point)
        local LLposfixN, LLposdegN = math.modf(LLposN)
        LLposdegN = LLposdegN * 60
        local LLposdegN2, LLposdegN3 = math.modf(LLposdegN)
        local LLposdegN3Decimal = LLposdegN3 * 1000
        LLposdegN3 = LLposdegN3 * 60

        local LLposfixE, LLposdegE = math.modf(LLposE)
        LLposdegE = LLposdegE * 60
        local LLposdegE2, LLposdegE3 = math.modf(LLposdegE)
        local LLposdegE3Decimal = LLposdegE3 * 1000
        LLposdegE3 = LLposdegE3 * 60

        local LLns = "N"
        if LLposfixN < 0 then
            LLns = "S"
        end
        local LLew = "E"
        if LLposfixE < 0 then
            LLew = "W"
        end

        local LLposNstring = LLns .. " " .. string.format("%.2i°%.2i'%.2i''", LLposfixN, LLposdegN2, LLposdegN3)
        local LLposEstring = LLew .. " " .. string.format("%.3i°%.2i'%.2i''", LLposfixE, LLposdegE2, LLposdegE3)
        cooString = "L/L: " .. LLposNstring .. " " .. LLposEstring

        local LLposNstring = LLns .. " " .. string.format("%.2i°%.2i.%.3i", LLposfixN, LLposdegN2, LLposdegN3Decimal)
        local LLposEstring = LLew .. " " .. string.format("%.3i°%.2i.%.3i", LLposfixE, LLposdegE2, LLposdegE3Decimal)
        cooString = cooString .. "\nL/L: " .. LLposNstring .. " " .. LLposEstring

        local mgrs = coord.LLtoMGRS(LLposN, LLposE)
        local mgrsString =
            mgrs.MGRSDigraph .. " " .. mgrs.UTMZone .. " " .. tostring(mgrs.Easting) .. " " .. tostring(mgrs.Northing)
        cooString = cooString .. "\nMGRS: " .. mgrsString

        if not hideElevation then
            cooString = cooString .. "\nELEVATION: " .. math.floor(alt * 3.281) .. "ft / " .. math.floor(alt) .. " meters"
        end

        return cooString
    end

    -------------------------------------
    -- Returns the last map marker ID generated by DCSEx.world.getNextMarkerID(), if any
    -- @return A numeric ID, or nil
    -------------------------------------
    function DCSEx.world.getCurrentMarkerID()
        if nextMarkerId == 1 then return nil end
        return nextMarkerId - 1
    end

    -------------------------------------
    -- Searches and return a group by its ID
    -- @param groupID ID of the group
    -- @return A group table, or nil if no group with this ID was found
    -------------------------------------
    function DCSEx.world.getGroupByID(groupID)
        for coalitionID = 1, 2 do
            for _, grp in pairs(coalition.getGroups(coalitionID)) do
                if DCSEx.dcs.getGroupIDAsNumber(grp) == groupID then
                    return grp
                end
            end
        end

        return nil
    end

    -- TODO: description
    function DCSEx.world.getMarkerByText(text, coalition)
        if not text then return nil end
        text = text:lower()
        local markers = world.getMarkPanels()

        for _,m in ipairs(markers) do
            local markerText = m.text or ""
            markerText = markerText:lower()
            if markerText == text then
                if coalition == nil or m.coalition == coalition then
                    return m
                end
            end
        end

        return nil
    end

    -------------------------------------
    -- Returns a new, unique, map marker ID
    -- @return A numeric ID
    -------------------------------------
    function DCSEx.world.getNextMarkerID()
        nextMarkerId = nextMarkerId + 1
        return nextMarkerId - 1
    end

    -- TODO: description, file header
    function DCSEx.world.getPlayersInAir(side)
        local players = {}
        if side then
            players = coalition.getPlayers(side)
        else
            players = DCSEx.world.getAllPlayers()
        end

        local playersInAir = {}
        for _,p in ipairs(players) do
            if p:inAir() then
                table.insert(playersInAir, p)
            end
        end

        return playersInAir
    end

    -- TODO: description, file header
    function DCSEx.world.getSpawnPoint(zone, surfaceType, safeRadius)
        safeRadius = safeRadius or 100

        -- Only two surface types are really useful to us: land and water
        if surfaceType == land.SurfaceType.SHALLOW_WATER then
            surfaceType = land.SurfaceType.WATER
        elseif surfaceType == land.SurfaceType.ROAD or surfaceType == land.SurfaceType.RUNWAY then
            surfaceType = land.SurfaceType.LAND
        end

        local loopsLeft = 512

        while loopsLeft > 0 do
            local basePoint = DCSEx.zones.getRandomPointInside(zone)

            if not surfaceType then -- Nil surfaceType means: any point is fine
                return basePoint
            end

            if surfaceType == land.SurfaceType.WATER then
                if basePoint and land.getSurfaceType(basePoint) == land.SurfaceType.WATER then
                    return basePoint
                end
            else
                if safeRadius <= 0 then
                    return basePoint
                end

                basePoint = DCSEx.math.vec2ToVec3(basePoint, "land")

                local spawnPoints = Disposition.getSimpleZones(basePoint, math.max(1852, safeRadius * 5), safeRadius, 1)
                if #spawnPoints > 0 and land.getSurfaceType(spawnPoints[1]) == land.SurfaceType.LAND then
                    return spawnPoints[1]
                end
            end

            loopsLeft = loopsLeft - 1
        end

        return nil
    end

    -- TODO: description
    function DCSEx.world.getSceneriesInZone(center, radius, minHealth)
        minHealth = minHealth or 0
        local sceneries = {}

        local scenerySearchvolume = {
            id = world.VolumeType.SPHERE,
            params = { point = DCSEx.math.vec2ToVec3(center, "land"), radius = radius }
        }

        local function ifSceneryFound(foundScenery, val)
            local desc = foundScenery:getDesc()
            if desc and desc.attributes and desc.attributes.Buildings then
                if desc.life >= minHealth then
                    table.insert(sceneries, foundScenery)
                end
            end
            return true
        end

        world.searchObjects(Object.Category.SCENERY, scenerySearchvolume, ifSceneryFound)

        return sceneries
    end

    -------------------------------------
    -- Searches and return a static object by its ID
    -- @param staticID ID of the static object
    -- @return An unit, or nil if no static object with this ID was found
    -------------------------------------
    function DCSEx.world.getStaticObjectByID(staticID)
        for coalitionID = 1, 2 do
            for _, s in pairs(coalition.getStaticObjects(coalitionID)) do
                if DCSEx.dcs.getObjectIDAsNumber(s) == staticID then
                    return s
                end
            end
        end

        return nil
    end

    -- TODO: description, update file header
    function DCSEx.world.getTerrainHeightDiff(coord, searchRadius)
		local samples = {}
        searchRadius = searchRadius or 5

		samples[#samples + 1] = land.getHeight(coord)
		for i = 0, 360, 30 do
			samples[#samples + 1] = land.getHeight({x = (coord.x + (math.sin(math.rad(i))*searchRadius)), y = (coord.y + (math.cos(math.rad(i))*searchRadius))})
			if searchRadius >= 20 then -- if search radius is sorta large, take a sample halfway between center and outer edge
				samples[#samples + 1] = land.getHeight({x = (coord.x + (math.sin(math.rad(i))*(searchRadius/2))), y = (coord.y + (math.cos(math.rad(i))*(searchRadius/2)))})
			end
		end
		local tMax, tMin = 0, 1000000
		for _, height in pairs(samples) do
			if height > tMax then
				tMax = height
			end
			if height < tMin then
				tMin = height
			end
		end

        return tMax - tMin
	end

    -- TODO: description, update file header
    function DCSEx.world.getGroupCenter(group)
        return DCSEx.world.getUnitsCenter(group:getUnits())
    end

    -- TODO: description, update file header
    function DCSEx.world.getUnitsCenter(units)
        if not units or #units == 0 then return { x = 0, y = 0 } end

        local center = { x = 0, y = 0 }
        for _,u in pairs(units) do
            local uPt2 = DCSEx.math.vec3ToVec2(u:getPoint())
            center.x = center.x + uPt2.x
            center.y = center.y + uPt2.y
        end

        center.x = center.x / #units
        center.y = center.y / #units

        return center
    end

    -------------------------------------
    -- Searches and return an unit by its ID
    -- @param unitID ID of the unit
    -- @return An unit, or nil if no unit with this ID was found
    -------------------------------------
    function DCSEx.world.getUnitByID(unitID)
        for coalitionID = 1, 2 do
            for _, g in pairs(coalition.getGroups(coalitionID)) do
                local units = g:getUnits()
                for _, u in pairs(units) do
                    if DCSEx.dcs.getObjectIDAsNumber(u) == unitID then
                        return u
                    end
                end
            end
        end

        return nil
    end

    -------------------------------------
    -- Searches and return a coalition static object by its ID
    -- @param unitID ID of the static object
    -- @return An static object, or nil if no unit with this ID was found
    -------------------------------------
    function DCSEx.world.getStaticObjectByID(staticID)
        for coalitionID = 1,2 do
            for _,s in pairs(coalition.getStaticObjects(coalitionID)) do
                if DCSEx.dcs.getObjectIDAsNumber(s) == staticID then
                    return s
                end
            end
        end

        return nil
    end

    -- TODO: description
    function DCSEx.world.isGroupAlive(g, unitsMustBeInAir)
        if not g then return false end
        if not g:isExist() then return false end
        if g:getSize() == 0 then return false end

        unitsMustBeInAir = unitsMustBeInAir or false

        local atLeastOneActiveUnit = false
        local units = g:getUnits()
        if not units or #units == 0 then return false end
        for _,u in pairs(units) do
            if u:isExist() and u:getLife() > 0 then
                if u:inAir() or not unitsMustBeInAir then
                    atLeastOneActiveUnit = true
                end
            end
        end

        return atLeastOneActiveUnit
    end

    -- TODO: description & file header
    function DCSEx.world.setUnitLifePercent(unitID, life)
        net.dostring_in("mission", string.format("a_unit_set_life_percentage(%d, %f)", unitID, life))
    end

    -- TODO: description & file header
    function DCSEx.world.explodeUnit(unitID, amount)
        net.dostring_in("mission", string.format("a_explosion_unit(%d, %f)", unitID, amount))
    end

    function DCSEx.world.destroyGroupByID(groupID)
        if not groupID then return end
        local g = DCSEx.world.getGroupByID(groupID)
        if g then g:destroy() end
    end

    -- function DCSEx.world.destroySceneryInZone(zone, destructionPercent)
    --     destructionPercent = destructionPercent or 0
    --     net.dostring_in("mission", string.format("a_scenery_destruction_zone(%d, %f)", zone.zoneId, destructionPercent))
    -- end

    -- function DCSEx.world.highlightUnit(unitID, enabled)
    --     if enabled then
    --         enabled = "true"
    --     else
    --         enabled = "false"
    --     end

    --     net.dostring_in("mission", string.format("a_unit_highlight(%d, %s)", unitID, enabled))
    -- end

    -- function DCSEx.world.shellingZone(zone, tnt, shellsCount)
    --     net.dostring_in("mission", string.format("a_shelling_zone(%d, %f, %d)", zone.zoneId, tnt, shellsCount))
    -- end
end
