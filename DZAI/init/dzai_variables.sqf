/*
	DZAI Lite Variables File
	
	Description: Contains all configurable settings of DZAI. Contains settings for debugging, customization of AI units, spawning, and loot.
	
	Last updated: 1:32 AM 6/29/2013
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
DZAI_verifyTables = true;									//Set 'true' to have DZAI check all classname tables for banned or invalid classnames. (Default: true)

//AI Unit Variables						
DZAI_dmgFactors1 =[1.0,1.0,1.0,1.0,1.0];					//Multipliers for bullet-type damage done to different body parts of AI units: Structural, Head, Body, Hands, Legs. Example: to make AI take 50% reduced damage to a body part, set the appropriate value to 0.50.
DZAI_dmgFactors2 =[1.0,1.0,1.0,1.0,1.0];					//Multipliers for non-bullet-type (ie: explosions, collisions) damage done to different body parts: Structural, Head, Body, Hands, Legs.
DZAI_refreshRate = 15;										//Amount of time in seconds between AI ammo and zombie check. (Default: 15)
DZAI_zDetectRange = 200;									//Maximum distance for AI to detect zombies. (Default: 200)

//Dynamic Trigger Settings - DZAI automatically determines the settings for dynamic triggers. Below are settings that can be manually adjusted.
DZAI_dynManagerRate = 900;									//Frequency of dynamic trigger manager in seconds. The manager periodically relocates a percentage of inactive dynamic triggers (Default: 900)
DZAI_dynRemoveDeadWait = 300;								//Time to wait before deleting dead AI corpses. Timer starts when all units in a group have been killed.(Default: 300)
DZAI_dynDespawnWait = 120;									//Time to allow AI to remain in seconds before being removed when all players have left a trigger area. (Default: 120)

//Extra AI Settings
DZAI_findKiller = false;									//If enabled, AI group will attempt to track down player responsible for killing a group member. Players with radios will be given text warnings if they are being pursued (Default: false).
DZAI_tempNVGs = false;										//If normal probability check for spawning NVGs fails, then give AI temporary NVGs only if they are spawned with weapongrade 2 or 3. Temporary NVGs are unlootable and will be removed at death (Default: false).

//AI weapon configuration
DZAI_dynamicWeaponList = true;								//True: Dynamically generate AI weapon list from CfgBuildingLoot. False: Use preset weapon list (DayZ 1.7.6.1). Highly recommended to enable DZAI_verifyTables if this option is set to false. (Default: true).
DZAI_banAIWeapons = [];										//(Only if DZAI_dynamicWeaponList = true) List of weapons that AI should never use. By default, AI may carry any lootable weapon. Example: DZAI_banAIWeapons = ["M107_DZ","BAF_AS50_scoped"]; will remove the M107 and AS50 from AI weapon tables  if dynamic weapon list is enabled.

//AI loot probabilities
DZAI_gradeChancesDyn = [0.30,0.60,0.08,0.02];				//Probabilities of generating each weapongrade (0,1,2,3). 0: Civilian, 1: Military, 2: MilitarySpecial, 3: Heli Crash. Weapon grade also influences the general skill level of the AI unit.

//NOTHING TO EDIT BEYOND THIS POINT.

//Internal Use Variables: DO NOT EDIT THESE
DZAI_weaponGrades = [0,1,2,3];								//All possible weapon grades. A "weapon grade" is a tiered classification of gear. 
DZAI_numAIUnits = 0;										//Keep track of currently active AI units, including dead units waiting for respawn.
DZAI_actDynTrigs = 0;										//Keep track of current number of active dynamically-spawned triggers
DZAI_curDynTrigs = 0;										//Keep track of current total of inactive dynamically-spawned triggers.
DZAI_actTrigs = 0;											//Keep track of active static triggers.	
DZAI_dynTriggerArray = [];									//List of current dynamic triggers.		

if (DZAI_debugLevel > 0) then {diag_log format["[DZAI] DZAI Variables loaded. Debug Level: %1. DebugMarkers: %2. DZAI_dynamicWeaponList: %3. VerifyTables: %4.",DZAI_debugLevel,DZAI_debugMarkers,DZAI_dynamicWeaponList,DZAI_verifyTables];};
