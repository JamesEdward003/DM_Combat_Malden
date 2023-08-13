/////--"paramsplus\armed_civilian_group.sqf"--/////
private ["_unit","ArmedCivilians"];
_ArmedCivilians = "ArmedCivilians" call BIS_fnc_getParamValue;

_civfor = [];

{if ((side _x) == civilian) then {_civfor pushBack _x}} forEach allUnits;

switch (_ArmedCivilians) do
{
	case 1: {
		
		for "_i" from 0 to count _civfor - 1 do
		
			{
				_unit = _civfor select _i;
					
				if (((dayTime > ((date call BIS_fnc_sunriseSunsetTime) select 0) - 0.5) && (dayTime < ((date call BIS_fnc_sunriseSunsetTime) select 1) + 0.5)) isEqualTo false) then {_unit action ["nvGoggles", _unit]};

				_unitlo	= getUnitLoadout _unit;

				_unit setVariable ["LoadoutDone", _unitlo, true];

				_unit action ["WEAPONONBACK", _unit];

				if (isPlayer _unit) then {

				[playerSide, "HQ"] commandChat "Loadouts Done!";

				};

				_unit setDamage 0;
					
			};						
		};
	case 2: {	
					
		for "_i" from 0 to count _civfor - 1 do
		
			{
				_unit = _civfor select _i;

				_unit execVM "ParamsPlus\Armed_Civilian.sqf";

			};						
		};
				
};

