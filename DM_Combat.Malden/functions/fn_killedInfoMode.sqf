// fn_killedInfoMode.sqf //

addMissionEventHandler ["EntityKilled", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	if (_unit isKindOf "MAN") then {
	[_unit,_killer,_instigator,_useEffects] call REN_fnc_killedInfo;
	_rating = rating _unit;
	_score = rating _unit;
	_killer addRating _rating;
	_killer addScore _score;
	};
}];

