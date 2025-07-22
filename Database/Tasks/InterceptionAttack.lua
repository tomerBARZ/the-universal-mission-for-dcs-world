Library.tasks.interceptionTransport = {
   taskFamily = DCSEx.enums.taskFamily.INTERCEPTION,
   description =
   {
      briefing = {
         "Enemy strike planes are closing on our ground forces. Intercept them before they tear our lines apart.",
         "Hostile attack aircraft are en route to hit our armor columns. Engage and destroy before they reach the battlefield.",
         "Enemy attack wings have crossed into our airspace, targeting supply convoys. Stop them or our front will collapse.",
         "Strike aircraft are inbound to launch precision attacks on our positions. Your mission: intercept and neutralize immediately.",
         "Enemy attack planes are preparing a low-level assault on our troops. Cut them off before they can deliver their payload."
      },
      short = "Intercept enemy attack aircraft",
   },
   conditions = {
      difficultyMinimum = 0,
      eras = {},
   },
   completionEvent = DCSEx.enums.taskEvent.DESTROY,
   flags = { },
   minimumDistance = DCSEx.converter.nmToMeters(10.0),
   safeRadius = 100,
   surfaceType = nil,
   targetCount = { 2, 2 },
   targetFamilies = { DCSEx.enums.unitFamily.PLANE_ATTACK },
   waypointInaccuracy = DCSEx.converter.nmToMeters(6.0)
}
