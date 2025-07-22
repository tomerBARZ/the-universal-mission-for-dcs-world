Library.tasks.groundAttackTrucksConvoy = {
   taskFamily = DCSEx.enums.taskFamily.GROUND_ATTACK,
   description =
   {
      briefing = {
         "Intelligence confirms that an enemy convoy is transporting essential logistical supplies. Engaging this target is critical to degrading their operational capabilities.",
         "The designated convoy represents a significant threat to our frontline forces by sustaining enemy combat effectiveness; its neutralization is a priority.",
         "An enemy convoy is facilitating the movement of vital materiel. A successful strike will disrupt their supply chain and impede their operational tempo.",
         "The targeted convoy plays a pivotal role in enemy logistics. Effectively striking this formation will significantly impair their combat readiness.",
         "A convoy of enemy trucks is integral to enemy sustainment efforts. Your strike will contribute significantly to operational success."
      },
      short = "Destroy enemy truck convoy",
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
   targetFamilies = { DCSEx.enums.unitFamily.GROUND_UNARMED },
   waypointInaccuracy = DCSEx.converter.nmToMeters(2.5)
}
