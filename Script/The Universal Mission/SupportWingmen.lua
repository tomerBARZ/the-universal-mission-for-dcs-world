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

        local player = world:getPlayer()
        if not player then return end

        local count = 1 -- TODO

        local groupInfo = DCSEx.unitGroupMaker.create(
            TUM.settings.getPlayerCoalition(),
            Group.Category.AIRPLANE, -- TODO: or helicopter!
            DCSEx.math.randomPointInCircle(DCSEx.math.vec3ToVec2(player:getPoint()), 500, 250),
            { player:getTypeName() },
            {
                silenced = true,
                taskFollow = DCSEx.dcs.getObjectIDAsNumber(player:getGroup()),
                unlimitedFuel = true
            }
        )

        if not groupInfo then
            TUM.log("Failed to spawn AI wingmen", TUM.logLevel.WARNING)
            return
        end

        TUM.log("Spawned AI wingmen")
        wingmenGroupID = groupInfo.groupID
    end

    function TUM.supportWingmen.removeAll()
        if wingmenGroupID then TUM.log("Removing all wingmen...") end

        DCSEx.world.destroyGroupByID(wingmenGroupID)

        wingmenGroupID = nil
    end
end
