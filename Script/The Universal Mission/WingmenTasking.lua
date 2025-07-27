-- ====================================================================================
-- TUM.WINGMENTASKING - HANDLES THE WINGMEN'S TASKING
-- ====================================================================================
-- ====================================================================================

TUM.wingmenTasking = {}

do
    TUM.wingmenTasking.DEFAULT_MARKER_TEXT = "flight"

    local MAX_STRUCTURE_ENGAGEMENT_RANGE = DCSEx.converter.nmToMeters(25)

    local mapMarkerMissingWarningAlreadyDisplayed = false -- Was the "map marker missing" warning already displayed during the mission?
    local targetPointMapMarker = nil

    local currentTargetIDorPoint = nil -- ID for groups/statics, point2 for scenery objects
    local currentTargetType = nil

    local function allowWeaponUse(wingmenCtrl, allowAA, allowAG)
        allowAA = allowAA or false
        allowAG = allowAG or false
        wingmenCtrl:setOption(AI.Option.Air.id.REACTION_ON_THREAT, AI.Option.Air.val.REACTION_ON_THREAT.EVADE_FIRE)
        wingmenCtrl:setOption(AI.Option.Air.id.PROHIBIT_AA, not allowAA)
        wingmenCtrl:setOption(AI.Option.Air.id.PROHIBIT_AG, not allowAG)
    end

    local function doCommandEngageStrikeTargets()
        -- Not a strike mission, so no strike targets
        if TUM.settings.getValue(TUM.settings.id.TASKING) ~= DCSEx.enums.taskFamily.STRIKE then return nil end

        local wingmenCtrl = TUM.wingmen.getController()
        if not wingmenCtrl then return nil end

        local wingmenPosition = DCSEx.world.getGroupCenter(TUM.wingmen.getGroup())

        -- Look for nearest strike target
        local nearestDistance = 9999999999
        local nearestTarget = nil
        local nearestTargetType = nil

        for i=1,TUM.objectives.getCount() do
            local obj = TUM.objectives.getObjective(i)
            if obj and not obj.completed then
                local objectiveDB = Library.tasks[obj.taskID]
                if objectiveDB.targetFamilies and #objectiveDB.targetFamilies > 0 then
                    local distanceFromTarget = DCSEx.math.getDistance2D(wingmenPosition, obj.point2)

                    if distanceFromTarget < nearestDistance and distanceFromTarget < MAX_STRUCTURE_ENGAGEMENT_RANGE then
                        if objectiveDB.targetFamilies[1] == DCSEx.enums.unitFamily.STATIC_SCENERY then
                            nearestDistance = distanceFromTarget
                            nearestTargetType = "scenery"
                            nearestTarget = obj.point2
                        elseif obj.unitsID and #obj.unitsID >= 1 then
                            nearestDistance = distanceFromTarget
                            nearestTargetType = "static"
                            nearestTarget = obj.unitsID[1]
                        end
                    end
                end
            end
        end

        if not nearestTarget or not nearestTargetType then return nil end

        if nearestTargetType == "static" then
            currentTargetType = nearestTargetType
            currentTargetIDorPoint = nearestTarget
            local taskTable = {
                id = "AttackUnit",
                params = {
                    groupAttack = true,
                    unitId = nearestTarget,
                }
            }
            allowWeaponUse(wingmenCtrl, false, true)
            wingmenCtrl:setTask(taskTable)
            return DCSEx.world.getStaticObjectByID(nearestTarget):getPoint()
        elseif nearestTargetType == "scenery" then
            currentTargetType = nearestTargetType
            currentTargetIDorPoint = nearestTarget
            local taskTable = {
                id = "AttackMapObject",
                params = {
                    groupAttack = true,
                    point = nearestTarget,
                }
            }
            allowWeaponUse(wingmenCtrl, false, true)
            wingmenCtrl:setTask(taskTable)
            return DCSEx.math.vec2ToVec3(nearestTarget, "land")
        end

        return nil
    end

    local function getOrbitAltitude()
        local player = world.getPlayer()
        if not player then return 600 end

        local altitude = world.getPlayer():getPoint().y

        local aircraftType = player:getTypeName()
        if Library.aircraft[aircraftType] and Library.aircraft[aircraftType].altitude then
            altitude = math.max(altitude, Library.aircraft[aircraftType].altitude * 0.8)
        end

        return altitude
    end

    local function getOrbitTaskTable(point2)
        return {
            id = "Orbit",
            params = {
                altitude = getOrbitAltitude(),
                pattern = "Circle",
                point = point2,
                width = DCSEx.converter.nmToMeters(1.0)
            }
        }
    end

    local function getRejoinTaskTable(formationDistance)
        formationDistance = formationDistance or 800

        return {
            id = "Follow",
            params = {
                groupId = DCSEx.dcs.getObjectIDAsNumber(world.getPlayer():getGroup()),
                lastWptIndexFlag  = false,
                lastWptIndex = -1,
                pos = { x = -formationDistance, y = 0, z = -formationDistance }
            }
        }
    end

    function TUM.wingmenTasking.commandEngage(groupCategory, targetAttributes, delayRadioAnswer)
        delayRadioAnswer = delayRadioAnswer or false
        if TUM.settings.getValue(TUM.settings.id.MULTIPLAYER) then return end -- No wingmen in multiplayer

        local wingmenCtrl = TUM.wingmen.getController()
        if not wingmenCtrl then return end

        -- Strike targets are handled differently
        if groupCategory == "strike" then
            local targetPoint3 = doCommandEngageStrikeTargets()

            if targetPoint3 then
                TUM.radio.playForAll("pilotWingmanEngageStrike", { TUM.wingmen.getFirstWingmanNumber(), DCSEx.dcs.getBRAA(targetPoint3, DCSEx.world.getGroupCenter(TUM.wingmen.getGroup()), false) }, TUM.wingmen.getFirstWingmanCallsign(), delayRadioAnswer)
            else
                TUM.radio.playForAll("pilotWingmanEngageNoTarget", { TUM.wingmen.getFirstWingmanNumber() }, TUM.wingmen.getFirstWingmanCallsign(), delayRadioAnswer)
            end
            return
        end

        local detectedContacts = TUM.wingmenContacts.getContacts(groupCategory)
        local validTargets = {}
        for _,c in ipairs(detectedContacts) do
            local g = DCSEx.world.getGroupByID(c.id)
            if g then
                local gUnits = g:getUnits()
                for _,u in ipairs(gUnits) do
                    local isValid = false
                    if not targetAttributes or #targetAttributes == 0 then
                        isValid = true
                    else
                        for _,a in ipairs(targetAttributes) do
                            if u:hasAttribute(a) then
                                isValid = true
                                break
                            end
                        end
                    end

                    if isValid then table.insert(validTargets, u) end
                end
            end
        end

        if #validTargets == 0 then
            TUM.radio.playForAll("pilotWingmanEngageNoTarget", { TUM.wingmen.getFirstWingmanNumber() }, TUM.wingmen.getFirstWingmanCallsign(), delayRadioAnswer)
            return
        end

        local wingmenPosition = DCSEx.world.getGroupCenter(TUM.wingmen.getGroup())

        validTargets = DCSEx.dcs.getNearestObjects(wingmenPosition, validTargets, 1)
        local target = validTargets[1]
        currentTargetIDorPoint = DCSEx.dcs.getGroupIDAsNumber(target:getGroup())
        currentTargetType = "group"

        -- If target is tough, make everyone attack it. Else, only one aircraft attack to save ammo
        local allWingmenShouldAttack = false
        if target:hasAttribute("Heavy armed ships") then
            allWingmenShouldAttack = true
        elseif (target:hasAttribute("MR SAM") or target:hasAttribute("MR SAM")) and target:hasAttribute("SAM TR") then
            allWingmenShouldAttack = true
        end

        local taskTable = {
            id = "AttackGroup",
            params = {
                groupAttack = allWingmenShouldAttack,
                groupId = currentTargetIDorPoint,
            }
        }

        local targetInAir = target:inAir()
        allowWeaponUse(wingmenCtrl, targetInAir, not targetInAir)
        wingmenCtrl:setTask(taskTable)

        local targetBRAA = "distance unknown"
        local targetInfo = nil
        local messageSuffix = nil
        if targetInAir then
            messageSuffix = "Air"
            targetInfo = Library.objectNames.get(target) -- Library.objectNames.getGeneric(target)
            targetBRAA = DCSEx.dcs.getBRAA(target:getPoint(), wingmenPosition, true)
        else
            messageSuffix = "Surface"
            targetInfo = Library.objectNames.get(target) -- Library.objectNames.getGeneric(target)
            targetBRAA = DCSEx.dcs.getBRAA(target:getPoint(), wingmenPosition, false)
        end

        -- Mark the last targeted point in debug mode
        if TUM.DEBUG_MODE then
            if targetPointMapMarker then
                trigger.action.removeMark(targetPointMapMarker)
                targetPointMapMarker = nil
            end
            targetPointMapMarker = DCSEx.world.getNextMarkerID()
            trigger.action.markToAll(targetPointMapMarker, "Last wingmen attack point", target:getPoint(), true)
        end

        TUM.radio.playForAll("pilotWingmanEngage"..messageSuffix, { TUM.wingmen.getFirstWingmanNumber(), targetInfo, targetBRAA }, TUM.wingmen.getFirstWingmanCallsign(), delayRadioAnswer)
    end

    function TUM.wingmenTasking.commandGoToMapMarker(markerText, delayRadioAnswer)
        markerText = markerText or TUM.wingmenTasking.DEFAULT_MARKER_TEXT
        delayRadioAnswer = delayRadioAnswer or false
        if TUM.settings.getValue(TUM.settings.id.MULTIPLAYER) then return end -- No wingmen in multiplayer

        local mapMarker = DCSEx.world.getMarkerByText(markerText)
        if not mapMarker and not mapMarkerMissingWarningAlreadyDisplayed then
            trigger.action.outText("Map marker missing.\nYou must create a marker on the F10 map and set it text to \""..markerText:upper().."\" (without quotes) to communicate coordinates to your wingmen.", 10)
            mapMarkerMissingWarningAlreadyDisplayed = true
        end

        local wingmenCtrl = TUM.wingmen.getController()
        if not wingmenCtrl then return end


        if not mapMarker then
            -- TUM.radio.playForAll("pilotWingmanGoToMarkerNoMarker", { TUM.wingmen.getFirstWingmanNumber() }, TUM.wingmen.getFirstWingmanCallsign(), delayRadioAnswer)
            return
        end

        currentTargetIDorPoint = nil
        allowWeaponUse(wingmenCtrl, false, false)
        wingmenCtrl:setTask(getOrbitTaskTable(DCSEx.math.vec3ToVec2(mapMarker.pos)))
        -- TUM.radio.playForAll("pilotWingmanGoToMarker", { TUM.wingmen.getFirstWingmanNumber() }, TUM.wingmen.getFirstWingmanCallsign(), delayRadioAnswer)
    end

    function TUM.wingmenTasking.commandOrbit(delayRadioAnswer)
        delayRadioAnswer = delayRadioAnswer or false
        if TUM.settings.getValue(TUM.settings.id.MULTIPLAYER) then return end -- No wingmen in multiplayer

        local wingmenCtrl = TUM.wingmen.getController()
        if not wingmenCtrl then return end

        allowWeaponUse(wingmenCtrl, false, false)
        currentTargetIDorPoint = nil
        wingmenCtrl:setTask(getOrbitTaskTable(DCSEx.world.getGroupCenter(TUM.wingmen.getGroup())))
        TUM.radio.playForAll("pilotWingmanOrbit", { TUM.wingmen.getFirstWingmanNumber() }, TUM.wingmen.getFirstWingmanCallsign(), delayRadioAnswer)
    end

    function TUM.wingmenTasking.commandRejoin(formationDistance, delayRadioAnswer, silent, taskingComplete)
        delayRadioAnswer = delayRadioAnswer or false
        silent = silent or false
        taskingComplete = taskingComplete or false
        if TUM.settings.getValue(TUM.settings.id.MULTIPLAYER) then return end -- No wingmen in multiplayer

        local player = world:getPlayer()
        if not player then return end

        local wingmenCtrl = TUM.wingmen.getController()
        if not wingmenCtrl then return end

        currentTargetIDorPoint = nil
        allowWeaponUse(wingmenCtrl, false, false)
        wingmenCtrl:setTask(getRejoinTaskTable(formationDistance))
        if not silent then
            local msgID = "pilotWingmanRejoin"
            if taskingComplete then msgID = "pilotWingmanRejoinTaskComplete" end
            TUM.radio.playForAll(msgID, { TUM.wingmen.getFirstWingmanNumber() }, TUM.wingmen.getFirstWingmanCallsign(), delayRadioAnswer)
        end
    end

    function TUM.wingmenTasking.commandReportContacts(groupCategory, noReportIfNoContacts, delayRadioAnswer)
        noReportIfNoContacts = noReportIfNoContacts or false
        delayRadioAnswer = delayRadioAnswer or false
        if TUM.settings.getValue(TUM.settings.id.MULTIPLAYER) then return end -- No wingmen in multiplayer

        local reportString = TUM.wingmenContacts.getContactsAsReportString(groupCategory, true)

        if not reportString then
            if noReportIfNoContacts then return false end
            TUM.radio.playForAll("pilotWingmanReportContactsNoJoy", { TUM.wingmen.getFirstWingmanNumber() }, TUM.wingmen.getFirstWingmanCallsign(), delayRadioAnswer)
            return true
        else
            TUM.radio.playForAll("pilotWingmanReportContacts", { TUM.wingmen.getFirstWingmanNumber(), reportString }, TUM.wingmen.getFirstWingmanCallsign(), delayRadioAnswer)
            return true
        end
    end

    function TUM.wingmenTasking.commandReportStatus(delayRadioAnswer)
        delayRadioAnswer = delayRadioAnswer or false
        if TUM.settings.getValue(TUM.settings.id.MULTIPLAYER) then return end -- No wingmen in multiplayer

        local wingmenGroup = TUM.wingmen.getGroup()
        if not wingmenGroup then return end

        local groupUnits = wingmenGroup:getUnits()

        local statusMsg = ""
        for i,u in ipairs(groupUnits) do
            statusMsg = statusMsg..u:getCallsign():upper().."\n"
            if u:getLife() >= u:getLife0() then
                statusMsg = statusMsg.."- No damage sustained, fuel green"
            else
                statusMsg = statusMsg.."- Aircraft suffered damage, fuel green"
            end
            statusMsg = statusMsg.."\n- BRAA from you: "..DCSEx.dcs.getBRAA(u:getPoint(), DCSEx.math.vec3ToVec2(world:getPlayer():getPoint()), true)
            statusMsg = statusMsg.."\n- Armament: "
            local ammo = u:getAmmo()
            if #ammo == 0 then
                statusMsg = statusMsg.."None"
            else
                for j,a in ipairs(ammo) do
                    if a.count and a.desc and (a.desc.displayName or a.desc.typeName) then
                        local ammoName = a.desc.displayName or a.desc.typeName
                        if j > 1 then statusMsg = statusMsg..", " end
                        statusMsg = statusMsg..tostring(a.count).."x "..ammoName
                    end
                end
            end

            if i < #groupUnits then statusMsg = statusMsg.."\n\n" end
        end

        TUM.radio.playForAll("pilotWingmanReportStatus", { TUM.wingmen.getFirstWingmanNumber(), statusMsg },  TUM.wingmen.getFirstWingmanCallsign(), delayRadioAnswer)
    end

    ----------------------------------------------------------
    -- Called on every mission update tick (every 10-20 seconds)
    ----------------------------------------------------------    
    function TUM.wingmenTasking.onClockTick()
        -- No tasking? Rejoin leader
        local wingmenCtrl = TUM.wingmen:getController()
        if wingmenCtrl and not wingmenCtrl:hasTask() then
            TUM.wingmenTasking.commandRejoin(nil, false)
            return
        end

        if not currentTargetIDorPoint then return end

        -- Targeted object is dead? Rejoin leader
        if currentTargetType == "group" then
            local tgtGroup = DCSEx.world.getGroupByID(currentTargetIDorPoint)
            if not tgtGroup or tgtGroup:getSize() == 0 then
                TUM.wingmenTasking.commandRejoin(nil, false, false, true)
            end
        elseif currentTargetType == "static" then
            local tgtStatic = DCSEx.world.getStaticObjectByID(currentTargetIDorPoint)
            if not tgtStatic then
                TUM.wingmenTasking.commandRejoin(nil, false, false, true)
            end
        elseif currentTargetType == "scenery" then
            local sceneriesInZone = DCSEx.world.getSceneriesInZone(currentTargetIDorPoint, 5)
            if not sceneriesInZone or #sceneriesInZone == 0 or sceneriesInZone[1]:getLife() < 1 then
                TUM.wingmenTasking.commandRejoin(nil, false, false, true)
            end
        end
    end
end
