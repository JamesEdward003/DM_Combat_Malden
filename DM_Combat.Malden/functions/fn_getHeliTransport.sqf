////////   _null = [_caller] execVM "fn_getHeliTransport.sqf";    ///////////
private ["_caller","_position","_target","_is3D","_id","_pos","_location","_mrkr"];
params ["_caller","_position","_target","_is3D","_id"];
_caller = _this select 0;
_position = _this select 1; // = screenToWorld [0.5,0.5];

_searchRadius 		= 100;
_friendlySide 		= side _caller;
_neutralSide 		= CIVILIAN;
_sideUnit 			= side _caller;
_sourcePoint 		= _caller;
_randDir 			= getDir vehicle _sourcePoint - 180;
_randDist 			= (random 100) + 1000;
_airStart 			= [(getPos vehicle _sourcePoint select 0) + (_randDist * sin(_randDir)), (getPos vehicle _sourcePoint select 1) + (_randDist * cos(_randDir)), 100];
_randDir2 			= getDir vehicle _sourcePoint;
_airEnd 			= [(getPos vehicle _sourcePoint select 0) + (_randDist * sin(_randDir2)), (getPos vehicle _sourcePoint select 1) + (_randDist * cos(_randDir2)), 60];
//_airTypes 		= B_Heli_Light_01_F // B_Heli_Light_01_stripped_F // B_Heli_Transport_01_F // B_Heli_Transport_01_camo_F ////DLC > B_Heli_Transport_03_F // B_Heli_Transport_03_unarmed_F
//_airTypes			= O_Heli_Light_02_F // O_Heli_Light_02_unarmed_F // O_Heli_Light_02_v2_F ////DLC > O_Heli_Transport_04_F 
_airType = [];

switch (side _caller) do 
{
	case west: 			{_airType = "B_Heli_Light_01_F"};
	case east: 			{_airType = "B_Heli_Light_01_F"};
	case resistance: 	{_airType = "O_Heli_Light_02_v2_F"};
	case civilian: 		{_airType = "O_Heli_Light_02_unarmed_F"};
};

_mrkrcolor 	= [];

switch (side _caller) do {

         case west:			{_mrkrcolor = "ColorBlue"};
         case east:			{_mrkrcolor = "ColorRed"};
         case resistance:	{_mrkrcolor = "ColorGreen"};
         case civilian:		{_mrkrcolor = "ColorYellow"};
};

_marker = createMarkerLocal ["hStart", _airStart];
_marker setMarkerTypeLocal "select";
_marker setMarkerShapeLocal "Icon";  
_marker setMarkerTextLocal "hStart";
_marker setMarkerSizeLocal [0.75,0.75];
_marker setMarkerColorLocal _mrkrcolor;	
_marker setMarkerAlphaLocal 0.5;

uisleep 0.25;
location = false;
openmap [true,false];
titleText["Map location", "PLAIN"];
PAPABEAR=[side _caller,"HQ"]; PAPABEAR SideChat format ["On mapclick, %1, set a destination", name _caller];
onMapSingleClick "onMapSingleClick ''; mappos = _pos; location = true";		
waitUntil {sleep 1; (!visiblemap OR location OR !alive _caller)};
	if (!location OR !alive _caller OR !isNil {missionNamespace getVariable "TransportHelo"}) exitWith {
	mappos = nil;
	PAPABEAR=[side _caller,"HQ"]; PAPABEAR SideChat "Map location canceled";
	hint parseText format["<t size='1.25' color='#ff0000'>Map location canceled</t>"];
	titletext ["","plain"];
	deleteMarker "hStart";
	};

	_mrkr = createMarkerLocal ["LZ",mappos];
	_mrkr setMarkerTypeLocal "mil_end";
	_mrkr setMarkerShapeLocal "Icon";
	_mrkr setMarkerTextLocal "LZ";
	_mrkr setMarkerSizeLocal [1,1];
	_mrkr setMarkerColorLocal _mrkrcolor;
	_mrkr setMarkerAlphaLocal 0.5;

	lzDropoff = "Land_HelipadEmpty_F" CreateVehicle (getMarkerPos "LZ");

	missionNamespace setVariable ["TransportHelo",true];

titletext ["","plain",0.2];
hint parseText format["<t size='1.25' color='#208000'>Mapclick location successful</t>"];
uisleep 2;
hintSilent "";
openmap [false,false];

	_enemyArray = (getPos lzDropoff) nearEntities [["AllVehicles"], _searchRadius];

	{
		if ((side _x == _friendlySide) || (side _x == _neutralSide)) then {
		
			_enemyArray = _enemyArray - [_x];
		};
	} count _enemyArray;

		if ((count _enemyArray) > 4) exitWith {
		
			hint parseText format ["<t size = '1.5' color = '#FF0000'>Transport Not Available!</t><br/><br/>Enemies are too close! (100m)<br/><br/>Secure the area before requesting transport!"];

			deleteMarker "hStart";
			deleteMarker "LZ";
	    	deleteVehicle lzDropOff;
		};

    for "_i" from count waypoints (group _caller) - 1 to 0 step -1 do
    {
        deleteWaypoint [(group _caller), _i];
    };

    {if (!isNull objectParent _x) then {
		unassignVehicle _x; 
		commandGetOut [_x];
		[_x] orderGetIn false;
		[_x] allowGetIn false;
		 _x leaveVehicle assignedVehicle _x;
	}} forEach units group _caller;

	{ commandStop [_x] } forEach units group _caller;
	{ _x disableAi "MOVE";sleep 0.1; } forEach units group _caller;

	_flightPath = _airStart getDir _airEnd;		

	_ch = [_airStart, _flightPath, _airType, side _caller] call BIS_fnc_spawnVehicle;

	TransportHelo = _ch select 0;

	(_ch select 0) setVehicleVarname "TransportHelo";

	[TransportHelo] execVM "vehicleMarker.sqf";

	[TransportHelo,360] execVM "rvgFill_items.sqf";

	TransportHelo addEventHandler ["GetIn", { if (_this select 1 == "cargo") then { (_this select 2) allowDamage false; } } ]; 

	TransportHelo addEventHandler ["GetOut", { if (_this select 1 == "cargo") then { (_this select 2) allowDamage true; } } ];	
		
	TransportHelo addEventHandler ["Killed", { [_this select 0] execVM "heliEnd.sqf"; } ];

	{_x addEventHandler ["HandleDamage", {false}]} forEach crew (TransportHelo) + [TransportHelo];

	{addswitchableunit _x} forEach crew (TransportHelo);

	PAPABEAR=[side _caller,"HQ"]; PAPABEAR SideChat format ["TransportHelo to your position %1", name _caller];
	
	_hLand = _position;

	_land = createMarkerLocal ["pickUp", _hLand];
	_land setMarkerTypeLocal "mil_pickup";
	_land setMarkerShapeLocal "Icon";
	_land setMarkerTextLocal "pickup";
	_land setMarkerSizeLocal [1,1];
	_land setMarkerColorLocal _mrkrcolor;
	_land setMarkerAlphaLocal 0.5;
	
	lzPickup = "Land_HelipadEmpty_F" createvehicle _hLand;
			
	driver TransportHelo setBehaviour "CARELESS";

	_wp1 = (_ch select 2) addwaypoint [_hLand, 0];
	_wp1 setwaypointtype "LOAD";	
	_wp1 setWaypointBehaviour "AWARE";
	_wp1 setWaypointCombatMode "YELLOW";
	_wp1 setWaypointSpeed "NORMAL";
	_wp1 setWaypointStatements ["true","(vehicle this) land 'LAND';"];

	waitUntil { TransportHelo distance2d _hLand <= 100 };

	{ _x enableAi "MOVE";sleep 0.1; } forEach units group _caller;
	{ _x assignAsCargo TransportHelo } forEach (units group _caller); 
	{ [_x] orderGetIn true } forEach (units group _caller);

	_wpp1 = (group _caller) addwaypoint [_hLand, 0];
	_wpp1 waypointAttachVehicle TransportHelo;
	_wpp1 setwaypointtype "GETIN";	
	_wpp1 setWaypointBehaviour "AWARE";
	_wpp1 setWaypointCombatMode "YELLOW";
	_wpp1 setWaypointSpeed "NORMAL";
	_wpp1 setWaypointStatements ["true",""];

	waitUntil { { _x in TransportHelo } count units group _caller == count units group _caller };

	_wp2 = (_ch select 2) addwaypoint [getPos lzDropOff, 0];
	_wp2 setwaypointtype "UNLOAD";	
	_wp2 setWaypointBehaviour "AWARE";
	_wp2 setWaypointCombatMode "YELLOW";
	_wp2 setWaypointSpeed "NORMAL";
	_wp2 setWaypointStatements ["true","vehicle this land 'LAND'"];

	_wpp2 = (group _caller) addwaypoint [getPos lzDropOff, 0];
	_wpp2 setwaypointtype "GETOUT";	
	_wpp2 setWaypointBehaviour "AWARE";
	_wpp2 setWaypointCombatMode "YELLOW";
	_wpp2 setWaypointSpeed "NORMAL";
	_wpp2 setWaypointStatements ["true","{ unassignVehicle _x } forEach units group this; 
	{ [_x] orderGetIn false } forEach units group this;"];

	waitUntil { { _x in TransportHelo } count units group _caller == 0 };

	_wp3 = (_ch select 2) addwaypoint [_airStart, 0];
	_wp3 setwaypointtype "MOVE";
	_wp3 setWaypointBehaviour "CARELESS";
	_wp3 setWaypointCombatMode "BLUE";
	_wp3 setWaypointSpeed "NORMAL";
	_wp3 setWaypointStatements ["true","{deletevehicle _x} foreach (crew vehicle this + [vehicle this])"];

 	waitUntil { TransportHelo distance2d _airStart <= 100 };

	deleteVehicle lzPickup;
	deleteVehicle lzDropOff;
	deleteMarker "pickUp";
	deleteMarker "LZ";
	deleteMarker "hStart";
missionNamespace setVariable ["TransportHelo",nil];

for "_i" from count waypoints (group player) - 1 to 0 step -1 do
{
    deleteWaypoint [(group player), _i];
};

