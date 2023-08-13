// init.sqf //

[playerSide, "HQ"] commandChat "Initiating v2023.8.12";

addMissionEventHandler ["EntityKilled", { 
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	removeAllActions _unit;
	_killer addRating 100;
}];

addMissionEventHandler ["EntityRespawned", { 
	params ["_entity", "_corpse"];
	if (!isPlayer _entity) then {
		if (!(_entity in (units player))) then {
			switch (side _entity) do {
				case west: {_spawnPos=[[[position respawn_west, 50]], []] call BIS_fnc_randomPos;_entity setPos _spawnPos;};
				case east: {_spawnPos=[[[position respawn_east, 50]], []] call BIS_fnc_randomPos;_entity setPos _spawnPos;};
				case resistance: {_spawnPos=[[[position respawn_guer, 50]], []] call BIS_fnc_randomPos;_entity setPos _spawnPos;};
				case civilian: {_spawnPos=[[[position respawn_civilian, 50]], []] call BIS_fnc_randomPos;_entity setPos _spawnPos;};
			};
		};
	_PRespawnLoadOut = "PRespawnLoadOut" call BIS_fnc_getParamValue;
	if (_PRespawnLoadOut isEqualTo 2) then
		{
			if (isNull _corpse) exitWith {};
			_entity setUnitLoadout (getUnitLoadout _corpse);
		};
		_droppedGear = nearestObjects [_corpse, ["WeaponHolder", "WeaponHolderSimulated", "GroundWeaponHolder"], 10];
        {deleteVehicle _x} forEach _droppedGear + [_corpse];
	};
}]; 

if (hasInterface) then { 
  [] spawn { 
    waitUntil {alive player}; 
    player setVariable ["loadout", getUnitLoadout player]; 
  }; 
};
if (isServer) then {
  addMissionEventHandler ["entityKilled", { 
    params ["_unit"]; 
    if (isNil {_unit getVariable "loadout"} && !isPlayer _unit) then {
      _unit setVariable ["loadout", getUnitLoadout _unit]
    };
  }];
  addMissionEventHandler ["entityRespawned", { 
    params ["_unit"];
    _unit setUnitLoadout (_unit getVariable "loadout")
  }]
};
/*
addMissionEventHandler ["EntityRespawned", { 
	params ["_entity", "_corpse"];
	if ((_entity in playableUnits) || (_entity in switchableUnits)) then { [playerSide, "HQ"] commandChat "Unit Respawned!";
		_entity setVehicleVarname (vehicleVarname _corpse);
		_entity setIdentity (vehicleVarname _corpse);
		switch (rankID _corpse) do {
			case 1:	{_entity setUnitRank "Private"};
			case 2:	{_entity setUnitRank "Corporal"};
			case 3:	{_entity setUnitRank "Sergeant"};
			case 4:	{_entity setUnitRank "Lieutenant"};
			case 5:	{_entity setUnitRank "Captain"};
			case 6:	{_entity setUnitRank "Colonel"};
		};
	};
}]; 
*/
addMissionEventHandler ["Map", {
	params ["_mapIsOpened", "_mapIsForced"];
	if (_mapIsForced) then {
	{_x enableAi "MOVE"} forEach units group player;
	player action ["WEAPONONBACK", player];};
}];

addMissionEventHandler ["MapSingleClick", {
	params ["_units", "_pos", "_alt", "_shift"];
	if (_alt) then {
	deleteVehicle LZ;
	if ((getMarkerPos "LZ") isEqualTo [0,0,0]) then {deleteMarker "LZ"};
	if (!((getMarkerPos "LZ") isEqualTo [0,0,0])) then {deleteMarker "LZ"};
	LZ = "Land_HelipadEmpty_F" createVehicle _pos;		  
	createMarkerLocal ["LZ", _pos];
	"LZ" setMarkerTypeLocal "mil_objective";
	"LZ" setMarkerShapeLocal "Icon";
	"LZ" setMarkerTextLocal " LZ";
	"LZ" setMarkerSizeLocal [1,1];
	"LZ" setMarkerColorLocal "colorblack";	
	player setPosATL [(getMarkerPos "LZ") select 0,(getMarkerPos "LZ") select 1,0];
	hint parseText format["<t size='1.25' color='#44ff00'>Check Map Objective!</t>"];};
}];

addMissionEventHandler[ "TeamSwitch", {
	params[ "_previousUnit", "_newUnit" ];
	setGroupIconsVisible[ true, true ];
	_newUnit setVariable[ "MARTA_SHOWRULES", _previousUnit getVariable "MARTA_SHOWRULES" ];
	_newUnit setVariable[ "MARTA_REVEAL", _previousUnit getVariable "MARTA_REVEAL" ];
	_newUnit setVariable[ "MARTA_HIDE", _previousUnit getVariable "MARTA_HIDE" ];
	group _newUnit setVariable[ "enemygroups", group _previousUnit getVariable "enemygroups" ];
}];

addMissionEventHandler ["GroupIconClick", {
	params [
		"_is3D", "_group", "_waypointId",
		"_mouseButton", "_posX", "_posY",
		"_shift", "_control", "_alt"
	];
	if (_shift) then {{_x allowDamage false} forEach units _group};
	if (_alt) then {{_x allowDamage true} forEach units _group};
}];
/*
addMissionEventHandler ["MarkerCreated", {
	params ["_marker", "_channelNumber", "_owner", "_local"];
	//if (_marker isEqualTo (allMapMarkers select {toUpper _x find "BIS_SUPP" >= 0}) select 0) then { 
	if (_marker in (allMapMarkers select {toUpper _x find "BIS_SUPP" >= 0})) then {
		[] spawn {
			if (!(isNull HelipadEmpty)) then {deleteVehicle HelipadEmpty};
			if (!(isNull JumpTarget)) then {deleteVehicle JumpTarget};
		};
		HelipadEmpty = "Land_HelipadEmpty_F" createVehicle (getMarkerPos _marker);
		JumpTarget = "Land_JumpTarget_F" createVehicle (getMarkerPos _marker);
		hintSilent format ["MarkerArray: %1", allMapMarkers select {toUpper _x find "BIS_SUPP" >= 0}];
		//hintSilent parseText format ["<t size='1.25' color='#ff0000'>Marker Created</t><br/><br/><t size='1.10'>Marker: %1</t><br/><t size='1.00'>Channel#: %2</t><br/><t size='1.00'>Owner: %3</t><br/></t><br/><t size='1.00'>Local: %4</t>", _marker, _channelNumber, _owner, _local];
	};
}];

addMissionEventHandler ["MarkerDeleted", {
	params ["_marker", "_local"];
	if (_marker in (allMapMarkers select {toUpper _x find "BIS_SUPP" >= 0})) then {
		//[] spawn {
			if (!(isNull HelipadEmpty)) then {deleteVehicle HelipadEmpty};
			if (!(isNull JumpTarget)) then {deleteVehicle JumpTarget};
		//};
		hintSilent format ["MarkerArray: %1", allMapMarkers select {toUpper _x find "BIS_SUPP" >= 0}];
		//hintSilent parseText format ["<t size='1.25' color='#ff0000'>Marker Created</t><br/><br/><t size='1.10'>Marker: %1</t><br/><t size='1.00'>Channel#: %2</t><br/><t size='1.00'>Owner: %3</t><br/></t><br/><t size='1.00'>Local: %4</t>", _marker, _channelNumber, _owner, _local];
	};	
	//hintSilent parseText format ["<t size='1.25' color='#ff0000'>Marker Deleted</t><br/><br/><t size='1.10'>Marker: %1</t><br/><t size='1.00'>Local: %2</t>", _marker, _local];
}];

addMissionEventHandler ["MarkerUpdated", {
	params ["_marker", "_local"];
	//hintSilent parseText format ["<t size='1.25' color='#ff0000'>Marker Updated</t><br/><br/><t size='1.10'>Marker: %1</t><br/><t size='1.00'>Local: %2</t>", _marker, _local];
	if (_marker in (allMapMarkers select {toUpper _x find "BIS_SUPP" >= 0})) then {
		[] spawn {
			if (!(isNull HelipadEmpty)) then {deleteVehicle HelipadEmpty};
			if (!(isNull JumpTarget)) then {deleteVehicle JumpTarget};
		};
		HelipadEmpty = "Land_HelipadEmpty_F" createVehicle (getMarkerPos _marker);
		JumpTarget = "Land_JumpTarget_F" createVehicle (getMarkerPos _marker);
		hintSilent format ["MarkerArray: %1", allMapMarkers select {toUpper _x find "BIS_SUPP" >= 0}];
		//hintSilent parseText format ["<t size='1.25' color='#ff0000'>Marker Created</t><br/><br/><t size='1.10'>Marker: %1</t><br/><t size='1.00'>Channel#: %2</t><br/><t size='1.00'>Owner: %3</t><br/></t><br/><t size='1.00'>Local: %4</t>", _marker, _channelNumber, _owner, _local];
	};
}];
*/
KS_fnc_vehicleRespawnNotification =
{
	params [ ["_vehicle", objNull, [objNull]] ];
	
	if ( isNull _vehicle ) exitWith {};
	
	private _vehicleSide = [_vehicle, true] call bis_fnc_objectSide;
	private _cfgVeh = configfile >> "cfgvehicles" >> typeOf _vehicle;
	private _displayName = gettext (_cfgVeh >> "displayName");
	private _picture = (gettext (_cfgVeh >> "picture")) call bis_fnc_textureVehicleIcon;
	private _respawnName = format [localize "str_a3_bis_fnc_respawnmenuposition_grid",mapgridposition (position _vehicle)];
	[["RespawnVehicle",[_displayName, _respawnName, _picture]], "BIS_fnc_showNotification", _vehicleSide] call bis_fnc_mp;
};

[ "supportCalled", "onEachFrame", {
	if ((player getVariable "BIS_SUPP_request") select 0 != "" && count ((player getVariable "BIS_SUPP_request") select 1) == 3 && (player getVariable "BIS_SUPP_selectedProvider") getVariable "BIS_SUPP_supporting") then {
		hint parseText format["<t size='1.25' color='#44ff00'>Support Called!</t>"];
	};
}] call BIS_fnc_addStackedEventHandler;

[ "supportCalled", "onEachFrame", {
	if ( ( player getVariable "BIS_SUPP_request" ) select 0 == "Artillery" && ( player getVariable "bis_supp_selectedmodule" ) == arty_one && ( player getVariable "BIS_SUPP_selectedProvider" ) getVariable[ "BIS_SUPP_supporting", false ] ) then {
		hint parseText format["<t size='1.25' color='#44ff00'>Artillery Support Called!</t>"];
	};
}] call BIS_fnc_addStackedEventHandler;

["Preload"] call BIS_fnc_arsenal;

["Initialize"] call BIS_fnc_dynamicGroups;

["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;

[missionnamespace,"arsenalOpened", {
	params ["_namespace", "_name", "_handlerID"];
    cuttext [format ["Welcome, your role is: %1.", getText(configFile >> "CfgVehicles" >> (typeOf player) >> "displayName")],"PLAIN DOWN",1];
}] call bis_fnc_addScriptedEventhandler;

[missionnamespace,"arsenalClosed", {
	params ["_namespace", "_name", "_handlerID"];
    player setVariable ["loadout",(getUnitLoadout player)];
    titletext ["\nArsenal loadout saved.", "PLAIN DOWN"];
}] call bis_fnc_addScriptedEventhandler;

addMissionEventHandler ["TeamSwitch", {
    params ["_previousUnit", "_newUnit"];
    _previousUnit enableAI "TeamSwitch";
}];

[] spawn {
	while {true} do {
		sleep 2;
		player setVariable [ "MARTA_REVEAL", allGroups select {side _x != playerSide && leader _x distance2D player < 300}];
		player setVariable [ "MARTA_HIDE", allGroups select {side _x == playerSide or side _x == civilian or (leader _x distance2D player >= 300)}];
	}
};

    