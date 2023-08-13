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
		
			[west, 1] call BIS_fnc_respawnTickets;
			[east, 1] call BIS_fnc_respawnTickets;		
			[resistance, 1] call BIS_fnc_respawnTickets;	
			[civilian, 1] call BIS_fnc_respawnTickets;					
	};
	case 2: {

			[west, 2] call BIS_fnc_respawnTickets;
			[east, 2] call BIS_fnc_respawnTickets;		
			[resistance, 2] call BIS_fnc_respawnTickets;	
			[civilian, 2] call BIS_fnc_respawnTickets;			
	};
	case 3: {
		
			[west, 3] call BIS_fnc_respawnTickets;
			[east, 3] call BIS_fnc_respawnTickets;		
			[resistance, 3] call BIS_fnc_respawnTickets;	
			[civilian, 3] call BIS_fnc_respawnTickets;							
	};
	case 4: {

			[west, 4] call BIS_fnc_respawnTickets;
			[east, 4] call BIS_fnc_respawnTickets;		
			[resistance, 4] call BIS_fnc_respawnTickets;	
			[civilian, 4] call BIS_fnc_respawnTickets;					
	};
	case 5: {
		
			[west, 5] call BIS_fnc_respawnTickets;
			[east, 5] call BIS_fnc_respawnTickets;		
			[resistance, 5] call BIS_fnc_respawnTickets;	
			[civilian, 5] call BIS_fnc_respawnTickets;							
	};
	case 6: {

			[west, 6] call BIS_fnc_respawnTickets;
			[east, 6] call BIS_fnc_respawnTickets;		
			[resistance, 6] call BIS_fnc_respawnTickets;	
			[civilian, 6] call BIS_fnc_respawnTickets;			
	};
	case 7: {
		
			[west, 7] call BIS_fnc_respawnTickets;
			[east, 7] call BIS_fnc_respawnTickets;		
			[resistance, 7] call BIS_fnc_respawnTickets;	
			[civilian, 7] call BIS_fnc_respawnTickets;						
	};
	case 8: {

			[west, 8] call BIS_fnc_respawnTickets;
			[east, 8] call BIS_fnc_respawnTickets;		
			[resistance, 8] call BIS_fnc_respawnTickets;	
			[civilian, 8] call BIS_fnc_respawnTickets;					
	};
	case 9: {
		
			[west, 9] call BIS_fnc_respawnTickets;
			[east, 9] call BIS_fnc_respawnTickets;		
			[resistance, 9] call BIS_fnc_respawnTickets;	
			[civilian, 9] call BIS_fnc_respawnTickets;						
	};
	case 10: {

			[west, 10] call BIS_fnc_respawnTickets;
			[east, 10] call BIS_fnc_respawnTickets;		
			[resistance, 10] call BIS_fnc_respawnTickets;	
			[civilian, 10] call BIS_fnc_respawnTickets;				
	};
};

[east, "HQ"] commandChat "NUMBER TICKETS SET!";

