Library.tasks.seadMedium = {
   taskFamily = DCSEx.enums.taskFamily.SEAD,
   description =
   {
      briefing = {
         "Engagement of this enemy SAM site is essential to mitigate threats to our aircraft and maintain air superiority in the operational theater.",
         "Neutralizing this hostile surface-to-air missile installation will significantly reduce risks to our flight operations and support ongoing ground maneuvers.",
         "The elimination of this SAM site is imperative to ensure safe ingress and egress corridors for our air assets during the mission.",
         "Suppressing this SAM site is a strategic priority to safeguard our air operations and maintain operational momentum.",
         "This SAM installation represents a critical threat vector that must be neutralized to protect both aircrew and mission integrity.",
         "Striking this enemy SAM site will preserve the freedom of maneuver necessary for successful execution of subsequent air operations.",
         "Destroying this SAM site is vital to maintaining the tactical advantage and ensuring force protection throughout the engagement area.",
         "The removal of this hostile SAM site is a prerequisite for sustained air dominance and mission accomplishment."
      },
      short = "Destroy enemy SAM site",
   },
   conditions = {
      difficultyMinimum = 0,
      eras = {},
   },
   completionEvent = DCSEx.enums.taskEvent.DESTROY,
   flags = { DCSEx.enums.taskFlag.DESTROY_TRACK_RADARS_ONLY },
   minimumDistance = DCSEx.converter.nmToMeters(40.0),
   safeRadius = 250,
   surfaceType = land.SurfaceType.LAND,
   targetCount = { 1, 1 },
   targetFamilies = { DCSEx.enums.unitFamily.AIRDEFENSE_SAM_MEDIUM },
   waypointInaccuracy = 0.0
}
