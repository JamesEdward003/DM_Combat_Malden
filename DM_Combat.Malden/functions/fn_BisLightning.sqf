//////////// "functions\fn_BisLightning.sqf ////////////
private ["_caller","_position","_target","_is3D","_id"];
params ["_caller","_position","_target","_is3D","_id"];
_caller = _this select 0;
_position = _this select 1;
[cursorTarget, nil, true] call BIS_fnc_moduleLightning;
