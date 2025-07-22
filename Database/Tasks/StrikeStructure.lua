Library.tasks.strikeStructure = {
   taskFamily = DCSEx.enums.taskFamily.STRIKE,
   description =
   {
      briefing = {
        "Target structure is critical to enemy operations. Destroy it to cripple their plans.",
        "That installation is a key asset. Eliminating it will shift the battle in our favor.",
        "High-value structure confirmed in the target zone. Neutralize it before the enemy can react.",
        "The objective is essential to enemy logistics. Take it out immediately.",
        "Command wants that site erased. Its loss will deal a severe blow to enemy capability.",
        "Structure identified as a primary objective. Destroy it and deny enemy use.",
        "This is a priority strike target. Removing it will disrupt enemy momentum."
      },
      short = "Destroy enemy structure",
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
   targetCount = { 1, 1 },
   targetFamilies = { DCSEx.enums.unitFamily.STATIC_STRUCTURE },
   waypointInaccuracy = 0.0
}
