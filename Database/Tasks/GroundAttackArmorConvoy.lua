Library.tasks.groundAttackArmorConvoy = {
   taskFamily = DCSEx.enums.taskFamily.GROUND_ATTACK,
   description =
   {
      briefing = {
         "An enemy armor column is moving toward our forward positions. Destroying it now will prevent a breakthrough and protect our ground forces.",
         "An enemy armor column is advancing rapidly toward our main supply route. If we don't stop them here, they'll cut off our logistics.",
         "You are to neutralize a key enemy armored unit before it reaches the battlefield. Hitting them now gives us the upper hand in the coming engagement.",
         "An armor column is heading toward a populated area. Eliminate the threat before it reaches the city and endangers civilians.",
         "This enemy armor column is the primary threat to our flank. Striking them now will stopp them from rolling through our defenses.",
      },
      short = "Destroy enemy armor column",
   },
   conditions = {
      difficultyMinimum = 0,
      eras = {},
   },
   completionEvent = DCSEx.enums.taskEvent.DESTROY,
   flags = { DCSEx.enums.taskFlag.ALLOW_JTAC, DCSEx.enums.taskFlag.MOVING, DCSEx.enums.taskFlag.ON_ROADS },
   minimumDistance = DCSEx.converter.nmToMeters(10.0),
   safeRadius = 100,
   surfaceType = land.SurfaceType.LAND,
   targetCount = { 3, 4 },
   targetFamilies = { DCSEx.enums.unitFamily.GROUND_APC, DCSEx.enums.unitFamily.GROUND_APC, DCSEx.enums.unitFamily.GROUND_MBT },
   waypointInaccuracy = DCSEx.converter.nmToMeters(2.5)
}
