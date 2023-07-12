// fn_get_leader.sqf //
/*
 File get_leader.sqf
 Title: Spawn Script Creator
 Author: Sarogahtyp
 Description: Called from units init line. Determines group leader of unit and stores it in global array.
 Argument: 0 - usually this from units init line
 Return value: true when script ended
*/

params[["_unit", objNull, [objNull]]];

if (isNull _unit) exitWith {true};  // no object passed

if (isNil "saro_SSC_leader_array") then { saro_SSC_leader_array = []};

if (!((leader group _unit) in saro_SSC_leader_array))  then { saro_SSC_leader_array pushBack _unit;};

true

execVM "fn_get_unit_info.sqf";