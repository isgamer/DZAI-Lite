/*
	DZAI Lite Server Initialization File
	
	Description: Handles startup process for DZAI Lite. Does not contain any values intended for modification.
	
	Last updated: 11:29 PM 6/12/2013
*/
private ["_startTime"];

if (!isServer) exitWith {};

_startTime = diag_tickTime;
diag_log "[DZAI] Initializing DZAI Lite addon. Reading dzai_variables.sqf.";

//Load DZAI variables
call compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\init\dzai_variables.sqf";
call compile preprocessFile "\z\addons\dayz_server\DZAI\SHK_pos\shk_pos_init.sqf";

createcenter east;											//Create centers for all sides
createcenter resistance;
resistance setFriend [east, 1];								//Resistance (AI) is hostile to West (Player), but friendly to East (AI).
resistance setFriend [west, 0];	
EAST setFriend [WEST, 0];									//East (AI) is hostile to West (Player), but friendly to Resistance (AI).
EAST setFriend [resistance, 1];	
WEST setFriend [EAST, 0];									//West (Player side) is hostile to all.
WEST setFriend [resistance, 0];

#include "dzai_functions.sqf"
	
//Load DZAI Lite classname tables.
#include "base_classname_configs\base_classnames.sqf"

//Build DZAI Lite weapon classname tables from CfgBuildingLoot data.
if (DZAI_dynamicWeaponList) then {[DZAI_banAIWeapons] execVM '\z\addons\dayz_server\DZAI\scripts\buildRifleArrays.sqf';};

//Create reference marker for dynamic trigger spawning.
_this = createMarker ["DZAI_centerMarker", (getMarkerPos 'center')];
_this setMarkerType "Empty";
_this setMarkerBrush "Solid";
DZAI_centerMarker = _this;
DZAI_dynTriggerRadius = 600;
DZAI_dynOverlap = 0.1;

private["_worldname"];
_worldname=toLower format ["%1",worldName];

switch (_worldname) do {
	case "chernarus":
	{
		DZAI_centerMarker setMarkerPos [7130.0073, 7826.3501];
		DZAI_centerSize = 5500;
		DZAI_dynTriggersMax = 18;
	};
	case "utes":
	{
		DZAI_centerMarker setMarkerPos [3648.311, 3820.9607];
		DZAI_centerSize = 1000;
		DZAI_dynTriggersMax = 3;
	};
	case "zargabad":
	{
		DZAI_centerMarker setMarkerPos [3998.7087, 4120.4692];
		DZAI_centerSize = 2000;
		DZAI_dynTriggersMax = 6;
	};
	case "fallujah":
	{
		DZAI_centerMarker setMarkerPos [5139.8008, 4092.6797];
		DZAI_centerSize = 4000;
		DZAI_dynTriggersMax = 13;
	};
	case "takistan":
	{
		DZAI_centerMarker setMarkerPos [6368.2764, 6624.2744];
		DZAI_centerSize = 6000;
		DZAI_dynTriggersMax = 19;
	};
    case "tavi":
    {
		DZAI_centerMarker setMarkerPos [10864.419, 11084.657, 1.5322094];
		DZAI_centerSize = 8000;
		DZAI_dynTriggersMax = 19;
    };
	 case "lingor":
    {
		DZAI_centerMarker setMarkerPos [4247.3218, 4689.731];
		DZAI_centerSize = 4000;
		DZAI_dynTriggersMax = 13;
    };
    case "namalsk":
    {
		DZAI_centerMarker setMarkerPos [6051.7534, 8728.8447];
		DZAI_centerSize = 3500;
		DZAI_dynTriggersMax = 7;
    };
    case "mbg_celle2":
    {
		DZAI_centerMarker setMarkerPos [6399.5469, 6583.6987];
		DZAI_centerSize = 6250;
		DZAI_dynTriggersMax = 20;
    };
	case "oring":
    {
		DZAI_centerMarker setMarkerPos [5138.3276, 5535.9248];
		DZAI_centerSize = 4750;
		DZAI_dynTriggersMax = 15;
    };
	case "panthera2":
    {
		DZAI_centerMarker setMarkerPos [5510.7402, 4248.1196];
		DZAI_centerSize = 3250;
		DZAI_dynTriggersMax = 10;
    };
	case "isladuala":
    {
		DZAI_centerMarker setMarkerPos [5133.2119, 5228.4541];
		DZAI_centerSize = 5500;
		DZAI_dynTriggersMax = 18;
    };
	case "sara":
	{
		DZAI_centerMarker setMarkerPos [12011.185, 11251.99, 0.036790848];
		DZAI_centerSize = 6250;
		DZAI_dynTriggersMax = 20;
    };
	case default
	{
		DZAI_centerSize = 7000;
		DZAI_dynTriggersMax = 15;
	};
};

if (DZAI_verifyTables) then {["DZAI_Rifles0","DZAI_Rifles1","DZAI_Rifles2","DZAI_Rifles3","DZAI_BanditTypes"] execVM "\z\addons\dayz_server\DZAI\scripts\verifyTables.sqf";};
if (DZAI_dynTriggersMax > 0) then {[DZAI_dynTriggersMax] execVM '\z\addons\dayz_server\DZAI\scripts\spawnTriggers_random.sqf';};
if (DZAI_monitor) then {[] execVM '\z\addons\dayz_server\DZAI\scripts\dzai_monitor.sqf';};
diag_log format ["[DZAI] DZAI loading completed in %1 seconds.",(diag_tickTime - _startTime)];
