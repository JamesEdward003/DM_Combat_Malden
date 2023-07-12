/////--"respawnTickets.sqf"--/////
//Syntax:
//[east, number] call BIS_fnc_respawnTickets;
//Parameters:
//[east, number]: Array
private ["_NumberTickets"];
_NumberTickets = "NumberTickets" call BIS_fnc_getParamValue;

switch (_NumberTickets) do
{
	case 1: {
		
			[east, 1] call BIS_fnc_respawnTickets;								
	};
	case 2: {

			[east, 2] call BIS_fnc_respawnTickets;					
	};
	case 3: {
		
			[east, 3] call BIS_fnc_respawnTickets;							
	};
	case 4: {

			[east, 4] call BIS_fnc_respawnTickets;						
	};
	case 5: {
		
			[east, 5] call BIS_fnc_respawnTickets;								
	};
	case 6: {

			[east, 6] call BIS_fnc_respawnTickets;				
	};
	case 7: {
		
			[east, 7] call BIS_fnc_respawnTickets;							
	};
	case 8: {

			[east, 8] call BIS_fnc_respawnTickets;					
	};
	case 9: {
		
			[east, 9] call BIS_fnc_respawnTickets;							
	};
	case 10: {

			[east, 10] call BIS_fnc_respawnTickets;					
	};
};

[east, "HQ"] commandChat "NUMBER TICKETS SET!";

