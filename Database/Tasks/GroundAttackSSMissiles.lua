Library.tasks.groundAttackSSMissiles = {
   taskFamily = DCSEx.enums.taskFamily.GROUND_ATTACK,
   description =
   {
      briefing = {
         "Enemy missile launchers are targeting civilian and military infrastructure. Taking them out will cripple their long-range strike capability.",
         "Mobile TEL units are prepping for launch - this is a time-critical strike to neutralize the threat before missiles are airborne.",
         "Enemy missiles have already caused casualties among allied forces. Eliminating the launchers is essential for force protection.",
         "Destroying enemy missile launchers will degrade enemy morale and disrupt their command structure - it's a high-value tactical win.",
         "Missile launchers are being used to strike nearby towns. Your precision strike today will prevent further suffering and save lives.",
      },
      short = "Destroy enemy SS missiles",
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
   targetFamilies = { DCSEx.enums.unitFamily.GROUND_SS_MISSILE },
   waypointInaccuracy = DCSEx.converter.nmToMeters(2.5)
}
