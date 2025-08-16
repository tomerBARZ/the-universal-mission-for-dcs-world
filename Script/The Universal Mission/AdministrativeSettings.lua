-- ====================================================================================
--  TUM.ADMINISTRATIVESETTINGS - HANDLE ADMINISTRATIVE SETTINGS
-- ====================================================================================
-- (enum) TUM.administrativeSettings
-- TUM.administrativeSettingsDefaultValues
-- TUM.administrativeSettingsValues
-- TUM.administrativeSettings.getValue(key)
-- TUM.administrativeSettings.onStartUp()
-- TUM.administrativeSettings.setValue(key, value)
-- ====================================================================================

TUM.administrativeSettings = {
    -- This table defines the administrative settings for the script.
    -- These settings can modify the behavior of the script, and can be set by the mission maker via a specific trigger zone's parameters, or via script (defining the TUM.administrativeSettingsValues below)
    USE_SPECIFIC_RADIOMENU = 1,     -- Use a specific radio menu for the mission commands, or use the main one?
    INITIALIZE_AUTOMATICALLY = 2,   -- Automatically initialize the mission when the script is loaded. If false, you must call TUM.initialize() manually.
    IGNORE_ZONES_STARTINGWITH = 3,  -- If set, ignore all zones starting with this string. This is useful to avoid conflicts with other scripts that use the same zone names.
    ONLY_ZONES_STARTINGWITH = 4,    -- If set, only adds zones starting with this string. This is useful to avoid conflicts with other scripts that use the same zone names.
}

TUM.administrativeSettingsDefaultValues = {
    -- This table defines the default values for the administrative settings.
    -- The keys must match the keys in TUM.administrativeSettings
    [TUM.administrativeSettings.USE_SPECIFIC_RADIOMENU] = false,    -- Use a specific radio menu for the mission commands, or use the main one?
    [TUM.administrativeSettings.INITIALIZE_AUTOMATICALLY] = true,   -- Automatically initialize the mission when the script is loaded. If false, you must call TUM.initialize() manually.
    [TUM.administrativeSettings.IGNORE_ZONES_STARTINGWITH] = nil,   -- If set, ignore all zones starting with this string. This is useful to avoid conflicts with other scripts that use the same zone names.
    [TUM.administrativeSettings.ONLY_ZONES_STARTINGWITH] = nil,     -- If set, only adds zones starting with this string. This is useful to avoid conflicts with other scripts that use the same zone names.
}

TUM.administrativeSettingsValues = {
    -- This table defines the administrative settings values for the script.
    -- The keys must match the keys in TUM.administrativeSettings
    -- If set, these values will prevail over both the default values in TUM.administrativeSettings and the values set by the mission maker via a specific trigger zone's parameters.
}

--- Returns the value of the administrative setting with the given key
function TUM.administrativeSettings.getValue(key)
    if TUM.administrativeSettingsValues[key] ~= nil then
        return TUM.administrativeSettingsValues[key]
    else
        return TUM.administrativeSettingsDefaultValues[key]
    end
end

--- Takes all the values from (in order of priority):
---     1. The TUM.administrativeSettingsValues table (optionnaly set by script)
---     2. The trigger zone parameters (set by the mission maker)
---     3. The TUM.administrativeSettingsDefaultValues table (default values)
function TUM.administrativeSettings.onStartUp()
    local ADMIN_ZONE_NAME = "TUM_Administrative_Settings"  -- The name of the administrative settings trigger zone
    local adminZone = DCSEx.zones.getByName(ADMIN_ZONE_NAME)

    for key, _ in pairs(TUM.administrativeSettings) do
        local value = nil
        if TUM.administrativeSettingsValues[TUM.administrativeSettings[key]] then -- Check if the value is set by script
            value = TUM.administrativeSettingsValues[TUM.administrativeSettings[key]]
        end
        if value == nil and adminZone then -- If the value is not set by script, check the trigger zone parameters
            local zoneValue = DCSEx.zones.getProperty(adminZone, key)
            if zoneValue ~= nil then
                value = zoneValue
            end
        end
        if value == nil then -- If the value is not set by script or trigger zone, use the default value
            value = TUM.administrativeSettingsDefaultValues[TUM.administrativeSettings[key]]
        end
        TUM.administrativeSettingsValues[TUM.administrativeSettings[key]] = value
    end
end

--- Sets the value of the administrative setting with the given key
function TUM.administrativeSettings.setValue(key, value)
    -- check if the key is in the administrative settings table
    local foundKey = false
    for _, v in pairs(TUM.administrativeSettings) do
        if v == key then
            foundKey = true
            break
        end
    end
    if not foundKey then
        TUM.log("Tried to set an unknown administrative setting: "..tostring(key), TUM.logger.logLevel.ERROR)
        return nil
    end

    TUM.administrativeSettingsValues[key] = value
end
