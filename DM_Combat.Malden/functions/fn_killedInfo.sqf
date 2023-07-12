// fn_killedInfo.sqf //

	params ["_unit", "_killer", "_instigator", "_useEffects"];
	
	if (isNull _instigator) then {_instigator = UAVControl vehicle _killer select 0};
	if (isNull _instigator) then {_instigator = _killer};

	_weaponName = getText (configFile >> "cfgWeapons" >> currentWeapon (_this select 1) >> "displayname");
//	hintSilent format ["%1 was killed by %2 with a %3", name _unit, name _instigator, _weaponName];
//	systemChat format[ "Taken %1 %2", if ( isNil "_taken" ) then { _count }else{ _taken }, _mag ];
	systemChat format[ "%1 was killed by %2 with a %3", name _unit, name _instigator, _weaponName ];

