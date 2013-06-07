/*
	DZAI Lite Variables File
	
	Description: Contains all configurable settings of DZAI. Contains settings for debugging, customization of AI units, spawning, and loot.
	
	Last updated: 5:56 PM 6/6/2013
*/
private["_worldname"];

if (!isServer) exitWith {};

//Zombie Hostility
DZAI_zombieEnemy = true;									//Enable or disable AI hostility to zombies. If enabled, AI will attack zombies. (default: true)

//DZAI Settings
DZAI_debugLevel = 0;										//Enable or disable event logging to arma2oaserver.rpt. Debug level setting. 0: Off, 1: Basic Debug, 2: Extended Debug. (Default: 0)
DZAI_debugMarkers = 0;										//Enable or disable debug markers. Track AI position, locate patrol waypoints, locate dynamically-spawned triggers. (Default: 0)
DZAI_monitor = true;										//Enable or disable server monitor. Keeps track of number of max/current AI units and dynamically spawned triggers. (Default: true)
DZAI_monitorRate = 180;										//Frequency of server monitor update to RPT log in seconds. (Default: 180)								
DZAI_verifyTables = true;									//Enable verification of standard DZAI classname tables. Since DZAI Lite does not configure its classname tables depending on the detected map, it is recommended to leave this option 'true'. (Default: true)

//AI Unit Variables						
DZAI_dmgFactors1 =[1.0,1.0,1.0,1.0,1.0];					//Multipliers for bullet-type damage done to different body parts of AI units: Structural, Head, Body, Hands, Legs. Example: to make AI take 50% reduced damage to a body part, set the appropriate value to 0.50.
DZAI_dmgFactors2 =[1.0,1.0,1.0,1.0,1.0];					//Multipliers for non-bullet-type (ie: explosions, collisions) damage done to different body parts: Structural, Head, Body, Hands, Legs.
DZAI_refreshRate = 15;										//Amount of time in seconds between AI ammo and zombie check. (Default: 15)
DZAI_zDetectRange = 200;									//Maximum distance for AI to detect zombies. (Default: 200)

//AI Spawning Variables
DZAI_maxAIUnits = 65535;									//Limit of total AI spawned by DZAI (0: Disables AI spawning completely)
DZAI_delDeadTime = 300;										//Time to allow AI corpse to remain (in seconds) before deleting it.
DZAI_despawnWait = 120;										//Time to allow AI to remain in seconds before being removed when all players have left a trigger area. (Default: 120)

//Dynamic Trigger Settings
//DZAI automatically determines the settings for dynamic triggers. To manually change a value, replace "auto" with a value for the setting.
DZAI_dynSpawnDelay = 20;									//Time to wait between creating each randomly-placed trigger (seconds). (Default: 20)
DZAI_dynEquipType = 2;										//Equipment Type of randomly-spawned AI. (Value Range: 0-3). 0: Lowest grade weaponry. 3: Highest grade weaponry. (Default: 2)
DZAI_dynAIMin = 2;											//Minimum number of AI to spawn per randomly-spawned trigger.  (Default: 2)
DZAI_dynAIAdd = 3;											//Maximum number of additional AI to spawn per randomly-spawned trigger.	(Maximum Total AI/Trigger =  DZAI_dynAIMin + (0 to DZAI_dynAIAdd))  (Default: 3)

//Extra AI Settings
DZAI_findKiller = false;									//Enable AI to become aware of who killed an AI group member. If alive, AI group leader will investigate last known position of killer. Players with radios are able to evade detection (Default: false)
DZAI_tempNVGs = false;										//If normal probability check for spawning NVGs fails, then give AI temporary NVGs only if they are spawned with weapongrade 2 or 3. Temporary NVGs are unlootable and will be removed at death (Default: false).

//AI loot Configuration										(Edible and Medical items, Miscellaneous items, Skin packs)
DZAI_weaponGrades = [0,1,2,3];								//All possible weapon grades. A "weapon grade" is a tiered classification of gear. 0: Civilian, 1: Military, 2: MilitarySpecial, 3: Heli Crash. Weapon grade also influences the general skill level of the AI unit.
DZAI_gradeChances0 = [0.85,0.15,0.00,0.00];					//equipType = 0 - most AI will have basic pistols or rifles, and occasionally common military weapons.
DZAI_gradeChances1 = [0.55,0.40,0.04,0.01];					//equipType = 1 - most AI will have common rifles, many will have common military weapons. Very rarely, AI will spawn with high-grade military or helicrash weapons.
DZAI_gradeChances2 = [0.30,0.55,0.11,0.04];					//equipType = 2 - most AI carry military weapons, and occasionally high-grade military weapons.
DZAI_gradeChances3 = [0.00,0.60,0.33,0.07];					//equipType = 3 - All AI will carry at least a military-grade weapon. Many will be carrying high-grade military weapons.

//NOTHING TO EDIT BEYOND THIS POINT.

//Internal Use Variables: DO NOT EDIT THESE
DZAI_numAIUnits = 0;										//Keep track of currently active AI units, including dead units waiting for respawn.
DZAI_actDynTrigs = 0;										//Keep track of current number of active dynamically-spawned triggers
DZAI_curDynTrigs = 0;										//Keep track of current total of inactive dynamically-spawned triggers.
DZAI_actTrigs = 0;											//Keep track of active static triggers.			

if (DZAI_debugLevel > 0) then {diag_log format["[DZAI] DZAI Variables loaded. Debug Level: %1. DebugMarkers: %2. VerifyTables: %3.",DZAI_debugLevel,DZAI_debugMarkers,DZAI_verifyTables];};