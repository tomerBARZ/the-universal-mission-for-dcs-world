Library.tasks.strikeScenery = {
   taskFamily = DCSEx.enums.taskFamily.STRIKE,
   description =
   {
      briefing = {
         "A civilian building is being used as an enemy command post. Take it out before they coordinate another strike.",
         "Intel confirms hostile forces are operating from inside a civilian structure. Neutralize it to stop further attacks.",
         "A civilian building has been repurposed as a weapons cache. Destroy it before those arms hit the front lines.",
         "Enemy anti-air control is housed in a civilian facility. Eliminate it to open the skies for our forces.",
         "Recon shows a civilian structure is shielding enemy leadership. Bringing it down cripples their chain of command."
      },
      short = "Destroy occupied building",
   },
   conditions = {
      difficultyMinimum = 0,
      eras = {},
   },
   completionEvent = DCSEx.enums.taskEvent.DESTROY,
   flags = { DCSEx.enums.taskFlag.ALLOW_JTAC, DCSEx.enums.taskFlag.SCENERY_TARGET },
   minimumDistance = DCSEx.converter.nmToMeters(10.0),
   safeRadius = 100,
   surfaceType = land.SurfaceType.LAND,
   targetCount = { 1, 1 },
   targetFamilies = { DCSEx.enums.unitFamily.STATIC_SCENERY },
   waypointInaccuracy = 0.0
}
