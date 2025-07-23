<?php

function computeCenter($vertices)
{
    $center = [ 0, 0 ];
    
    foreach ($vertices as $vertex)
    {
        $center[0] += $vertex[0];
        $center[1] += $vertex[1];
    }

    $center[0] /= count($vertices);
    $center[1] /= count($vertices);

    return $center;
}

function makeZoneLua($vertices, $index, $name, $color)
{
    $center = computeCenter($vertices);

    $lua = "[$index] =\n{\n";
    $lua .= "radius = 10,\n";
    $lua .= "zoneId = $index,\n";
    $lua .= "color = $color,\n";
    $lua .= "properties = { },\n";
    $lua .= "hidden = false,\n";
    $lua .= "x = ".strval($center[0]).",\n";
    $lua .= "y = ".strval($center[1]).",\n";
    $lua .= "name = \"$name\",\n";
    $lua .= "type = 2,\n";
    $lua .= "heading = 0,\n";
    $lua .= "verticies =\n{\n";
    for ($i = 1; $i <= 4; $i++) {
        $lua .= "[$i] =\n{\n";
        $lua .= "x = ".strval($vertices[$i - 1][0]).",\n";
        $lua .= "y = ".strval($vertices[$i - 1][1]).",\n";
        $lua .= "},\n";
    }
    $lua .= "},\n},\n";
    
    return $lua;
}

function makeZones($theaterJson)
{
    $lua = "";
    $coalitionZoneCount = [1, 1];
    $zoneCount = 1;

    foreach (["blue", "red"] as $zoneType)
    {
        foreach ($theaterJson["territories"][$zoneType] as $zone)
        {
            $name = "ZONE";
            switch ($zoneType)
            {
                case "blue":
                    $color = "{ [1] = 0, [2] = 0.125, [3] = 1, [4] = 0.35 }";
                    $name = "BLUFOR".strval($coalitionZoneCount[0]);
                    break;
                case "red":
                    $color = "{ [1] = 1, [2] = 0.125, [3] = 0, [4] = 0.35 }";
                    $name = "REDFOR".strval($coalitionZoneCount[1]);
                    break;
            }
            $lua .= makeZoneLua($zone, $zoneCount, $name, $color);

            $zoneCount++;
            switch ($zoneType)
            {
                case "blue": $coalitionZoneCount[0]++; break;
                case "red": $coalitionZoneCount[1]++; break;
            }
        }
    }

    if (isset($theaterJson["water"]))
    {
        $waterZonesCount = 1;
        foreach ($theaterJson["water"] as $zone)
        {
            $lua .= makeZoneLua($zone, $zoneCount, "WATER".strval($waterZonesCount), "{ [1] = 0, [2] = 0.8, [3] = 1, [4] = 0.35 }");
            $zoneCount++;
            $waterZonesCount++;
        }
    }

    $color = "{ [1] = 0.5, [2] = 0.5, [3] = 0.5, [4] = 0.35 }";
    foreach (array_keys($theaterJson["targetZones"]) as $key)
    {
        $lua .= makeZoneLua($theaterJson["targetZones"][$key], $zoneCount, $key, $color);
        $zoneCount++;
    }

    return $lua;
}

function createMissionTable($theaterJson, $debugMode)
{
    $lua = file_get_contents("./Miz/Mission.lua");

    $lua = str_replace("__THEATER__", $theaterJson["dcsID"], $lua);
    $lua = str_replace("__MAP_CENTER_X__", strval($theaterJson["mapCenter"][0]), $lua);
    $lua = str_replace("__MAP_CENTER_Y__", strval($theaterJson["mapCenter"][1]), $lua);
    $lua = str_replace("__MAP_ZOOM__", strval($theaterJson["mapZoom"]), $lua);
    $lua = str_replace("__MISSION_BRIEFING__", "", $lua); // TODO
    $lua = str_replace("__MISSION_DESCRIPTION__", "The Universal Mission for DCS World is an attempt to create a fully dynamic single-player/PvE mission giving access to the whole content of DCS World.\\n\\nOpen the F10/Other submenu in the communication menu to begin.\\n\\nVisit github.com/akaAgar/the-universal-mission-for-dcs-world to learn more.", $lua);
    $lua = str_replace("__MISSION_NAME__", "The Universal Mission - ".$theaterJson["displayName"], $lua);
    $lua = str_replace("__WEATHER_TEMPERATURE__", strval($theaterJson["temperature"]), $lua);
    
    if ($debugMode)
        $lua = str_replace("__PLAYER_GROUP__", file_get_contents("./Miz/PlayerGroup-Debug.lua"), $lua);
    else
        $lua = str_replace("__PLAYER_GROUP__", file_get_contents("./Miz/PlayerGroup-Release.lua"), $lua);

    $lua = str_replace("__PLAYER_AIRDROME_ID__", strval($theaterJson["player"]["airdromeID"]), $lua);
    $lua = str_replace("__PLAYER_X__", strval($theaterJson["player"]["coordinates"][0]), $lua);
    $lua = str_replace("__PLAYER_Y__", strval($theaterJson["player"]["coordinates"][1]), $lua);

    $lua = str_replace("__ZONES__", makeZones($theaterJson), $lua);

    $lua = str_replace("__BULLSEYE_BLUE_X__", strval($theaterJson["bullseye"]["blue"][0]), $lua);
    $lua = str_replace("__BULLSEYE_BLUE_Y__", strval($theaterJson["bullseye"]["blue"][1]), $lua);
    $lua = str_replace("__BULLSEYE_RED_X__", strval($theaterJson["bullseye"]["red"][0]), $lua);
    $lua = str_replace("__BULLSEYE_RED_Y__", strval($theaterJson["bullseye"]["red"][1]), $lua);

    $lua = str_replace("__DATE_DAY__", strval($theaterJson["dateTime"]["day"]), $lua);
    $lua = str_replace("__DATE_MONTH__", strval($theaterJson["dateTime"]["month"]), $lua);
    $lua = str_replace("__DATE_YEAR__", strval($theaterJson["dateTime"]["year"]), $lua);
    $lua = str_replace("__START_TIME__", strval(($theaterJson["dateTime"]["hour"] * 60 + $theaterJson["dateTime"]["minute"]) * 60), $lua);

    file_put_contents("_DebugOutput/Mission-".$theaterJson["dcsID"].".lua", $lua);
    return $lua;
}

?>
