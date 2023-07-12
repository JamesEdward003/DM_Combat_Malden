//////////////////////////////////////////////////////////////////
// execvm "rallyPOP.sqf"
//////////////////////////////////////////////////////////////////
_unit 	= _this select 0;                    

_vehicleVarName = vehicleVarName _unit;

_unit spawn {

	_height = ((getPosATLVisual _this) select 2);

	switch (side _this) do {		

	case WEST: {"respawn_west" setMarkerPos (_this modeltoworld [0,3,_height]);	
	 respawn_west setPos (_this modeltoworld [0,3,_height]);};
	case EAST: {"respawn_east" setMarkerPos (_this modeltoworld [0,3,_height]);	
	 respawn_east setPos (_this modeltoworld [0,3,_height]);};	 
	case RESISTANCE: {"respawn_guer" setMarkerPos (_this modeltoworld [0,3,_height]);	
	 respawn_guer setPos (_this modeltoworld [0,3,_height]);};	
	case CIVILIAN: {"respawn_civilian" setMarkerPos (_this modeltoworld [0,3,_height]);	
	 respawn_civilian setPos (_this modeltoworld [0,3,_height]);}; 
	};

};

hintSilent format ["Rally Point Deployed At %1", _vehicleVarName];
