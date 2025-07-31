-- ====================================================================================
-- DCSEX.UNITNAMESMAKER - GENERATE CREDIBLE AND UNIT NAMES FOR UNIT GROUPS
-- ====================================================================================
DCSEx.unitNamesMaker = {}

do
    local function getSectionNameSuffixAir()
        return DCSEx.table.getRandom({"squadron", "wing"})
    end

    local function getSectionNameSuffixGround()
        return DCSEx.table.getRandom({"bataillon", "brigade", "corps", "division", "regiment"})
    end

    local function getSectionNameSuffixNaval()
        return DCSEx.table.getRandom({"fleet", "force"})
    end

    local function getDefaultSectionName()
        return "unit "..getSectionNameSuffixGround()
    end

    local function getNameByDesc(unitDesc)
        if not unitDesc then return getDefaultSectionName() end

        if unitDesc.attributes["UAVs"] then
            return DCSEx.table.getRandom({"unmanned"}).." "..getSectionNameSuffixAir()
        end
        if unitDesc.attributes["Bombers"] then
            return DCSEx.table.getRandom({"bomber"}).." "..getSectionNameSuffixAir()
        end
        if unitDesc.attributes["Fighters"] or unitDesc.attributes["Interceptors"] or unitDesc.attributes["Battle airplanes"] then
            return DCSEx.table.getRandom({"fighter", "fighting"}).." "..getSectionNameSuffixAir()
        end
        if unitDesc.attributes["Planes"] then
            return DCSEx.table.getRandom({"air", "cargo", "transport"}).." "..getSectionNameSuffixAir()
        end

        if unitDesc.attributes["Attack helicopters"] then
            return DCSEx.table.getRandom({"assault", "rotary"}).." "..getSectionNameSuffixAir()
        end
        if unitDesc.attributes["Helicopters"] then
            return DCSEx.table.getRandom({"tactical"}).." "..getSectionNameSuffixAir()
        end

        if unitDesc.attributes["Aircraft Carriers"] then
            return DCSEx.table.getRandom({"carrier"}).." "..getSectionNameSuffixNaval()
        end
        if unitDesc.attributes["Unarmed ships"] then
            return DCSEx.table.getRandom({"cargo", "logistical"}).." "..getSectionNameSuffixNaval()
        end
        if unitDesc.attributes["Ships"] then
            return DCSEx.table.getRandom({"expeditionary", "assault"}).." "..getSectionNameSuffixNaval()
        end

        if unitDesc.attributes["MANPADS AUX"] or unitDesc.attributes["MANPADS"] or unitDesc.attributes["Armed Air Defence"] or unitDesc.attributes["SAM elements"] or unitDesc.attributes["SAM related"] or unitDesc.attributes["SAM"] then
            return DCSEx.table.getRandom({"air defense"}).." "..getSectionNameSuffixGround()
        end

        if unitDesc.attributes["Tanks"] or unitDesc.attributes["HeavyArmoredUnits"] or unitDesc.attributes["LightArmoredUnits"] then
            return DCSEx.table.getRandom({"armor", "heavy"}).." "..getSectionNameSuffixGround()
        end
        if unitDesc.attributes["LightArmoredUnits"] then
            return DCSEx.table.getRandom({"armored", "mechanized"}).." "..getSectionNameSuffixGround()
        end
        if unitDesc.attributes["Ground vehicles"] then
            return DCSEx.table.getRandom({"engineer","logistical","support","tactical"}).." "..getSectionNameSuffixGround()
        end
        if unitDesc.attributes["Infantry"] then
            return DCSEx.table.getRandom({"infantry"}).." "..getSectionNameSuffixGround()
        end

        return getDefaultSectionName()
    end

    function DCSEx.unitNamesMaker.getName(groupID, unitTypes)
        local nameNumber = tostring(groupID)

        if (nameNumber:sub(-1) == "1") then nameNumber = nameNumber.."st"
        elseif (nameNumber:sub(-1) == "2") then nameNumber = nameNumber.."nd"
        elseif (nameNumber:sub(-1) == "3") then nameNumber = nameNumber.."rd"
        else nameNumber = nameNumber.."th"
        end

        local nameSection = getDefaultSectionName()
        if unitTypes and #unitTypes > 0 then
            local desc = Unit.getDescByName(unitTypes[1])
            if desc then
                nameSection = getNameByDesc(desc)
            end
        end

        return nameNumber.." "..nameSection
    end
end
