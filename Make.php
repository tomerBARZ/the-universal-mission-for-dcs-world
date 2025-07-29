<?php

require_once("./BuildScript/Mission.php");
require_once("./BuildScript/Script.php");
require_once("./BuildScript/Warehouses.php");

if (!is_dir("./_DebugOutput"))
    mkdir("./_DebugOutput");

function packMiz($theaterJson, $debugMode)
{
    echo "  Writing ZIP file...\n";
    $zip = new ZipArchive();

    $suffix = "";
    if ($debugMode)
        $suffix = " [DEBUG]";

    $filename = "./The Universal Mission - ".$theaterJson["displayName"]."$suffix.miz";
    
    if ($zip->open($filename, ZipArchive::CREATE) !== true)
        return false;
    
    $zip->addFromString("mission", createMissionTable($theaterJson, $debugMode));
    $zip->addFile("./Miz/Options.lua", "options");
    $zip->addFromString("theatre", $theaterJson["dcsID"]);
    $zip->addFromString("warehouses", createWarehousesTable($theaterJson));
    $zip->addFromString("l10n/DEFAULT/dictionary", "dictionary = { }\n");
    $zip->addFromString("l10n/DEFAULT/Script.lua", createScript($theaterJson, $debugMode));

    $resourceTable = "mapResource =\n{\n\t[\"Script.lua\"] = \"Script.lua\",\n";
    $mediaFiles = scandir("./Media");
    foreach ($mediaFiles as $mediaFile) {
        if (!is_file("./Media/$mediaFile")) continue;
        $zip->addFile("./Media/$mediaFile", "l10n/DEFAULT/$mediaFile");
        $resourceTable .= "\t[\"$mediaFile\"] = \"$mediaFile\",\n";
    }
    $resourceTable .= "}\n";
    $zip->addFromString("l10n/DEFAULT/mapResource", $resourceTable);

    $zip->close();
    echo "  Done!\n\n";
    return true;
}

$buildType = "debug";
if (count($argv) > 1) $buildType = strtolower($argv[1]);
$buildSingleTheater = null;
if (count($argv) > 2) $buildSingleTheater = strtolower($argv[2]);

$theaterFiles = scandir("./Theaters");
foreach ($theaterFiles as $theaterFile)
{
    if (($theaterFile === ".") || ($theaterFile === "..")) continue;
    if (!str_ends_with(strtolower($theaterFile), ".json")) continue;

    if (($buildSingleTheater != null) && (strtolower($theaterFile) !== $buildSingleTheater.".json"))
        continue;

    $theaterJson = json_decode(file_get_contents("./Theaters/$theaterFile"), true);
    if ($theaterJson == null)
    {
        echo "WARNING: Failed to open scenario \"".$theaterFile."\"...\n";
        continue;
    }

    echo "Building scenario \"".$theaterFile."\"...\n";
    packMiz($theaterJson, $buildType !== "release");
    echo "\n";
}

?>
