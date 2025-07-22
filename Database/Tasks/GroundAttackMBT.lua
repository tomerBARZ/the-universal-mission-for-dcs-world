Library.tasks.groundAttackMBT = {
   taskFamily = DCSEx.enums.taskFamily.GROUND_ATTACK,
   description =
   {
      briefing = {
         "Enemy armor is advancing on our front lines. Neutralizing these tanks is critical to halting their momentum.",
         "Intel confirms enemy tanks are threatening a key supply route. Strike now to preserve our logistics corridor.",
         "Enemy tanks are the last major obstacle before our ground forces can break through. Hit them hard and clear the way.",
         "An enemy armor column was spotted nearby. Eliminate it before they regroup and launch a counterattack.",
         "Enemy tanks are guarding a location vital to the enemy's retreat. Destroy them to trap their forces and cut off escape."
      },
      short = "Destroy enemy MBTs",
   },
   conditions = {
      difficultyMinimum = 0,
      eras = {},
   },
   completionEvent = DCSEx.enums.taskEvent.DESTROY,
   flags = { DCSEx.enums.taskFlag.ALLOW_JTAC },
   minimumDistance = DCSEx.converter.nmToMeters(10.0),
   safeRadius = 100,
   surfaceType = land.SurfaceType.LAND,
   targetCount = { 2, 4 },
   targetFamilies = { DCSEx.enums.unitFamily.GROUND_MBT },
   waypointInaccuracy = DCSEx.converter.nmToMeters(2.5)
}
