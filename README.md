DZAI Lite 0.1.1 - AI Addon for DayZ
============


Introduction
============

DZAI Lite is a simplified version of the DZAI addon (https://github.com/dayzai/DayZBanditAI) that retains the dynamic spawn trigger system while removing all static triggers and any unnecessary functions.

Summary of simplifications made in DZAI Lite:

- AI do not carry any "extra" equipment (ie: pistols, consumable items). AI units will only carry a primary weapon, single magazine, and possibly Binoculars or NVGs.
- No extra configuration files used for each map - DZAI Lite uses a single universal config file. To ensure compatibility with all maps, the classname verification option has been enabled by default.
- No static AI spawns - gameplay in cities and towns is mostly uninterrupted by AI.
- Heavily reduced file size (DZAI: 440KB vs DZAI Lite: 75KB approx.)
- Less settings to manually configure, many settings are automatically handled. Simply install and run.

Features
============

- Installed to your server's dayz_server.pbo - nothing is downloaded or run on clients.
- Automatically builds a list of weapons that AI can use by reading DayZ's CfgBuildingLoot. This means that AI units may carry any lootable weapon.
- AI spawning is completely dynamic and automatically generated - there is no need to manually add spawn points.
- AI spawn points with no players nearby will periodically relocate themselves around the map area, so there is no predicting where AI will show up next.
- The number of AI spawned is dependent on the number of players within the trigger area, so the difficulty is self-adjusting. The more populated the area is, the more AI that will spawn in. (Minimum of 2±1 to a maximum of 6±1)
- The AI despawn when there are no players in the area, or some time after they are killed.

Installation Instructions:
============

- Unpack your <b>dayz_server.pbo</b>
- Copy the new DZAI folder inside your unpacked dayz_server folder. (You should also see config.cpp in the same level.)
- Edit your <b>server_monitor.sqf</b>. It is located within \dayz_server\system. 
- Locate the line that reads: <code>waituntil{isNil "sm_done"}; // prevent server_monitor be called twice (bug during login of the first player)</code> (located near line 200). If this line can't be located, find the one that reads: <code>// # END OF STREAMING #</code> (Located near line 174).
- Underneath this line, insert the following (If reading this in a text editor, ignore the code tags!): <code>call compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\init\dzai_initserver.sqf";</code>. Refer to the provided example server_monitor.sqf (named server_monitor_example.sqf)
- Repack your dayz_server.pbo (it should be about 400KB larger).
- You are now ready to start your server.

Note: DZAI Lite's settings file can be found in DZAI\init\dzai_variables.sqf

Troubleshooting Instructions:
============

DZAI Lite is designed with maximum compatibility in mind, but unforseen problems may occur.

Q1: How can I check if DZAI Lite is generating AI spawn points, or verify that AI are properly spawning?

A1: Open dzai_variables.sqf - it is located in \DZAI\init. Set DZAI_debugMarkers to 1. In your ingame map, you will see circular markers indicating the trigger areas. If you enter these trigger areas, the circular marker will change from yellow to orange to show that the trigger is active. Small red dots will indicate positions of AI units, and blue dots will indicate their waypoints. Setting DZAI_debugLevel to 1 or 2 will also allow DZAI to output relevant details into your RPT log.


Q2: The AI aren't carrying any weapons!

A2: This may happen if the DayZ mod uses non-standard names for their loot tables, or if DayZ's loot table structure has changed. In this case, set DZAI_dynamicWeaponList to false to have DZAI use backup weapon lists instead. Also, make sure you set DZAI_verifyTables to true to ensure all classnames are compatible with your DayZ mod.


Q3: A new DayZ map has been released, will DZAI Lite support it?

A3: DZAI reads DayZ's loot tables to find weapon classnames, followed by a verification procedure to make sure they are not banned or invalid. This method allows DZAI to adapt itself to any DayZ map. 
	DZAI will also use DayZ's 'center' marker as a reference point to generate dynamic triggers to spawn AI if an unrecognized map is used.

Latest Updates:
============

0.0.1 (Initial release):

- Initial release of DZAI Lite based on DZAI version 0.9.5
- Changes in equipType/weapongrade tiered system are planned.

0.0.2 update:

- [FIXED] Debug markers for patrol waypoints are now properly removed when AI units are despawned.
- [FIXED] Dynamic triggers no longer remain active due to player presence if all AI units in the area have been killed. Despawn process is forced 2 minutes after the last AI unit in the area is killed.
- [REMOVED] Removed fn_getGradeChances.sqf with the removal of the equipType classification system.
- [MODIFIED] DZAI_gradeChances0-3 tables have been simplified into a single DZAI_gradeChances table.

0.0.3 update:

- [NEW] Number of AI spawned per trigger is now dependent on the number of players present in the trigger instead of being configured. (minimum of 2 to maximum of 6, +/- 1)
- [REMOVED] AI no longer carry backpacks.
- [MODIFIED] Lowered chance of generating NVGs in high tier tools table from 25% to 20%.
- [MODIFIED] Dynamic trigger activation timings changed from 5/7/10 seconds to 5/10/15 seconds.

0.0.4 update:

- [FIXED] Removed all remaining variables relating to minimum/additional AI to spawn for dynamic triggers.
- [REMOVED] Dynamic trigger spawning script no longer avoids player positions.
- [MODIFIED] Chernarus: adjusted spawning range of dynamic triggers from 5250m to 6000m. Increased number of dynamic triggers from 20 to 22.
- [MODIFIED] Spawning range of AI from dynamic triggers increased from 125m (+125m max) to 125m (+175m max).
- [MODIFIED] Dynamic trigger activation timings changed from 5/10/15 seconds to 5/10/30 seconds.

0.0.5 update:

- [NEW] Debug markers: Added color-coding for activation state of dynamic triggers. Yellow (Ready Trigger), Green (Awaiting Despawn), Orange (Activated Trigger).
- [NEW] Dynamic triggers now relocate to center around a random player in the trigger area when activated. (Prevents player from quickly leaving the trigger area after entering).
- [MODIFIED] Addition of glanceAt command for AI group leader to help locate player unit.
- [MODIFIED] Modification of dynamic trigger amounts for each map.
- [MODIFIED] Time delay in between each dynamic trigger spawn reduced from 20 seconds to 5 seconds.

0.0.6 update:

- [NEW] Added Dynamic Trigger Mananger to periodically randomize the locations of inactive dynamic triggers. (Default interval: 5 minutes, Relocation probability: 75%).
- [FIXED] Dynamic AI are now properly deleted after death.
- [MODIFIED] fnc_deleteVictim renamed to fnc_updateDead.
- [MODIFIED] Lowered probabilities of generating MilitarySpecial and HeliCrash weapons for AI.
- [MODIFIED] Increased visibility of debug marker for trigger areas marked for despawning.

0.0.7 update:

- [NEW] DZAI now dynamically generates weapon classname tables instead of reading them from a config file. This should greatly improve DZAI's compatibility with all current/future DayZ mods. <b>NOTE</b>: By default, AI may carry any lootable weapon. To "ban" specific weapons from DZAI classname tables, add them to DZAI_banAIWeapons in dzai_variables.sqf. For example, to ban the M107 and AS50: DZAI_banAIWeapons = ["M107_DZ","BAF_AS50_scoped"];
- [FIXED] Fixed undefined variable error in despawning script for dynamic triggers.
- [MODIFIED] Lowered probability of generating NVGs for AI with weapongrade 2-3 from 20% to 15%. 	

0.0.8 update:

- [NEW] Added option to switch between dynamic weapon list generation and preset list for generating AI weapons. By default, dynamic list generation is enabled. Dynamic generation ensures compatibility with all DayZ mods but slightly delays loading of DZAI at server start. Using the preset list is faster, but problems may arise from incompatible classnames.
- [MODIFIED] Re-added preset weapon classname list using weapons from standard DayZ 1.7.6.1.

0.0.9 update:

- [MODIFIED] Dynamic triggers only relocate to a random nearby player's position on activation if the player is not over water (to avoid having a trigger move on top of water). Otherwise, the trigger's position is used as the reference point.
- [MODIFIED] Adjusted spawning distance of dynamic triggers for almost all maps, along with adjustments to spawn amounts to match.
- [MODIFIED] DZAI no longer reads from Supermarket loot tables to collect weapon data since most entries are shared with Residential. This will slightly reduce the amount of time required to collect data.
- [MODIFIED] On startup, debug data now also reports whether or not dynamic weapon list generation is enabled.

0.0.9.1 hotfix (DayZ 1.7.7 compatibility):

- [FIXED] Added fixes to dynamic weapon list feature to ensure compatibility with DayZ 1.7.7 as well as previous versions.

0.0.9.2 hotfix (DayZ 1.7.7 compatibility):

- [FIXED] Implemented additional compatibility fixes to dynamic weapon list feature.
- [NEW] Namalsk: Added compatibility with Namalsk's selectable loot table feature. DZAI will read from the user-specified loot table instead of the default. 
- [MODIFIED] Namalsk: DZAI will now also read from the HeliCrashNamalsk table instead of HeliCrash.
- [MODIFIED] Added MeleeBaseBallBat and MeleeMachete to AI weapon banlist.
- [MODIFIED] User-specified weapon banlist is now added to the default weapon banlist, instead of the other way around.

0.1.0 Update:

- [NEW] Execution time is now reported into RPT log for DZAI initialization, dynamic weapon list generation, and classname verification.
- [NEW] Overlapping activated dynamic triggers now spawn a reduced number of AI units.
- [REMOVED] Removed M107 and AS50 from preset weapon classname table.
- [MODIFIED] Server no longer waits for DZAI to finish initializing before continuing startup process.
- [MODIFIED] Dynamic triggers are generated only after dynamic weapon list and classname verification (if enabled) are completed. This avoids possible cases where AI spawn with invalid items before the weapon list and verification steps are completed.
- [MODIFIED] AI units will now always spawn in an "AWARE" state. When a member if an AI group is killed, the group's state is changed to "COMBAT". When all members of the group have been killed, the group's state will return to "AWARE" with the first respawning unit.
- [MODIFIED] AI units will no longer move with "LIMITED" speed. Possible movement modes are "NORMAL" (move in formation) or "FULL" (move without regard to maintaining formation).
- [MODIFIED] Building positions are now calculated directly instead of using interior positions (less complicated calculations).
- [MODIFIED] AI skill parameters are now more consistent for each weapongrade value. Base values increased, bonus values decreased.
- [MODIFIED] Frequency of dynamic trigger manager script increased to every 3 minutes from 5 minutes.
- [MODIFIED] Increased probabilities of randomizing dynamic trigger location and activation chance.
- [MODIFIED] Delay between each dynamic trigger spawn now fixed at 5 seconds.
- [MODIFIED] Increased probability of generating Military-grade weapons for dynamic AI.

0.1.1 Update:

- [FIXED] Fixed error in dynamic trigger area overlap detection.
- [NEW] Injured AI units now slowly heal themselves in 5% increments.
- [NEW] Dynamic trigger area overlap for dynamic triggers now limited to 10% area overlap (Up to 3 locations are generated per trigger to help ensure that no two triggers overlap).
- [MODIFIED] Dynamic trigger activation timings changed to 5/7/20 seconds from 5/10/30 seconds.

0.1.2 Update:

- [NEW] Dynamic AI now spawn in a "Pursuit" state where they follow the randomly-selected player for a distance of 100m from (calculated from the player's position at time of trigger activation). Player's position is updated every 30 seconds.
- [MODIFIED] Updated preset default weapon tables to DayZ 1.7.7.1 version.
- [MODIFIED] Dynamic triggers now despawn after 120 seconds if all players have left the trigger area, or after 300 seconds after all spawned AI units have been killed (previously, timer was 120 seconds for both conditions).
- [MODIFIED] Dynamic trigger intersection warnings now appear in the RPT log if DZAI_debugLevel is set to 1 or higher. (Note: After 3 attempts, triggers are placed on the map regardless of whether or not there is overlapping with other triggers).
- [MODIFIED] Chernarus: dynamic trigger area reduced from 6000m radius to 5500m, max. triggers reduced to 18 from 19, and trigger moved slightly NW to avoid coastal areas.
- [MODIFIED] Increased rate of healing for injured AI from 5% health/15 seconds to 10% health/15 seconds. (rate determined by DZAI_refreshRate)
- [MODIFIED] findKiller feature: Chase distance decreased to 400-600m from 500-700m. Time limit is unchanged.
- [MODIFIED] findKiller feature: AI will not pursue players in vehicles, and will exit pursuit state if player enters a vehicle (since AI do not use vehicles).
- [MODIFIED] findKiller feature: Player's position is now updated every 15 seconds.
- [MODIFIED] AI units revert to an "AWARE" state from "COMBAT" after pursuit state ends if DZAI_findKiller is enabled. If not enabled, AI will remain in "COMBAT" mode until the entire group is killed (this is intended).
- [MODIFIED] Updated preset default classname tables to DayZ 1.7.7.1 version.
- [MODIFIED] Dynamic triggers no longer activate for players in Air vehicles. Note: Trigger will activate if players exit the air vehicle, but will not deactivate if players re-enter. AI stop actively tracking targeted player's position but will continue to the last known position.
- [MODIFIED] Dynamic triggers now despawn after 120 seconds if all players have left the trigger area, or after 300 seconds after all spawned AI units have been killed (previously, timer was 120 seconds for both conditions).
- [MODIFIED] Dynamic trigger intersection warnings now appear in the RPT log if DZAI_debugLevel is set to 1 or higher. (Note: After 3 attempts, triggers are placed on the map regardless of whether or not there is overlapping with other triggers).
- [MODIFIED] Chernarus: dynamic trigger area reduced from 6000m radius to 5500m, max. triggers reduced to 15 from 16, and trigger moved slightly NW to avoid coastal areas.
- [MODIFIED] Large AI skill parameter increases for AI. Highest-skilled AI may now potentially reach maximum skill levels for all skills except Accuracy and AimingShake.
