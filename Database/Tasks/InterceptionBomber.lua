Library.tasks.interceptionBomber = {
   taskFamily = DCSEx.enums.taskFamily.INTERCEPTION,
   description =
   {
      briefing = {
         "Enemy bomber inbound. If it reaches its target, thousands of civilians are at risk. You're the last line to stop it before it crosses the border.",
         "Intel confirms a hostile bomber on approach to critical infrastructure. Your mission: intercept and neutralize before it gets within strike range.",
         "An enemy bomber is carrying high-yield ordnance toward a populated zone. Failure to intercept means catastrophic loss. Scramble now.",
         "Hostile bomber detected on vector to our forward base. Engage immediately; do not allow it to release payload.",
         "Enemy bomber is on a direct course for our command center. Intercept at all costs. Success ensures the survival of our forces."
      },
      short = "Intercept enemy bomber",
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
   targetCount = { 1, 1 },
   targetFamilies = { DCSEx.enums.unitFamily.PLANE_BOMBER },
   waypointInaccuracy = DCSEx.converter.nmToMeters(8.0)
}
