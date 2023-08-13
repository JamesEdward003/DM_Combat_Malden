////////////////////////////////////////////////////////////////////////
// Created by:  DieHard - Function file for ArmA 3
////////////////////////////////////////////////////////////////////////
private ["_pos"];
uisleep 0.25;
location = false;
openmap [true,false];
titleText["Map location", "PLAIN"];
//PAPABEAR=[playerSide,"HQ"]; PAPABEAR SideChat "On mapclick, set a spawn point!";
hintSilent parseText format["<t size='1.25' color='#00FFFF'>%1<br/>Set a respawn point on mapclick</t>", name player];

onMapSingleClick "onMapSingleClick ''; mappos = _pos; location = true";		
waitUntil {sleep 1; (!visiblemap OR location OR !alive player)};
	if (!location OR !alive player) exitWith {
	mappos = nil;
	PAPABEAR=[playerSide,"HQ"]; PAPABEAR SideChat "Mapclick canceled";
	hintSilent parseText format["<t size='1.25' color='#ff0000'>Map location canceled!</t>"];
	titletext ["","plain"];
	};
   
   	titleText ["<t color='#ff0000' size='5'>Stand By...</t><br/>***********", "PLAIN", -1, true, true];
	//hintSilent parseText format["<t size='1.25' color='#00FFFF'>Stand By...</t>"];

	switch (playerSide) do {	

	case WEST: {[WEST, mappos, "RespawnWest"] call BIS_fnc_addRespawnPosition;};
	case EAST: {[EAST, mappos, "RespawnEast"] call BIS_fnc_addRespawnPosition;}; 
	case RESISTANCE: {[RESISTANCE, mappos, "RespawnGuer"] call BIS_fnc_addRespawnPosition;};
	case CIVILIAN: {[CIVILIAN, mappos, "RespawnCivilian"] call BIS_fnc_addRespawnPosition;};
	};

titletext ["","plain",0.2];
hintSilent parseText format["<t size='1.25' color='#00FFFF'>Mapclick successful!</t>"];
uisleep 2;
hintSilent "";
openmap [false,false];

uisleep 2;
hintSilent format ["%1 Respawn Point Deployed",playerSide];

