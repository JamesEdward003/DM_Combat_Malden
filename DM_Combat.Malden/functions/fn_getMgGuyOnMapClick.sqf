private ["_randPos","_mgguy","_mgunit","_mrkrCnt","_mrkrname","_mg"];
_caller = _this select 0;
_className      = [];
switch (side _caller) do 
{
	case west: 			{_className = "O_G_HMG_02_high_F"};
	case east: 			{_className = "O_G_HMG_02_high_F"};
	case resistance: 	{_className = "O_G_HMG_02_high_F"};
	case civilian: 		{_className = "O_G_HMG_02_high_F"};
};
_displayname    = gettext (configfile >> "CfgVehicles" >> _className >> "displayName");
_mrkrcolor      = [];
_mrkrCnt        = 0;

switch (side _caller) do {

         case west:			{_mrkrcolor = "ColorBlue"};
         case east:			{_mrkrcolor = "ColorRed"};
         case resistance:	{_mrkrcolor = "ColorGreen"};
         case civilian:		{_mrkrcolor = "ColorYellow"};
};

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

uisleep 0.25;
location=false;
openmap [true,false];
titleText["Map location", "PLAIN"];
PAPABEAR=[side _caller,"HQ"]; PAPABEAR SideChat format ["On mapclick, %1, set a location", name _caller];
onMapSingleClick "onMapSingleClick ''; mappos = _pos; location=true;";		
waitUntil {sleep 1; (!visiblemap OR location == true OR !alive _caller)};
	if (!(location == true) OR !alive _caller) exitWith {
	mappos = nil;
	PAPABEAR=[side _caller,"HQ"]; PAPABEAR SideChat "Map location canceled";
	hint parseText format["<t size='1.25' color='#ff0000'>Map location canceled</t>"];
	titletext ["","plain"];
	};
  
    	_marker = createMarkerLocal [_mrkrname, mappos];
    	_marker setMarkerShapeLocal "ICON";
    	_marker setMarkerTypeLocal "mil_dot";
    	_marker setMarkerColor _mrkrcolor;
    	_marker setMarkerTextLocal _displayname;
    	_marker setMarkerSizeLocal [0.75,0.75];
	
titletext ["","plain",0.2];
hint parseText format["<t size='1.25' color='#208000'>Mapclick location successful</t>"];
uisleep 2;
hintSilent "";
openmap [false,false];

_randPos = [(getMarkerPos _mrkrname), 1, 20, 3, 0, 10, 0] call BIS_fnc_findSafePos;
 
_myNearestEnemy = _caller findNearestEnemy _caller;
 
_relDir = _myNearestEnemy getRelDir _randPos;

_mgguy = [_randPos, _relDir + 180, _classname, side _caller] call BIS_fnc_spawnVehicle;

_mgname = _mgguy select 0;
_mggrp  = _mgguy select 2;

    wp0 = _mggrp addwaypoint [_randPos, 0];
    wp0 setwaypointtype "HOLD"; 
    wp0 setWaypointBehaviour "AWARE";
    wp0 setWaypointCombatMode "RED";
    wp0 setWaypointSpeed "NORMAL";
    wp0 setWaypointStatements ["true",""];

_caller createDiaryRecord ["Diary", ["MG Placement", format ["%1 on grid <marker name='%2'>position</marker>",_displayname,_mrkrname]]];

//hint parseText format["<t size='1.25' color='#44ff00'>Check Map Objectives!</t>"];

titleText ["<t color='#ff0000' size='5'>RED ALERT!</t><br/>***********", "PLAIN", -1, true, true];

            mysleep = 
                {
                    if (!canSuspend) exitWith {_this spawn mysleep};
                    sleep _this;
                    systemChat ("Gimme " + str _this);
                };

                5 call mysleep;

titleText ["Enemy in the area!\nLight em up!", "PLAIN DOWN", -1];

playSound3D ["A3\Sounds_F\sfx\alarm_independent.wss", _caller];

//playSound3D [getMissionPath "sounds\ATTACKING!.ogg", _caller];
//C:\Users\barro\Downloads\a3\dubbing_radio_f\data\eng\male02eng\radioprotocoleng\combat\100_commands
playSound3D ["a3\dubbing_radio_f\data\eng\male02eng\radioprotocoleng\combat\100_commands\combatopenfire_2.ogg", _caller];


