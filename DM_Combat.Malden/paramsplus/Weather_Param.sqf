/////--"Weather_Param.sqf"--/////
// Syntax:
// set weather value
// Parameters:
// value: Number - new value in range 0...1
// example: [1] call BIS_fnc_setOvercast;
// texts[] = {"Clear Sky","Sparse Clouds","Light Clouds","Moderate Clouds","Dense Clouds","Light Rain","Heavy Rain","Rain Storm"};
// waitUntil{!(isNil "BIS_fnc_init")};
// waitUntil{!(isNil "BIS_MPF_InitDone")};
[playerSide, "HQ"] commandChat "Initiating Weather Params!";
private ["_Weather_Param"];
_Weather_Param = "Weather_Param" call BIS_fnc_getParamValue;

switch (_Weather_Param) do
{
	case 1: {
		
			[0] spawn {[_this select 0] call BIS_fnc_setOvercast};					
	};
	case 2: {

			[.15] spawn {[_this select 0] call BIS_fnc_setOvercast};
	};
	case 3: {
		
			[.3] spawn {[_this select 0] call BIS_fnc_setOvercast};			
	};
	case 4: {

			[.45] spawn {[_this select 0] call BIS_fnc_setOvercast};
	};
	case 5: {
		
			[.6] spawn {[_this select 0] call BIS_fnc_setOvercast};			
	};
	case 6: {

			[.75] spawn {[_this select 0] call BIS_fnc_setOvercast};
	};
	case 7: {
		
			[.90] spawn {[_this select 0] call BIS_fnc_setOvercast};		
	};
	case 8: {

			[1] spawn {[_this select 0] call BIS_fnc_setOvercast};
	};
	default {

			[0] spawn {[_this select 0] call BIS_fnc_setOvercast};
	};
};


