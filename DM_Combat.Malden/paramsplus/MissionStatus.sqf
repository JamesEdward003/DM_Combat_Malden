// execVM "MissionStatus.sqf"; //
private ["_MissionStatus"];
_MissionStatus = "MissionStatus" call BIS_fnc_getParamValue;
if (_MissionStatus isEqualTo 2) exitWith {};

	call BIS_fnc_showMissionStatus;


