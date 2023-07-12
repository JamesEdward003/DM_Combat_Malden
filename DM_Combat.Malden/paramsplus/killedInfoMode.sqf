// killedInfoMode.sqf //
_KillNotices = "KillNotices" call BIS_fnc_getParamValue;
if (_KillNotices isEqualTo 2) exitWith {};
KAI_fnc_killedInfo = {
	_victimName = name (_this select 0);
	_killerName = name (_this select 1);
	_weaponName = getText (configFile >> "cfgWeapons" >> currentWeapon (_this select 1) >> "displayname");
	hintSilent format ["%1 was killed by %2 with a %3", _victimName, _killerName, _weaponName];
};
 
//{
//  _id = _x addMPEventHandler ["MPKilled", {
//	_nul = _this call KAI_fnc_killedInfo;
//   }];
//} foreach allUnits;

addMissionEventHandler ["EntityKilled", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	if (_unit isKindOf "MAN") then {
	[_unit,_killer] call KAI_fnc_killedInfo;
	_rating = rating _unit;
	_score = rating _unit;
	_killer addRating _rating;
	_killer addScore _score;
	};
}];

