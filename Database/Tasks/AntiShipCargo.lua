Library.tasks.antishipCargo = {
   taskFamily = DCSEx.enums.taskFamily.ANTISHIP,
   description =
   {
      briefing = {
         "Enemy cargo ships are delivering weapons and supplies to frontline units. Sinking them will disrupt their logistics and slow their advance.",
         "Cargo ships are moving fuel, ammo, and enemy reinforcements. Take them out to choke the enemy's front-line operations.",
         "Intel confirms that enemy cargo ships are carrying weapons and reinforcements. They should be destroyed immediately.",
         "Reconnaissance confirms that enemy cargo vessels are transporting materiel vital to the enemy's continued resistance. Interdiction is required.",
         "Logistical interdiction remains a top priority. A group of enemy cargo ships must be destroyed to limit their strategic reach."
      },
      short = "Sink enemy cargo ships",
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
   targetCount = { 2, 2 },
   targetFamilies = { DCSEx.enums.unitFamily.SHIP_CARGO },
   waypointInaccuracy = DCSEx.converter.nmToMeters(5.0)
}
