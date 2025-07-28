Library.tasks.groundAttackAPC = {
   taskFamily = DCSEx.enums.taskFamily.GROUND_ATTACK,
   description =
   {
      briefing = {
         "Enemy APCs are moving to reinforce frontline positions. Neutralizing them now will cripple their mobility and delay their counterattack.",
         "Taking out these APCs disrupts enemy troop deployments and buys our ground forces critical time to consolidate gains.",
         "Enemy armored personnel carriers are transporting infantry toward our exposed flank. Engage immediately to prevent a breakthrough.",
         "Our troops are under pressure. Eliminating those APCs will ease the fight and reduce incoming fire on their position.",
         "Recon confirms high-value targets in the APC convoy, including command elements. Destroying them now will cause significant disruption."
      },
      short = "Destroy enemy APCs",
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
   targetFamilies = { DCSEx.enums.unitFamily.GROUND_APC },
   waypointInaccuracy = DCSEx.converter.nmToMeters(2.5)
}
