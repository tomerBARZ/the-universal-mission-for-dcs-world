TUM.atc = {}

do
    function TUM.atc.requestNavAssistanceToObjective(index, delayRadioAnswer)
        local obj = TUM.objectives.getObjective(index)
        if not obj then return end

        local msgIDSuffix = ""
        if obj.preciseCoordinates then msgIDSuffix = "Precise" end

        local players = coalition.getPlayers(TUM.settings.getPlayerCoalition())
        for _,p in ipairs(players) do
            -- Give BRA to objective
            local navInfo = "- Fly "..DCSEx.dcs.getBRAA(obj.waypoint3, p:getPoint(), false).."\n"

            -- Give flight time and ETA
            local velocity = p:getVelocity()
            local speed = math.max(1, math.sqrt(velocity.x * velocity.x + velocity.y * velocity.y + velocity.z * velocity.z))
            local distance = DCSEx.math.getDistance2D(obj.waypoint2, DCSEx.math.vec3ToVec2(p:getPoint()))
            local timeInMinutes = math.max(1, math.floor(distance / (speed * 60)))
            local eta = DCSEx.string.getTimeString(timer.getAbsTime() + timeInMinutes * 60)
            if timeInMinutes > 600 then
                navInfo = navInfo.."- More than ten hours of flight time at current airspeed\n"
            elseif timeInMinutes > 120 then
                navInfo = navInfo.."- "..tostring(math.floor(timeInMinutes / 60)).." hours of flight time at current airspeed, ETA "..eta.."\n"
            else
                navInfo = navInfo.."- "..tostring(timeInMinutes).." minute(s) of flight time at current airspeed, ETA "..eta.."\n"
            end

            -- Give objective coordinates
            if obj.preciseCoordinates then
                navInfo = navInfo.."\nExact coordinates for objective are:\n"
            else
                navInfo = navInfo.."\nNo exact coordinates for objective. Approximate coordinates are:\n"
            end
            navInfo = navInfo..DCSEx.world.getCoordinatesAsString(obj.waypoint3, false)

            TUM.radio.playForUnit(DCSEx.dcs.getObjectIDAsNumber(p), "commandObjectiveCoordinates"..msgIDSuffix, { obj.name, navInfo }, "Command", delayRadioAnswer)
        end
    end
end
