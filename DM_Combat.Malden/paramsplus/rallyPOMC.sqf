////////////////////////////////////////////////////////////////////////
// execvm "rallyPOMC.sqf"
////////////////////////////////////////////////////////////////////////
sleep 0.25;
openMap true;
sleep 0.25;
 
	PAPABEAR=[playerSide,"HQ"]; PAPABEAR SideChat "Click on the map";
	
dt=true;
onMapSingleClick "spwnPt = _pos;dt=false";
waitUntil {!dt};
onMapSingleClick "";
			
sleep 2;
openMap false;	

switch (playerSide) do {		

case WEST: {respawn_west setPosATL spwnPt;"respawn_west" setMarkerPos getPos respawn_west;};
case EAST: {respawn_east setPosATL spwnPt;"respawn_east" setMarkerPos getPos respawn_east;};
case RESISTANCE: {respawn_guer setPosATL spwnPt;"respawn_guer" setMarkerPos getPos respawn_guer;};
case CIVILIAN: {respawn_civilian setPosATL spwnPt;"respawn_civilian" setMarkerPos getPos respawn_civilian;};	
};

hintSilent "Rally Point Deployed";

