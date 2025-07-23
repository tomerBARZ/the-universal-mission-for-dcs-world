-- ====================================================================================
-- TUM.SUPPORTWINGMEN - HANDLES THE PLAYER'S WINGMEN
-- ====================================================================================
-- ====================================================================================

TUM.supportWingmen = {}

do
    local wingmenGroupID = nil

    function TUM.supportWingmen.create()
        if TUM.settings.getValue(TUM.settings.id.MULTIPLAYER) then return end -- No wingmen in multiplayer
        TUM.supportWingmen.removeAll() -- Destroy all pre-existing wingmen
        TUM.log("Creating wingmen...")
    end

    function TUM.supportWingmen.removeAll()
        if wingmenGroupID then TUM.log("Removing all wingmen...") end

        DCSEx.world.destroyGroupByID(wingmenGroupID)

        wingmenGroupID = nil
    end
end
