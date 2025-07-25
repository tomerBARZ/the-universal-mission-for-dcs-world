Library.radioMessages = {

    pilotEjecting = {
        "Mayday, mayday! Taking fire, punching out now!",
        "Engine's gone, I'm bailing! Mark my chute!",
        "Bird's on fire, I'm out, call SAR!",
        "Control's dead, ejecting! Watch for the seat!",
        "Lost hydraulics, can't hold her! Bailing out!"
    },
    pilotImHit = {
        "I'm hit!",
        "Taking fire!",
        "Bird's hurt, trying to hold altitude!",
        "Impact on fuselage, took a solid hit!",
        "Taking damage, warning lights all over"
    },
    pilotKillAir = {
        "Splash one $1. Rejoining.",
        "Good hit, $1 down! Checking six.",
        "$1 down. I say again, splash one!",
        "Kill confirmed. $1's smoking.",
        "Splash one $1! Got him!",
        "Splash confirmed! Repeat, $1 down.",
        "$1 smoked, good kill.",
        "$1 splashed, no chute seen."
    }, -- "$1" should be "bandit" in audio version
    pilotKillGround = {
        "Splash one $1, repeat, target down. Eyes open for secondaries.",
        "$1 neutralized, big boom. Watch your altitude, debris kicking up.",
        "$1's a fireball, one less on the ground. Moving to next grid.",
        "Jackpot on that $1, burning good. Stay sharp for air defense.",
        "Scratch one $1, repeat scratch one.",
        "$1's toast, good effect on target. Rolling out.",
        "Got the $1, solid hit. Watch for air defense in that sector.",
        "Splash $1, good kill.",
        "$1's cooked, smoke's up."
    }, -- "$1" should be "vehicle" in audio version
    pilotKillShip = {
        "Splash confirmed! Enemy $1 going under.",
        "Direct hit! $1 burning and breaking up.",
        "$1's out of the fight! Big secondary explosion, she's listing hard.",
        "$1 neutralized, heavy smoke and debris in the water.",
        "Splash confirmed! Hull's cracking, $1's going down.",
        "$1's gone! Big fireball, multiple secondaries.",
        "$1's dead in the water! Zero movement on deck."
    }, -- "$1" should be "ship" in audio version
    pilotKillStrike = {
        "Target's gone, good splash. Structure's burning, over.",
        "Direct hit, building's collapsing. No secondary fire yet.",
        "Objective neutralized, smoke's up. Moving to egress.",
        "Good impact on target, structure is down.",
        "Target destroyed, heavy debris in the AO.",
        "Target's leveled, no movement inside.",
        "Structure is toast, solid hit.",
        "Good hit, building's breaking apart."
    },

    pilotLaunchGuns = { "Guns!", "Guns, guns!" },
    pilotLaunchBruiser = "Bruiser!",
    pilotLaunchFox1 = "Fox 1!",
    pilotLaunchFox2 = "Fox 2!",
    pilotLaunchFox3 = "Fox 3!",
    pilotLaunchMagnum = "Magnum!",
    pilotLaunchMissile = "Missile away!",
    pilotLaunchPickle = { "Pickle!", "Bomb away!" },
    pilotLaunchRifle = "Rifle!",
    pilotLaunchRocket = "Rockets!",

    pilotWarningAAA = { "Heads up, I'm seeing tracers. AAA fire.", "AAA lighting up, stay high.",  "Flight, we've got heavy flak incoming, break!", "AAA tracer fire, they've got our range, don't stay straight!", "AAA's hot under us. Stay fast, don't linger!" },
    pilotWarningMANPADS = { "MANPADS launch! Flare, flare, flare!", "Flight, MANPADS in the air. Dump flares, now!", "Coming from the ground, MANPADS hot!", "Go defensive, MANPADS off your nose! Flare, flare!", "MANPADS just came up from the deck, break hard and pop everything!" },
    pilotWarningSAMLaunch = { "Spike! SAM just launched, break!", "SAM up! Defensive now!", "Launch! SAM, coming fast, pump chaff, go cold!", "SAM in the air, break hard!", "SAM fired, visual smoke! Extend, extend!" },

    pilotWingmanEngageBandits = {
        "$1. Copy, engaging now.",
        "$1. Tally one, pressing.",
        "$1. Roger, comitting.",
        "$1. Confirm, going after him.",
        "$1. Affirm, moving in on bandits."
    },
    pilotWingmanEngageNoTarget = {
        "$1. Negative tally, unable engage.",
        "$1. Cannot comply, blind on target.",
        "$1. No joy on targets, cannot proceed.",
        "$1. Negative contact, unable to commit.",
        "$1. That's a no, not seeing any targets."
    },
    pilotWingmanGoToMarker = {
        "$1, copy. Pushing to waypoint now.",
        "$1, on route to the coords, maintaining current alt.",
        "$1, proceeding as briefed, on my way.",
        "$1, moving to grid as planned.",
        "$1's off, heading to the point."
    },
    pilotWingmanGoToMarkerNoMarker = {
        "$1, negative on coords, say again?",
        "$1. Copy, but I don’t have the point. Confirm?",
        "$1, missing the grid, need the mark.",
        "$1 blind on the coordinates, request update.",
        "$1 can't push, no steerpoint."
    },
    pilotWingmanOrbit = {
        "$1. Wilco, holding here.",
        "$1. Copy, orbiting now.",
        "$1. Roger, in the hold.",
        "$1. Affirm, setting up the orbit.",
        "$1. Orbiting at pos."
    },
    pilotWingmanRejoin = {
        "$1. Off the perch, rejoining your side.",
        "$1. Tally visual, coming to you.",
        "$1. Clear, rejoining to route.",
        "$1. Pushing up to formation.",
        "$1. Visual, sliding back into position."
    },
    pilotWingmanReportStatus = {
        "$1. Checking in.\n\n$2",
        "$1. Reporting.\n\n$2",
        "$1. Status report.\n\n$2",
    },

    atcSafeLanding = { "Be advised: $1 is wheels down at $2 and clear of runway.", "All aircraft, $1 has landed at $2 and vacated active. Runway is open for next inbound.", "Traffic, $1 is on deck at $2 and heading to parking. Runway clear.", "All flights, $1 just rolled out at $2 and cleared the active.", "Heads up, $1 landed at $2 and moving to the ramp. Runway available for next approach." },
    atcSafeLandingPlayer = { "$1, wheels on deck, welcome back. You may taxi to the parking area.", "$1, good copy on landing. Exit when able, proceed to the parking area.", "$1, touchdown confirmed. Continue to parking.", "$1, welcome home. Clear of runway and taxi to parking area.", "$1, nice landing. Taxi to parking when ready." },

    awacsPicture = {
        "$1, picture's up.$2",
        "$1, sending updated picture.$2",
        "$1, picture transmitted.$2",
        "$1, sending picture, over.$2",
        "$1, picture is live.$2",
    },
    awacsPictureClear = { "$1, picture clear.", "$1, picture is clean.", "$1, picture clear, nothing airborne.", "$1, picture clean at this time." },

    commandBlueOnBlue =
    {
        "Check fire! You hit a friendly!",
        "Break, break! You just tagged blue!",
        "Abort! You hit a friendly asset!",
        "Cease fire, check your IFF!",
        "Blue-on-blue, blue-on-blue!",
    },
    commandFriendlyDown = {
        "All flights, we lost a friendly. $1 is down. Eyes open, hostiles still active in the area.",
        "Friendly bird down, I repeat, friendly bird down. $1 went cold. Stay sharp, possible threat still live.",
        "All squadrons, heads up. $1 just took a hit and is down hard. Keep it tight.",
        "We've lost $1. No chute sighted. Threat's still out there.",
        "Friendly down. $1 is out of the fight. Maintain altitude discipline and check six.",
    },
    commandFriendlyPilotOnGround = "Ejected pilot is stranded on the ground. Launch CSAR operations immediately.",
    commandNewEnemyAircraft = {
        "Be advised, enemy fighters airborne from $2, heading unknown.",
        "To all flights, enemy fighters just launched from $2, expect contact in your sector.",
        "Flights, bogeys off $2, monitor radar and standby.",
        "Enemy birds wheels-up from $2, likely pushing toward your AO.",
        "Hostile aircraft launch confirmed from $2, maintain alert status."
    },
    commandMissionComplete = {
        "All flights, mission objectives confirmed complete. You're clear to RTB.",
        "All leads, targets neutralized. Good work out there. Proceed to home plate.",
        "All squadrons, job's done. Exit the AO on your current route and check in with tower on approach for recovery.",
        "All flights, tasking is finished. Return to base, tower will advise final.",
        "All squadrons, good job, we're outta here. Break off and RTB."
    },
    commandObjectiveComplete = {
        "All callsigns, objective $1 complete. Proceed to next objective.",
        "All flights, objective $1 is in the bag. Move to next phase as briefed.",
        "Flight leads, objective $1 secured. You're clear to proceed with the remainder.",
        "Work's done on objective $1. Push on to your next set.",
        "All flights, objective $1 wrapped, keep on the good work.",
        "All callsigns, objective $1's done. Proceed direct to next waypoint."
    },
    commandObjectiveCoordinates = "We have no exact coordinates for objective $1.\nObjective should be located near:\n$2\n\nFly $3 to reach the objective.",
    commandObjectiveCoordinatesPrecise = "We have exact coordinates for objective $1.\nObjective coordinates are:\n$2\n\nFly $3 to reach the objective.",
    commandObjectivesManyLeft = {
        "Stay focused, people. We still have work to do.\n$1",
        "Our work is not done yet, we have a lot to do.\n$1",
        "Flights, you've got a couple of tasks left, keep moving down the list.\n$1",
        "Still a few objectives outstanding, don't break until they're complete.\n$1",
        "Alright people, keep your focus, more work ahead before you can head home.\n$1",
        "All flights, maintain timeline. You've got more boxes to check before RTB.\n$1"
    },
    commandObjectivesOneLeft = {
        "All flights, you've got one last task before you're done.\n$1",
        "Flights, almost home. One objective remaining, then you're RTB.\n$1",
        "All flights, you're down to the final push. Complete this and you're done.\n$1",
        "All leads, one more on the board. Finish it and head back to base.\n$1",
        "Flights, you're not clear yet. One last objective to wrap up.\n$1",
        "Come on people, one last push and we're done.\n$1",
        "Just one objective to complete and we're done.\n$1"
    },

    jtacSmokeOK = {
        "$1, target marked with $2 smoke, over.",
        "$1, $2 smoke out, standby for visual confirmation.",
        "$1, target marked, $2 smoke on deck.",
        "$1, mark complete, look for $2 smoke north of the road.",
        "$1, $2 smoke is up, call visual when you have it."
    },
    jtacSmokeNoTarget = {
        "$1, no target to mark at this time, over.",
        "$1, negative mark, no target.",
        "$1, no joy on target, unable to mark.",
        "$1, no mark available, stand by for update.",
        "$1, negative smoke, target not established."
    },
    jtacSmokeAlreadyOut = {
        "$1, target already marked, smoke on deck.",
        "$1, mark's up, resmoke already in place, over.",
        "$1, smoke is already out, advise when visual.",
        "$1, you're good, mark is already on the target.",
        "$1, target already marked with smoke."
    },

    pilotNewFriendlyAircraft = {
        "$1 CAP launched from $2, we're heading toward AO.",
        "$1 CAP just wheels-up from $2, we'll will soon be on station.",
        "$1 airborne from $2, we're pushing to cover your AO.",
        "$1 CAP launched from $2, expect blue air in your vicinity shortly.",
        "$1 departed $2, we're setting up CAP near you."
    },
    playerAwacsBogeyDope = { "$1, request bogey dope.", "$1, bogey dope." },
    playerAwacsPicture = { "$1, request picture.", "$1, picture when able.", "$1, need a picture.", "$1, request full picture.", "$1, picture update." },
    playerCommandMissionStatus = {
        "Command, request update on mission status.",
        "Command, request SITREP on current mission status, over.",
        "Command, how's the mission picture? Any updates?",
        "Command, confirm progress on objectives, over.",
        "Command, need an update on situation, what's the status?",
        "Command, mission timeline check, are we on schedule?"
    },
    playerCommandRequireObjectives = {
        "Command, request objective $1 coordinates, over.",
        "Command, send me grid for objective $1.",
        "Command, need objective $1 location, over.",
        "Command, pass coordinates for objective $1.",
        "Command, confirm grid on objective $1."
    },
    playerWingmanEngageBandits = {
        "$1, engage bandits.",
        "$1, you're cleared hot bandits.",
        "$1, commit on bandits when ready.",
        "$1, engage bandits, your discretion.",
        "$1, you're free to engage bandits."
    },
    playerWingmanGoToMarker = {
        "$1, proceed to waypoint.",
        "$1, push to the hold point now.",
        "$1, push to station and hold.",
        "$1, set up in the assigned area.",
        "$1, move to designated steerpoint."
    },
    playerWingmanOrbit = {
        "$1, orbit your position.",
        "$1, set up an orbit.",
        "$1, hold on me.",
        "$1, anchor on my current pos.",
        "$1, orbit overhead"
    },
    playerWingmanRejoin =
    {
        "$1, rejoin my side",
        "$1, push it up, rejoin formation.",
        "$1, come back to route.",
        "$1, tighten it up.",
        "$1, rejoin tactical."
    },
    playerWingmanReportStatus = {
        "$1, confirm you're set.",
        "$1, how are you looking?",
        "$1, report in.",
        "$1, status check.",
        "$1, talk me through your state."
    },
    playerJTACSmoke = {
        "$1, request smoke on objective $2, over.",
        "$1, mark objective $2 with smoke, how copy?",
        "$1, need a smoke mark on objective $2, standby for talk-on.",
        "$1, can you pop smoke on objective $2? Need visual confirmation.",
        "$1, give me a smoke mark near objective $2, confirm when ready.",
    },
}
