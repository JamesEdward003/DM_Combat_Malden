//////////////////////////////////////////////////////////////////
// execvm "paramsplus\rallyPOP.sqf"
//////////////////////////////////////////////////////////////////
private ["_unit","_pos","_vehicleVarName"];
_unit 	= _this select 0;                    
_pos = [];

_vehicleVarName = vehicleVarName _unit;

switch (side _unit) do {		

case WEST: {_pos = [_unit, 10, 50, 4, 0, 20, 0] call BIS_fnc_findSafePos;};
case EAST: {_pos = [_unit, 10, 50, 4, 0, 20, 0] call BIS_fnc_findSafePos;};	 
case RESISTANCE: {_pos = [_unit, 3, 5, 4, 0, 20, 0] call BIS_fnc_findSafePos;};
case CIVILIAN: {_pos = [_unit, 10, 15, 4, 0, 20, 0] call BIS_fnc_findSafePos;};
};

switch (side _unit) do {		

case WEST: {respawn_west setPos _pos;arsenal_west setPos getPos respawn_west;"respawn_west" setMarkerPos getPos respawn_west;};
case EAST: {respawn_east setPos _pos;arsenal_east setPos getPos respawn_east;"respawn_east" setMarkerPos getPos respawn_east;};	 
case RESISTANCE: {respawn_guer setPos _pos;arsenal_guer setPos getPos respawn_guer;"respawn_guer" setMarkerPos getPos respawn_guer;};
case CIVILIAN: {respawn_civilian setPos _pos;arsenal_civilian setPos getPos respawn_civilian;"respawn_civilian" setMarkerPos getPos respawn_civilian;};
};

//hintSilent "Rally Point Deployed!";
