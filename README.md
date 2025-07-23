# The Universal Mission for DCS World

**Current version: open beta 0.1.250722-update1** (see the "version history" section at the end of this file for a list of the latest changes)

**This is a BETA version, there may be bugs and there WILL be unbalanced stuff.**

The Universal Mission for DCS World is an attempt to create a fully dynamic single-player/PvE mission giving access to the whole content of DCS World in a structure similar to the one found in old "simulators", like the early Microprose games (think F-117 or the Strike Eagle serie).
These game had both fun and clear objectives, endless replayability and a career system that made sure that something was at stake: crash and die, and you'll lose all these hard-earned medals.

As the original creator of [Briefing Room](https://github.com/DCS-BR-Tools/briefing-room-for-dcs) (now maintained by the talented John Harvey), I've always wanted to create an easy-to-use, enticing and fun mission generator for DCS, capable of creating CPU-light missions without requiring an external program.
I think with The Universal Mission is, finally, the proper way to approach this problem. The current version is still an early beta but most core features are already working. I hope you'll like it.

### Features

- Can generate any kind of mission: ground attack, interception, strike, airbase attack, CAS, CAP, and more
- Completely dynamic, no two missions are ever the same
- Entirely self-contained inside a .miz file, no need for any external program
- More than 170 fully voiced radio messages (with more coming) for immersive and realistic coms
- Supports both single-player and small-scale PvE on closed servers
- Persistent single player career mode, with awards and promotions. Dying won't reset your progress, but you have to come back to base alive for your kills and completed objectives to be saved to your profile, so watch out for SAMs on your way home
- Uses advanced DCS World scripting functionalities (like the brand new Disposition singleton and net.dostring_in hacks) to achieve effects seldom seen in other scripts, such as graphic overlays and random but realistic placement of units in cities and forests without the use of handmade spawn points
- Various little details to make the DCS world more alive, like crew running away from destroyed vehicles

[![Screen shot of the mission settings menu](./docs/mission-settings-tn.jpg)](./docs/mission-settings.jpg)
[![Screen shot of the target zone system](./docs/target-zones-tn.jpg)](./docs/target-zones.jpg)
[![Screen shot of the career mode's medal case display](./docs/career-mode-tn.jpg)](./docs/career-mode.jpg)

### Limitations of current beta version

**Please read the "planned development" section below for more information.**

- The current version supports only modern (post-Cold War) units and Caucasus, Kola, Marianas, Persian Gulf and Syria theaters
  - Germany support will come soon, others will follow later
- Not all mission types are supported yet
- Career progress may be lost because of future updates, don't get too attached to it

## How to use/play The Universal Mission?

### First setup

- Download the latest release from this GitHub page.
- Copy the provided autoexec.cfg file to your **[Saved Games]\DCS\Config directory**
- Copy the .miz files for your theater(s) of choice to your **[Saved Games]\DCS\Missions directory**
- _**(Optional but strongly recommended)**_ Unsanitize the Lua IO module. You don't have to do this, but the persistent career system won't work if you don't. To do it, open the file **[DCS World installation directory]\Scripts\MissionScripting.lua** with a text editor and comment or remove the line "sanitizeModule('io')". Make sure you restart DCS World once you've modified the file.
  - Please note: should you want to backup, delete or transfer it, career progress is saved in **[DCS World installation directory]\TheUniversalMission.sav**

### Customizing the mission to your taste

- _**(Optional but you'll probably want to do it)**_ Open the .miz file in the DCS World mission editor and change the player unit to pick your desired aircraft. The default player unit is a Su-25T (as it is the only free DCS airplane equipped with weapons) and you probably won't want to stick with it.

Please refer to the "Advanced stuff you may want to try" section to learn all the ways you can customize The Universal Mission.

### Starting the mission

- Launch the mission from the mission editor or the "Mission" selection in the main menu
- You are now on the ramp or runway. Open the communication menu and navigate to the F10/Other menu. From there, you can view and change mission settings. They include:
  - Who belong to the blue and red coalitions
  - The type of mission
  - The number and location of targets (you can use the F10 map to see where the available target zones are located). Be aware that targets of antiship strikes will always be spawned in open seas, which can be quite far if you picked a landlocked target zone
  - The amount of enemy air force and air defense. The higher these settings, the more XP you'll recieve upon completion of a single-player mission
- When you're ready, pick the "Begin mission" option, wait a few seconds (precaching all the game assets can take some time, especially if you have a slow CPU), you're ready to go!
- Use the F10 mission and check the F10 map for additional information about the mission. Don't forget to come back to base alive, all awarded XP and completed objectives will only be saved to your pilot profile once you've landed

### Playing

### Advanced stuff you may want to try

The Universal Mission is designed to be easily editable to suit your preferences. Here are a few things you could do after opening the .miz file in DCS World's mission editor.

#### Player aircraft

- Change the player aircraft starting condition (runway, parking or parking hot). Air starts are not recommended as all players must be on the ground to begin a new mission
- Move it to another airbase, change its coalition (make sure blue players are spawned on an airbase located in a BLUFOR zone are red players are spawned on an airbase located in a REDFOR zone)
  - You may also add an aircraft carrier or a FARP for the player to take off from
- Change its default loadout if you plan to play a specific kind of mission and don't want to lose time asking the ground crew to rearm your aircraft (e.g. if you know you want to play SEAD missions, you may as well stock up on AGM-88s)
- Change the skill level from "Player" to "Client" and add other aircraft to create a multiplayer mission to play with your friends. Keep in mind that the persistent career/player stats system will be disabled in multiplayer missions and that all player aircraft must belong to the same coalition (TUM does not support PvP)

#### Zones

- All zones whose names starts with BLUFOR or REDFOR decide the territory (and airbases) controlled by the blue and red coalitions
  - Be aware that any change to the airbases coalitions will be superseded by the BLUFOR and REFOR zones
- All zones whose names starts with WATER are seas, used to spawn ships
- Zones with a name not starting with BLUFOR, REDFOR or WATER are target zones. These are zones where objectives can be spawned, who can be selected in the "objective location" setting of the intermission F10 menu
  - Change, add or remove zones to create new possible target areas. A maximum of 10 target areas can be created, so they fit the F10 menu

#### A few notes regarding multiplayer

While The Universal Mission supports multiplayer and is perfectely suitable (and fun!) for playing with friends on a private server, it is **absolutely not suited for public servers** as missions settings can be edited by anyone at any time using the F10 menu.
Please also note that PvP is not supported at the moment and that the mission will not launch if both coalitions have player slots.

#### Other parameters

- _(Not yet implemented in this version)_ By changing the year in mission time parameters, the time period will be changed accordingly and the proper factions and AI units will be spawned during the mission. Time periods are:
  - 1945 and before: World War 2
  - 1946-1959: Korea War
  - 1960-1974: Vietnam War
  - 1975-1989: Late Cold War
  - 1990-now: Modern
- _(Not yet implemented in this version)_ Changing the weather to make it more cloudy or windy, or setting the mission to nighttime, will make the mission more difficult but also award more points.

## Planned development

### VERY high priority

- New objectives: helicopter (drop/pickup units...), CAP, CAS, OCA (airbase attack)
- New menu for enemy contacts report, allowing both to quiery AWACS reports and to ask other AI pilots about what they see in the air and on the ground
- Support for Germany theater

### High priority

- Additional and better radio messages
  - More "flavor" radio messages ("fence in" when player approaches the AO, etc) so the world will feel more alive
- All new AI wingman system
- Better balancing of the player career awards and promotions
- Better use of context for "ambient" radio messages (should only warn of a SAM launch if an AI pilot is there to witness it, etc)
- Friendly air defenses
- Laser designation of targets by JTAC
- Support for all missing DCS World theaters
- Support for more factions and five different time periods (World War 2, Korea war, Vietnam war, late Cold war, Modern)

### Medium priority

- Advanced options such as "use metric units" or "use bullseye rather than player position for coordinates transmission" (the later awarding more XP when enabled, because of the need for higher situational awareness)
- GitHub page
- Improved score multiplier taking into account various aspects of mission difficulty (weather, nighttime ops...)
- Modded units support (other than player-controlled aircraft, those are already supported: just add them to the mission)
- Spawning of tankers for long-range missions
- (maybe) Text (not voiceover) localization, if there's enough popular demand

### Low priority

- Female voice option for the player
- New ATC system. Won't be realistic/BMS-like but a LOT better than the vanilla DCS one
- (maybe) AI CSAR helos to pick up stranded/ejected pilots
- (maybe) PvP support

## Misc

- **Released under the GNU GPL 3.0 licence**
- AI use/disclosure
  - [ChatGPT](https://chatgpt.com/): used to generate first draft of radio messages
  - [ElevenLabs](https://elevenlabs.io/fr): used to generate radio messages voiceover

## How to build the miz files

_**(this is for developpers only, end users should just download the latest release)**_

I use a PHP script to "build" the .miz files as PHP is a pretty handy tool capable both of handling all required replacements and pack the miz files.

If you want to build the .miz files yourself, you'll need to:

- [Download PHP](https://www.php.net/) and install it
- Add the PHP directory it to your system PATH so the batch file will find it
- In the PHP directory, rename php.ini-production to php.ini, edit it and uncomment or delete the "extension=mbstring" line to enable the MBString extension that my script uses.
- Then run Make.bat in the source directory (or, alternatively, open the source directory in VSCode and press Ctrl+Alt+B)
- .Miz files will be generated in the project root directory, and a copy will be sent to your DCS World "missions" directory (if it exists)

## Want to contribute to the project?

The core script is quite simple and small, I probably won't need too much help with it (of course you're free to suggest improvements and submit pull requests).

**What I'll need help with most is:**

- Feedback, feedback, feedback. Especially regarding bug (don't forget to write down the various script line numbers mentioned in the error message!) mission balancing and career progression.
  - You can contact me through GitHub or send me a mail at akaagarmail@gmail.com
- Help with the Lua tables in the Database\Factions and Database\Aircraft directories. Adding missing aircraft, payload for various aircraft and unit lists for various time periods would be really helpful.
- Complete the library of "unit human-readable names" in Script\Library\ObjectNames.lua
- You can also [buy me a coffee](https://buymeacoffee.com/akaagar)!

## Version history

- **0.1.250722-update1** (07/22/2025)
  - Added Kola theater
  - Added Marianas theater
  - Added message when XP is awarded to player after landing
  - Fixed bug when friendly non-unit object is hit
  - Slightly lowered XP required for medals and promotions
- **0.1.250722** (07/22/2025)
  - Initial public release
