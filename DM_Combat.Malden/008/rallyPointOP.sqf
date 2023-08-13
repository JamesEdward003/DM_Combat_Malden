//////////////////////////////////////////////////////////////////
// execvm "paramsplus\rallyPOP.sqf"
//////////////////////////////////////////////////////////////////
private ["_unit","_pos","_vehicleVarName"];
_unit 	= _this select 0;                    
_pos = [];

_vehicleVarName = vehicleVarName _unit;

//	_height = ((getPosASLW _this) select 2);
_height = ((getPosATLVisual _unit) select 2);

switch (side _unit) do {		

case WEST: {respawn_west setPos getPos _unit;arsenal_west setPos (respawn_west modeltoworld [0,3,_height]);"respawn_west" setMarkerPos getPos respawn_west;};
case EAST: {respawn_east setPos getPos _unit;arsenal_east setPos (respawn_east modeltoworld [0,3,_height]);"respawn_east" setMarkerPos getPos respawn_east;};	 
case RESISTANCE: {respawn_guer setPos getPos _unit;arsenal_guer setPos (respawn_guer modeltoworld [0,3,_height]);"respawn_guer" setMarkerPos getPos respawn_guer;};
case CIVILIAN: {respawn_civilian setPos getPos _unit;arsenal_civilian setPos (respawn_civilian modeltoworld [0,3,_height]);"respawn_civilian" setMarkerPos getPos respawn_civilian;};
};

//hintSilent parseText format["<t size='1.25' color='#00FFFF'>%1<br/>Rally Point Deployed!</t>",_vehicleVarName];

/*
switch (side _unit) do {		

case WEST: {_pos = [_unit, 10, 50, 4, 0, 20, 0] call BIS_fnc_findSafePos;};
case EAST: {_pos = [_unit, 10, 50, 4, 0, 20, 0] call BIS_fnc_findSafePos;};	 
case RESISTANCE: {_pos = [_unit, 3, 5, 4, 0, 20, 0] call BIS_fnc_findSafePos;};
case CIVILIAN: {_pos = [_unit, 10, 15, 4, 0, 20, 0] call BIS_fnc_findSafePos;};
};
*/
