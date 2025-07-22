<?php

function createScript($theaterJson, $debugMode)
{
    echo "  Concatenating script file...\n";
    $lua = file_get_contents("./Script/Script.lua");

    if ($debugMode)
        $lua = str_replace("__DEBUG_MODE__", "true", $lua);
    else
        $lua = str_replace("__DEBUG_MODE__", "false", $lua);

    // Replace all lignes in the format "--[[.*]]--" by the contents of the given Script subdirectory (e.g. "--[[LIBRARY]]--" means "all .lua files from the Script/Library subdirectory")
    do
    {
        $matches = null;
        preg_match_all("/--\[\[.*\]\]--/", $lua, $matches, PREG_OFFSET_CAPTURE);
        if (count($matches[0]) == 0) break;

        foreach ($matches[0] as $match)
        {
            $dirName = mb_substr($match[0], 4, strlen($match[0]) - 8);
            $sourceDir = "./Script/".$dirName."/";
            $replacement = "";
            if (is_dir($sourceDir))
            {
                $files = scandir($sourceDir);
                foreach ($files as $file)
                {
                    if (!is_file($sourceDir.$file)) continue;
                    if (!str_ends_with(strtolower($file), ".lua")) continue;

                    $replacement .= trim(file_get_contents($sourceDir.$file), " \n\r,")."\n";
                }
            }

            $lua = str_replace($match[0], $replacement, $lua);
        }
    } while (true);

    // Replace all lignes in the format "--[[.*]]--" by the contents of the given Database subdirectory (e.g. "--{{LIBRARY}}--" means "all .lua files from the Database/Library subdirectory")
    do
    {
        $matches = null;
        preg_match_all("/--\{\{.*\}\}--/", $lua, $matches, PREG_OFFSET_CAPTURE);
        if (count($matches[0]) == 0) break;

        foreach ($matches[0] as $match)
        {
            $dirName = mb_substr($match[0], 4, strlen($match[0]) - 8);
            $sourceDir = "./Database/".$dirName."/";
            $replacement = "";
            if (is_dir($sourceDir))
            {
                $files = scandir($sourceDir);
                foreach ($files as $file)
                {
                    if (!is_file($sourceDir.$file)) continue;
                    if (!str_ends_with(strtolower($file), ".lua")) continue;

                    $replacement .= trim(file_get_contents($sourceDir.$file), " \n\r,")."\n";
                }
            }

            $lua = str_replace($match[0], $replacement, $lua);
        }
    } while (true);

    file_put_contents("./_DebugOutput/Script-".$theaterJson["dcsID"].".lua", $lua);
    return $lua;
}

?>
