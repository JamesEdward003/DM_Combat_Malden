////////////////  "functions\fn_getCursorMG.sqf"  //////////////////
private ["_caller","_position","_target","_is3D","_id","_randPos","_mgguy","_mgunit","_mrkrCnt","_mrkrname","_mg"];
params ["_caller","_position","_target","_is3D","_id"];
_caller = _this select 0;
_position = _this select 1;

_classname = "O_G_HMG_02_high_F"; // call bis_fnc_selectrandom;
_displayname    = gettext (configfile >> "CfgVehicles" >> _className >> "displayName");
_mrkrcolor      = [];
_mrkrCnt        = 0;

if (!(isNil { missionNamespace getVariable "markerGroup"})) then
    {
        _mrkrCnt = missionNamespace getVariable "markerGroup";
        _mrkrCnt = _mrkrCnt + 1;
        missionNamespace setVariable ["markerGroup", _mrkrCnt, true];
    } else {       
        _mrkrCnt = 1;
        missionNamespace setVariable ["markerGroup", _mrkrCnt, true];
};

_mrkrCnt = missionNamespace getVariable "markerGroup"; 

_mrkrname = format ["%1_%2",_displayname,_mrkrCnt];

_mgname = format ["Static_%1",_mrkrCnt];

_myNearestEnemy = _caller findNearestEnemy _caller;
 
_relDir = _myNearestEnemy getRelDir _position;

_mgguy = [_position, _relDir + 180, _classname, side _caller] call BIS_fnc_spawnVehicle;

_mgname = _mgguy select 0;
_mggrp  = _mgguy select 2;

    wp0 = _mggrp addwaypoint [_position, 0];
    wp0 setwaypointtype "HOLD"; 
    wp0 setWaypointBehaviour "AWARE";
    wp0 setWaypointCombatMode "RED";
    wp0 setWaypointSpeed "NORMAL";
    wp0 setWaypointStatements ["true",""];
    
switch (side _caller) do {

    case west:             {_mrkrcolor = "ColorWEST"};
    case east:             {_mrkrcolor = "ColorEAST"};
    case resistance:       {_mrkrcolor = "ColorGUER"};
    case civilian:         {_mrkrcolor = "ColorCIV"};
    default                {_mrkrColor = "ColorRed"};
};

    _marker = createMarkerLocal [_mrkrname, _position];
    _marker setMarkerShapeLocal "ICON";
    _marker setMarkerTypeLocal "mil_dot";
    _marker setMarkerColor _mrkrcolor;
    _marker setMarkerTextLocal _displayname;
    _marker setMarkerSizeLocal [0.75,0.75];

_caller createDiaryRecord ["Diary", ["MG Placement", format ["%1 on grid <marker name='%2'>position</marker> %3",_displayname,_mrkrname,mapGridPosition _position]]];

//hint parseText format["<t size='1.25' color='#44ff00'>Check Map Objectives!</t>"];

titleText ["<t color='#ff0000' size='5'>RED ALERT!</t><br/>***********", "PLAIN", -1, true, true];

            mysleep = 
                {
                    if (!canSuspend) exitWith {_this spawn mysleep};
                    sleep _this;
                    systemChat ("Gimme " + str _this);
                };

                5 call mysleep;

titleText ["Enemy in the area!\nGet set to engage!", "PLAIN DOWN", -1];

playSound3D ["A3\Sounds_F\sfx\alarm_independent.wss", _caller];

playSound3D ["a3\dubbing_radio_f\data\eng\male02eng\radioprotocoleng\combat\100_commands\getreadytofight.ogg", _caller];

//playSound3D [getMissionPath "sounds\ATTACKING!.ogg", _caller];

