// execVM "initGodMode.sqf"; //
private ["_GodMode"];
_GodMode = "GodMode" call BIS_fnc_getParamValue;
if (_GodMode isEqualTo 2) exitWith {};
[] spawn {
			_vehGrp = [];  // empty array to check vehicles in use.
			_grp = [];     // empty array to check group for new members.

		while {true} do {
			{
				//  check every unit in group, if not in a vehicle and not in _grp array: then add godmode and unlimited ammo and add to _grp array, else do nothing.
				if !(_x in _grp AND (vehicle _x) == _x) then {
					_x addeventhandler ["fired", {(_this select 0) setvehicleammo 1}];
					_x allowDamage false;
					_grp = _grp + [_x];
				};
					//  check every unit in group, if in a vehicle and vehicle is not in _vehGrp array: then add godmode and unlimited ammo to vehicle and add to _vehGrp array, else do nothing.
					if (vehicle _x != _x AND !(vehicle _x in _vehGrp)) then {
						(vehicle _x) addeventhandler ["fired", {(_this select 0) setvehicleammo 1}];
						_vehGrp = _vehGrp + [(vehicle _x)];
						(vehicle _x) allowDamage false;
					};
			} foreach units (group player);

			sleep 0.5;
		};
	};


