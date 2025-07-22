Library.tasks.interceptionTransport = {
   taskFamily = DCSEx.enums.taskFamily.INTERCEPTION,
   description =
   {
      briefing = {
         "Enemy transport is inbound with troops and supplies. Stop it before it reinforces their front line.",
         "Hostile cargo aircraft is carrying critical equipment to enemy forces. Intercept and destroy before delivery.",
         "Enemy transport plane detected. Intel suggests it's moving high-value assets. Do not let it reach its destination.",
         "Transport aircraft is ferrying reinforcements across the border. Interception is the only way to halt their buildup.",
         "Enemy logistics bird is airborne. Taking it out cripples their supply chain. Engage immediately."
      },
      short = "Intercept enemy transport aircraft",
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
   targetFamilies = { DCSEx.enums.unitFamily.PLANE_TRANSPORT },
   waypointInaccuracy = DCSEx.converter.nmToMeters(8.0)
}
