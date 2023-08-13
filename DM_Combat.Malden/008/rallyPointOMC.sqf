////////////////////////////////////////////////////////////////////////
// execvm "rallyPOMC.sqf"
////////////////////////////////////////////////////////////////////////
private ["_pos"];
uisleep 0.25;
location = false;
openmap [true,false];
titleText["Map location", "PLAIN"];
hintSilent parseText format["<t size='1.25' color='#00FFFF'>%1<br/> Set a location on mapclick</t>", name player];

onMapSingleClick "onMapSingleClick ''; RPt = _pos; location = true";		
waitUntil {sleep 1; (!visiblemap OR location OR !alive player)};
	if (!location OR !alive player) exitWith {
	RPt = nil;
	PAPABEAR=[playerSide,"HQ"]; PAPABEAR SideChat "Map location canceled";
	hintSilent parseText format["<t size='1.25' color='#ff0000'>Map location canceled</t>"];
	titletext ["","plain"];
	};
   
	hintSilent parseText format["<t size='1.25' color='#00FFFF'>Stand By...</t>"];

switch (playerSide) do {		

case WEST: {respawn_west setPos RPt;arsenal_west setPos (respawn_west modeltoworld [0,3,0]);"respawn_west" setMarkerPos getPos respawn_west;};
case EAST: {respawn_east setPos RPt;arsenal_east setPos (respawn_east modeltoworld [0,3,0]);"respawn_east" setMarkerPos getPos respawn_east;};	 
case RESISTANCE: {respawn_guer setPos RPt;arsenal_guer setPos (respawn_guer modeltoworld [0,3,0]);"respawn_guer" setMarkerPos getPos respawn_guer;};
case CIVILIAN: {respawn_civilian setPos RPt;arsenal_civilian setPos (respawn_civilian modeltoworld [0,3,0]);"respawn_civilian" setMarkerPos getPos respawn_civilian;};
};

titletext ["","plain",0.2];
hintSilent parseText format["<t size='1.25' color='#00FFFF'>Rally Point Deployed!</t>"];
uisleep 2;
hintSilent "";
openmap [false,false];
