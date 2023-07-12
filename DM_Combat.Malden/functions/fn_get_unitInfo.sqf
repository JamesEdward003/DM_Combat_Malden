// fn_get_unitInfo.sqf //
/*
 File fn_get_unitInfo.sqf
 Title: Spawn Script Creator
 Author: Sarogahtyp
 Description: Gets all info bout one unit
 Argument: unit
 Return value: array with all info about that unit with this structure:

[
 string,			-    0 class name
 [number, number, number],	-    1 position ASL
 [number, number, number],	-    2 vector dir
 [number, number, number],	-    3 vector up
 number,			-    4 level of ability (skill)
 number,			-    5 aimingAccuracy
 number,			-    6 aimingShake
 number,			-    7 aimingSpeed
 number,			-    8 endurance
 number,			-    9 spotDistance
 number,			-   10 spotTime
 number,			-   11 courage
 number,			-   12 reloadSpeed
 number,			-   13 commanding
 number,			-   14 general
 string,			-   15 behaviour
 string,			-   16 combatMode
 number,			-   17 getFatigue
 number,			-   18 captiveNum
// string,			-  currentCommand
 string,			-   19 unitPos 
 number,			-   20 damage
 array,				-   21 expectedDestination
 boolean,			-   22 leader
 string,			-   23 rank
 string,			-   24 name
 number,			-   25 rating
];

*/


if (isNil "saro_SSC_leader_array") exitWith {true};
if (count saro_SSC_leader_array == 0) exitWith {true};

params[["_unit", objNull, [objNull]]];


private _info_array = [];

_info_array pushBack (typeOf _unit);
_info_array pushBack (getPosASL _unit);
_info_array pushBack (vectorDir _unit);
_info_array pushBack (vectorUp _unit);

_info_array pushBack skill _unit;
_info_array pushBack (_unit skill "aimingAccuracy");
_info_array pushBack (_unit skill "aimingShake");
_info_array pushBack (_unit skill "aimingSpeed");
_info_array pushBack (_unit skill "endurance");
_info_array pushBack (_unit skill "spotDistance");
_info_array pushBack (_unit skill "spotTime");
_info_array pushBack (_unit skill "courage");
_info_array pushBack (_unit skill "reloadSpeed");
_info_array pushBack (_unit skill "commanding");
_info_array pushBack (_unit skill "general");
_info_array pushBack behaviour _unit;
_info_array pushBack combatMode _unit;
_info_array pushBack getFatigue _unit;
_info_array pushBack captiveNum _unit;
// _info_array pushBack currentCommand _unit;
_info_array pushBack unitPos _unit;
_info_array pushBack damage _unit;
_info_array pushBack expectedDestination _unit;

if ((leader group _unit) != _unit) then { _info_array pushBack false; }
else { _info_array pushBack true; };

_info_array pushBack rank _unit;
_info_array pushBack name _unit;
_info_array pushBack rating _unit;

_info_array;

hint format 

["typeOf = %1\ngetPosASL = %2\nvectorDir = %3\nvectorUp = %4\nskill = %5\naimingAccuracy = %6\naimingShake = %7\naimingSpeed = %8\nendurance = %9\nspotDistance = %10\nspotTime = %11\ncourage = %12\nreloadSpeed = %13\ncommanding = %15\ngeneral = %16\nbehaviour = %17\ncombatMode = %18\ngetFatigue = %19\ncaptiveNum = %20\nunitPos = %21\ndamage = %22\nexpectedDestination = %23",_info_array select 0,_info_array select 1,_info_array select 2,_info_array select 3,_info_array select 4,_info_array select 5,_info_array select 6,_info_array select 7,_info_array select 8,_info_array select 9,_info_array select 10,_info_array select 11,_info_array select 12,_info_array select 13,_info_array select 14,_info_array select 15,_info_array select 16,_info_array select 17,_info_array select 18,_info_array select 19,_info_array select 20,_info_array select 21,_info_array select 22];

