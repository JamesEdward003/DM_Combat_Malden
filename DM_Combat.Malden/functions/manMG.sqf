// manMG.sqf //
private ["_unit","_mg","_gunners","_gunner","_grp"];
params ["_unit","_mg"];
// _unit = _this select 0;
// _mg = _this select 1;
_mgid = missionNamespace getVariable (vehicleVarname _mg);
_mg = _mgid call BIS_fnc_objectFromNetId;
hintSilent format ["<t color='#ff0000' size='2'>VehicleVarname Unit: %1</t><br/>Side Unit: %2</t><br/>MG: %3</t><br/>MGid: %4</t><br/>",vehicleVarname _unit,side _unit,_mg,_mgid];
//copytoclipboard format ["<t color='#ff0000' size='2'>VehicleVarname Unit: %1</t><br/>Side Unit: %2</t><br/>MG: %3</t><br/>MGid: %4</t><br/>",vehicleVarname _unit,side _unit,_mg,_mgid];
//_mg setCaptive true;                                          
_grp = [];

switch (side _unit) do {

    case west:             {_grp = group Rambo_1};
    case east:             {_grp = group Nazari_1};
    case resistance:       {_grp = group Rosco_1};
    case civilian:         {_grp = group Revolution_1};
};

_gunners = [];

for "_i" from 0 to count units _grp -1 do {

    _unit = (units _grp) select _i;

    if ((alive _unit) AND ( isNull objectParent _unit )) then {
        _gunners pushBack _unit;
    };
};

if (count _gunners < 1) exitWith {titleText [format ["<t color='#ff0000' size='2'>%1 replacement gunner not available</t><br/>***********",vehicleVarname _mg], "PLAIN DOWN", -1, true, true];};

_gunner = _gunners select ((count _gunners) - 1);

_gunner assignAsGunner _mg;

[_gunner] orderGetIn TRUE;

_gunner action ["getInGunner", _mg];

_gunner moveInGunner _mg;

_gunner setBehaviour "COMBAT";

//_mg setCaptive false;

_gunner addMPEventHandler ["MPHit", {
    params ["_unit", "_causedBy", "_damage", "_instigator"];
    [_unit,_causedBy] remoteExec ["lookat", group _unit];
    _rhv = 35;
    _armor = _rhv/100;
    getDammage _unit;
    scopeName "main";
    while {((getDammage _unit) > .1)} do {
        scopeName "loop1";
        _newDamage = (damage _unit) - _armor;
        _unit setdamage _newDamage;
        hintSilent parsetext format ["<t size='0.85' align='left'>Unit Name: </t><t size='0.85' color='#00bbff' align='left'>%1</t><br/><t size='0.85' align='left'>Before Regen: </t><t size='0.85' color='#00bbff' align='left'> %2</t><br/><t size='0.85' align='left'>After Regen: </t> <t size='0.85' color='#00bbff' align='left'> %3</t>", name _unit, damage _unit, round _newdamage];
        if ((getDammage _unit) > .9) then {breakTo "main"}; // Breaks all scopes and return to "main"
        if ((getDammage _unit) < .1) then {breakOut  "loop1"}; // Breaks scope named "loop1"
    };
}];

titleText [format ["<t color='#ff0000' size='2'>%1 assigned as gunner</t><br/>***********",vehicleVarname _gunner], "PLAIN DOWN", -1, true, true];

_gunner lookat (_gunner findnearestenemy _gunner);

_gunner call myfunc;

_gunner addeventhandler ["Killed",{
    [(_this select 0),_mg] execVM "functions\manMG.sqf";
}];

uisleep 10;

_mg call myfunc;
