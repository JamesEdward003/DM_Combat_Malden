// fn_get_unitNumber.sqf //
/*
// fn_get_unitNumber.sqf
// Called using :  [unit] call fn_get_unitNumber
// Description : Returns the Unit's group number as seen in the command gui
// removes the first 2 elements from that array and then recompiles as a string
*/
private["_u"];
 
  _u = _this select 0;
  parseNumber(([[str _u, count(toArray(str group _u))+1] call BIS_fnc_trimString, " "] call BIS_fnc_splitString) select 0)

  