////////////////  "functions\fn_getCursorMG.sqf"  //////////////////
private ["_caller","_position","_target","_is3D","_id","_mgname","_mgobj","_mgDir","_mgunit","_marker","_mrkrCnt","_mrkrcolor","_mg","_classname"];
params ["_caller","_position","_target","_is3D","_id"];
_caller = _this select 0;
_position = _this select 1;
_grp = [];

switch (side _caller) do {

    case west:             {_grp = group Rambo_1};
    case east:             {_grp = group Nazari_1};
    case resistance:       {_grp = group Rosco_1};
    case civilian:         {_grp = group Revolution_1};
};

_classname = [];

switch (side _caller) do {

    case west:             {_classname = "B_G_HMG_02_high_F"}; // (selectRandom ["B_HMG_01_high_F","B_GMG_01_high_F","B_HMG_02_high_F","B_G_HMG_02_high_F"]);
    case east:             {_classname = "O_G_HMG_02_high_F"}; // (selectRandom ["O_HMG_01_high_F","O_GMG_01_high_F","O_HMG_02_high_F","O_G_HMG_02_high_F"]);
    case resistance:       {_classname = "I_G_HMG_02_high_F"}; // (selectRandom ["I_HMG_01_high_F","I_GMG_01_high_F","I_HMG_02_high_F","I_G_HMG_02_high_F"]);
    case civilian:         {_classname = "I_G_HMG_02_high_F"};
};

_displayname = gettext (configfile >> "CfgVehicles" >> _className >> "displayName");

_mrkrcolor = [];

switch (side _caller) do {

    case west:             {_mrkrcolor = "ColorWEST"};
    case east:             {_mrkrcolor = "ColorEAST"};
    case resistance:       {_mrkrcolor = "ColorGUER"};
    case civilian:         {_mrkrcolor = "ColorCIV"};
};

_mgDir = [];

if (!isNull roadAt _position) then {

    // _road = roadAt ASLToAGL getPosASL player;  
    // private _info = getRoadInfo _road;
    // _info params ["_mapType", "_width", "_isPedestrian", "_texture", "_textureEnd", "_material", "_begPos", "_endPos", "_isBridge"]; 
    // private _roadDirection = _begPos getDir _endPos;
    // _mgDir = _roadDirection;
    _mgDir = getDir _caller;

} else {
 
    _mgDir = getDir _caller;    
};

// _mg = createVehicle [_className, _position,[],0,"CAN_COLLIDE"];
// _mg setDir _mgDir; createVehicleCrew _mg; {_x setBehaviour "COMBAT"} forEach (crew _mg); //{_x allowDamage false} forEach (crew _mg);

_mgobj = [_position, _mgDir, _className, side _caller] call BIS_fnc_spawnVehicle;
_mg = (_mgobj select 0); _gunner = (_mgobj select 1 select 0);
_mg allowDamage false;
_mg addEventHandler ["Fired",{[_this select 0,getNumber (configFile/'CfgAmmo'/(_this select 4)/'explosive')] spawn {if (_this select 1==1) then {uisleep 0.5};_this select 0 setVehicleAmmo 1}}];
//_mg addeventhandler ["GetIn", {(_this select 2) allowDamage false}];
//_mg addeventhandler ["GetOut", {(_this select 2) allowDamage true}];

_wall1 = createVehicle ["Land_CncBarrier_F", (_mg modeltoworld [0,1.75,0]),[],0,"CAN_COLLIDE"];
_wall1 setPosATL [getPos _wall1 select 0, getPos _wall1 select 1, 0];
_wall1 setDir getDir _mg;
_wall2 = createVehicle ["Land_CncBarrier_F", (_mg modeltoworld [0,-1.75,0]),[],0,"CAN_COLLIDE"];
_wall2 setPosATL [getPos _wall2 select 0, getPos _wall2 select 1, 0];
_wall2 setDir getDir _mg;

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
        //if ((getDammage _unit) < .1) then {breakOut  "loop1"}; // Breaks scope named "loop1"
    };
}];

StaticGroupCount = StaticGroupCount + 1;
_mrkr = format["MG_%1",StaticGroupCount];
_marker = createMarkerLocal [_mrkr, _position];
_marker setMarkerShapeLocal "ICON";
_marker setMarkerTypeLocal "mil_dot";
_marker setMarkerColor _mrkrcolor;
_marker setMarkerTextLocal _mrkr;
_marker setMarkerSizeLocal [0.75,0.75];

_mg setVehicleVarname (format["MG_%1",StaticGroupCount]);
_mgid = _mg call BIS_fnc_netId;
missionNamespace setVariable [vehicleVarname _mg,_mgid];

_caller createDiaryRecord ["Diary", ["MG Placement", format ["%1 on grid <marker name='%2'>position</marker> %3",_displayname,_marker,mapGridPosition _position]]];

titleText ["<t color='#ff0000' size='5'>RED ALERT!</t><br/>***********", "PLAIN", -1, true, true];

mysleep = 
    {
        if (!canSuspend) exitWith {_this spawn mysleep};
        sleep _this;
        //systemChat ("Gimme " + str _this);
    };

    5 call mysleep;
myfunc = 
    {
        if (!canSuspend) exitWith {_this spawn myfunc};
        waitUntil { !isNull (_this findnearestenemy _this) };
        _this lookat (_this findnearestenemy _this);
        systemChat ("Gimme " + str (vehicleVarname _this));
    };

titleText ["Enemy in the area!\nGet set to engage!", "PLAIN DOWN", -1];

playSound3D ["A3\Sounds_F\sfx\alarm_independent.wss", _caller];

playSound3D ["a3\dubbing_radio_f\data\eng\male02eng\radioprotocoleng\combat\100_commands\getreadytofight.ogg", _caller];

waitUntil {!alive _gunner};


//_mg setCaptive true;
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

_gunner call myfunc;

// _gunner addeventhandler ["Killed",{
//     [(_this select 0),_mg] execVM "functions\manMG.sqf";
// }];

uisleep 10;

_mg call myfunc;

waitUntil {!alive _gunner};


//_mg setCaptive true;
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

_gunner call myfunc;

// _gunner addeventhandler ["Killed",{
//     [(_this select 0),_mg] execVM "functions\manMG.sqf";
// }];

uisleep 10;

_mg call myfunc;

waitUntil {!alive _gunner};


//_mg setCaptive true;
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

_gunner call myfunc;

// _gunner addeventhandler ["Killed",{
//     [(_this select 0),_mg] execVM "functions\manMG.sqf";
// }];

uisleep 10;

_mg call myfunc;

waitUntil {!alive _gunner};


//_mg setCaptive true;
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

_gunner call myfunc;

// _gunner addeventhandler ["Killed",{
//     [(_this select 0),_mg] execVM "functions\manMG.sqf";
// }];

uisleep 10;

_mg call myfunc;
