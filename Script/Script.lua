env.setErrorMessageBoxEnabled(true) -- Enable messageboxes for Lua errors

DCSEx = {}
Library = {}
TUM = {}

TUM.VERSION_NUMBER = 1
TUM.VERSION_STRING = "0.1.250722"

TUM.DEBUG_MODE = __DEBUG_MODE__

TUM.logLevel = {
    INFO = 0,
    WARNING = 1,
    ERROR = 2
}

-------------------------------------
-- Prints and logs a debug message
-- @param message The message
-- @param logLevel Is it a warning, error or info messages (as defined in TUM.logLevel). Info messages are not printed out unless debug mode is enabled.
-------------------------------------
function TUM.log(message, logLevel)
    logLevel = logLevel or TUM.logLevel.INFO

    if logLevel == TUM.logLevel.ERROR then
        trigger.action.outText("ERROR: "..message, 3600)
        env.warning("TUM - ERROR: "..message, false)
    elseif logLevel == TUM.logLevel.WARNING then
        trigger.action.outText("WARNING: "..message, 10)
        env.warning("TUM - WARNING: "..message, false)
    else
        if TUM.DEBUG_MODE then -- Info messages are only printed out if debug mode is enabled
            trigger.action.outText(message, 3)
        end

        env.info("TUM: "..message, false)
    end
end

--[[DCS EXTENSIONS]]--

--[[LIBRARY]]--

--[[THE UNIVERSAL MISSION]]--

--------------------
-- Module startup --
--------------------

do
    local function startUpMission()
        TUM.hasStarted = false

        local coreSettings = {
            multiplayer = false
        }

        if #DCSEx.envMission.getPlayerGroups() == 0 then
            TUM.log("No \"Player\" or \"Client\" aircraft slots have been found. Please fix this problem in the mission editor.", TUM.logLevel.ERROR)
            return nil
        end

        if world:getPlayer() then
            coreSettings.multiplayer = false

            if #DCSEx.envMission.getPlayerGroups() > 1 then
                TUM.log("Multiple players slots have been found in addition to the single-player \"Player\" aircraft. Please fix this problem in the mission editor.", TUM.logLevel.ERROR)
                return nil
            end
        else
            coreSettings.multiplayer = true

            if #DCSEx.envMission.getPlayerGroups(coalition.side.BLUE) == 0 and #DCSEx.envMission.getPlayerGroups(coalition.side.RED) == 0 then
                TUM.log("Neither BLUE nor RED coalitions have player slots. Please make sure one coalition has player slots in the mission editor.", TUM.logLevel.ERROR)
                return nil
            end

            if #DCSEx.envMission.getPlayerGroups(coalition.side.BLUE) > 0 and #DCSEx.envMission.getPlayerGroups(coalition.side.RED) > 0 then
                TUM.log("Both coalitions have player slots. The Universal Mission is a purely singleplayer/PvE experience and does not support PvP. Please make sure only one coalition has player slots in the mission editor.", TUM.logLevel.ERROR)
                return nil
            end
        end

        if not TUM.territories.onStartUp() then return nil end
        if not TUM.settings.onStartUp(coreSettings) then return nil end -- Must be called after TUM.territories.onStartUp()
        if not TUM.playerCareer.onStartUp() then return nil end
        if not TUM.intermission.onStartUp() then return nil end
        if not TUM.airForce.onStartUp() then return nil end
        if not TUM.mizCleaner.onStartUp() then return nil end -- Must be called after TUM.settings.onStartUp()

        TUM.hasStarted = true

        return coreSettings
    end

    if not startUpMission() then
        trigger.action.outText("A critical error has happened, cannot start the mission.", 3600)
    end
end

-------------------
-- Event handler --
-------------------
do
    local eventHandler = {}

    function eventHandler:onEvent(event)
        if not event then return end -- No event

        TUM.ambientRadio.onEvent(event) -- Must be first so other (more important) radio messages will interrupt the "ambient" ones
        TUM.ambientWorld.onEvent(event)
        TUM.objectives.onEvent(event)
        TUM.playerScore.onEvent(event)
        TUM.mission.onEvent(event)
        TUM.wingmen.onEvent(event)
        TUM.mizCleaner.onEvent(event) -- Must be last, can remove units which could cause bugs in other onEvent methods
    end

    function TUM.onEvent(event)
        eventHandler:onEvent(event)
    end

    if TUM.hasStarted then
        world.addEventHandler(eventHandler)
    end
end

--------------------------------------------
-- Game clock, called every 10-20 seconds --
--------------------------------------------
do
    local clockTick = -1

    function TUM.onClockTick(arg, time)
        local nextTickTime = time + math.random(10, 20)
        clockTick = clockTick + 1

        if clockTick % 4 == 0 then
            if TUM.playerScore.onClockTick() then return nextTickTime end
            if TUM.mission.onClockTick() then return nextTickTime end
        elseif clockTick % 4 == 1 then
            if TUM.airForce.onClockTick(TUM.settings.getPlayerCoalition()) then return nextTickTime end
            if TUM.wingmen.onClockTick() then return nextTickTime end
        elseif clockTick % 4 == 2 then
            if TUM.supportAWACS.onClockTick() then return nextTickTime end
        else
            if TUM.airForce.onClockTick(TUM.settings.getEnemyCoalition()) then return nextTickTime end
            if TUM.wingmen.onClockTick() then return nextTickTime end
        end

        return nextTickTime
    end

    if TUM.hasStarted then
        timer.scheduleFunction(TUM.onClockTick, nil, timer.getTime() + math.random(10, 15))
    end
end
