/////--"Wind_Direction.sqf"--/////
// Syntax:
// setWind [x, y, forced]
// Parameters:
// [x, y, forced]: Array
// x: Number - Easterly component (in m/s, positive = to the east)
// y: Number - Northerly component (in m/s, positive = to the north)
// Forced: Boolean - (Optional, default false) set to true to lock the wind to constantly blows in set direction
// texts[] = {"North","NorthEast","East","SouthEast","South","SouthWest","West","NorthWest"};
private ["_Wind_Dir"];
_Wind_Dir = "WindDirection" call BIS_fnc_getParamValue;

switch (_Wind_Dir) do
{
	case 1: {
		
			setWind [0, 10, true];								
	};
	case 2: {

			setWind [10, 10, true];				
	};
	case 3: {
		
			setWind [10, 0, true];							
	};
	case 4: {

			setWind [10, -10, true];					
	};
	case 5: {
		
			setWind [0, -10, true];								
	};
	case 6: {

			setWind [-10, -10, true];				
	};
	case 7: {
		
			setWind [-10, 0, true];							
	};
	case 8: {

			setWind [-10, 10, true];						
	};
};

