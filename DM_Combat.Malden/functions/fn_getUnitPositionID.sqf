// fn_getUnitPositionID.sqf //
/*
// player joinAs [createGroup west, 5];
// _id = player call REN_fnc_getUnitPositionId;
// hint str _id;
*/
private ["_vvn", "_str"];
_vvn = vehicleVarName _this;
_this setVehicleVarName "";
_str = str _this;
_this setVehicleVarName _vvn;
parseNumber (_str select [(_str find ":") + 1])


  