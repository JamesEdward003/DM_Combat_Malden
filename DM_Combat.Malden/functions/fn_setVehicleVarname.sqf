// fn_setVehicleVarname.sqf //
private ["_veh", "_name"];
params ["_veh", "_name"];
missionNamespace setVariable [_name, _veh, true];
[_veh, _name] remoteExec ["setVehicleVarName", 0, _veh];

