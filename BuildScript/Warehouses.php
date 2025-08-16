<?php

function createWarehousesTable($theaterJson)
{
    $lua = "warehouses =\n";
    $lua .= "{\n";
    $lua .= "\tairports =\n";
    $lua .= "\t{\n";

    foreach ($theaterJson["airbasesIDs"] as $airbaseID)
    {
        $lua .= "\t\t[$airbaseID] =\n";
        $lua .= "\t\t{\n";
        $lua .= "\t\t\tgasoline =\n";
        $lua .= "\t\t\t{\n";
        $lua .= "\t\t\t	InitFuel = 100,\n";
        $lua .= "\t\t\t},\n";
        $lua .= "\t\t\tunlimitedMunitions = true,\n";
        $lua .= "\t\t\tdynamicCargo = false,\n";
        $lua .= "\t\t\tOperatingLevel_Air = 10,\n";
        $lua .= "\t\t\tdiesel =\n";
        $lua .= "\t\t\t{\n";
        $lua .= "\t\t\t	InitFuel = 100,\n";
        $lua .= "\t\t\t},\n";
        $lua .= "\t\t\tspeed = 16.666666,\n";
        $lua .= "\t\t\tdynamicSpawn = true,\n";
        $lua .= "\t\t\tunlimitedAircrafts = true,\n";
        $lua .= "\t\t\tunlimitedFuel = true,\n";
        $lua .= "\t\t\tmethanol_mixture =\n";
        $lua .= "\t\t\t{\n";
        $lua .= "\t\t\t	InitFuel = 100,\n";
        $lua .= "\t\t\t},\n";
        $lua .= "\t\t\tperiodicity = 30,\n";
        $lua .= "\t\t\tsuppliers = {},\n";
        $lua .= "\t\t\tcoalition = \"NEUTRAL\",\n";
        $lua .= "\t\t\tsize = 100,\n";
        $lua .= "\t\t\tOperatingLevel_Eqp = 10,\n";
        $lua .= "\t\t\tallowHotStart = false,\n";
        $lua .= "\t\t\taircrafts = {},\n";
        $lua .= "\t\t\tweapons = {},\n";
        $lua .= "\t\t\tOperatingLevel_Fuel = 10,\n";
        $lua .= "\t\t\tjet_fuel =\n";
        $lua .= "\t\t\t{\n";
        $lua .= "\t\t\t	InitFuel = 100,\n";
        $lua .= "\t\t\t},\n";
        $lua .= "\t\t},\n";
    }

    $lua .= "\t},\n";
    $lua .= "\twarehouses = {},\n";
    $lua .= "}\n";

    file_put_contents("_DebugOutput/Warehouses-".$theaterJson["dcsID"].".lua", $lua);
    return $lua;
}

?>
