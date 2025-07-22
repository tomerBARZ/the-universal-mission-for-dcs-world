Library.tasks.antiShipCorvette = {
   taskFamily = DCSEx.enums.taskFamily.ANTISHIP,
   description =
   {
      briefing = {
         "An enemy missile boat was detected within strike range of our troops. Neutralize it before it can launch.",
         "An enemy missile boat has entered our waters. You are authorized to engage and neutralize.",
         "An enemy corvette is operating within weapons release range of our task force. Its engagement is necessary to preempt an attack.",
         "An hostile craft possesses the capability to strike high-value naval assets. Its destruction is imperative to ensure fleet security.",
         "The target is a missile-equipped enemy vessel posing a direct threat to allied maritime operations. It must be destroyed at once."
      },
      short = "Sink enemy missile boat",
   },
   conditions = {
      difficultyMinimum = 0,
      eras = {},
   },
   completionEvent = DCSEx.enums.taskEvent.DESTROY,
   flags = { },
   minimumDistance = DCSEx.converter.nmToMeters(10.0),
   safeRadius = 0,
   surfaceType = land.SurfaceType.WATER,
   targetCount = { 1, 1 },
   targetFamilies = { DCSEx.enums.unitFamily.SHIP_MISSILE_BOAT },
   waypointInaccuracy = DCSEx.converter.nmToMeters(5.0)
}
