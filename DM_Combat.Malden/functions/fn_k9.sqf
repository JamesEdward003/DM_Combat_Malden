// fn_k9.sqf //
private ["_caller","_logicCenter","_logicGroup","_myLogicObject"];
_caller = _this select 0;
_logicCenter = createCenter sideLogic;
_logicGroup = createGroup _logicCenter;
_myLogicObject = _logicGroup createUnit ["k9_module", [0,0,0], [], 0, "NONE"];
_myLogicObject synchronizeObjectsAdd [_caller];

_myLogicObject setVehicleVarName "k9Logic";
missionNamespace setVariable ["k9Logic", _myLogicObject, true];

SnowWhite synchronizeObjectsAdd [_caller];

