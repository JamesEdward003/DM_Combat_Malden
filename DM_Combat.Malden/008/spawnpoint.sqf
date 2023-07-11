//////////////////////////////////////////////////////////////////
// Function file for Armed Assault
// Created by: RALPH BELLAMY
// execvm "SpawnPoint.sqf"
//////////////////////////////////////////////////////////////////
_unit 	= _this select 0;                    

_vehicleVarName = vehicleVarName _unit;

_unit spawn {

	_height = ((getPosATLVisual _this) select 2);

	switch (side _this) do {		

	case WEST: {[WEST, (_this modeltoworld [0,3,_height]), "RespawnWest"] call BIS_fnc_addRespawnPosition;};
	case EAST: {[EAST, (_this modeltoworld [0,3,_height]), "RespawnEast"] call BIS_fnc_addRespawnPosition;}; 
	case RESISTANCE: {[RESISTANCE, (_this modeltoworld [0,3,_height]), "RespawnGuer"] call BIS_fnc_addRespawnPosition;};
	case CIVILIAN: {[CIVILIAN, (_this modeltoworld [0,3,_height]), "RespawnCivilian"] call BIS_fnc_addRespawnPosition;};
	};
};

hintSilent format ["Rally Point Deployed At %1", _vehicleVarName];
