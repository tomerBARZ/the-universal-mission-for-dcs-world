Library.tasks.groundAttackArtillery = {
   taskFamily = DCSEx.enums.taskFamily.GROUND_ATTACK,
   description =
   {
      briefing = {
         "Enemy artillery is shelling our forward positions and delaying our advance. Take them out to clear the way for ground troops.",
         "Enemy artillery is hammering our lines and must be silenced immediately. Hit them hard—our soldiers are counting on it.",
         "A group of artillery batteries is a key part of the enemy's defensive network. Neutralizing it will open a gap in their lines.",
         "Our forces are pinned down by enemy artillery and taking losses. Eliminating the artillery threat will save lives and keep the momentum on our side.",
         "High command has prioritized the destruction of enemy artillery to enable a broader offensive. This objective is critical."
      },
      short = "Destroy enemy artillery",
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
   targetCount = { 3, 4 },
   targetFamilies = { DCSEx.enums.unitFamily.GROUND_ARTILLERY },
   waypointInaccuracy = DCSEx.converter.nmToMeters(2.5)
}
