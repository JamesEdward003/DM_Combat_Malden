/////--"Wind_Strength.sqf"--/////
// Syntax:
// time setWindStr value
// Parameters:
// time: Number
// value: Number - new value in range 1...0
// example: 60 setWindStr 0.8; // set the wind strength to 0.8 gradually over the next 60 seconds
// texts[] = {"Dead Still","Whisper","Gentle Breeze","Moderate Breeze","Strong Breeze","High Winds","Near Gale","Gale Force"};
private ["_Wind_Str"];
_Wind_Str = "WindStrength" call BIS_fnc_getParamValue;

switch (_Wind_Str) do
{
	case 1: {
		
			60 setWindStr 0.0;								
	};
	case 2: {

			60 setWindStr 0.2;				
	};
	case 3: {
		
			60 setWindStr 0.4;							
	};
	case 4: {

			60 setWindStr 0.6;					
	};
	case 5: {
		
			60 setWindStr 0.7;								
	};
	case 6: {

			60 setWindStr 0.8;				
	};
	case 7: {
		
			60 setWindStr 0.9;							
	};
	case 8: {

			60 setWindStr 1.0;						
	};
};


