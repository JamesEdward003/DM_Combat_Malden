/////////////  "initServer.sqf"  ////////////
/*
_Base = [playerSide, "PAPA_BEAR"] commandChat "Initiating InitServer!";
 _CROSSROAD = [playerSide, "HQ"] commandChat "Initiating InitServer!";
_Base = [playerSide, "Base"] commandChat "Initiating InitServer!";
_Base = [playerSide, "AirBase"] commandChat "Initiating InitServer!";
_Broadway = [playerSide, "BLU"] commandChat "Initiating InitServer!";
_Griffin = [playerSide, "OPF"] commandChat "Initiating InitServer!";
_Phalanx = [playerSide, "IND"] commandChat "Initiating InitServer!";
_Slingshot = [playerSide, "IND"] commandChat "Initiating InitServer!";

Headquarters Entity module
 BIS_hqWest, BIS_hqEast, BIS_hqGuer
*/

_CROSSROAD = [playerSide, "HQ"] commandChat "Initiating InitServer!";
SupplyMrkrCount = 0;publicVariable "SupplyMrkrCount";
StaticGroupCount = 0;publicVariable "StaticGroupCount";

//{if (!( isPlayer _x ) and !(_x in (units group player))) then  {deleteVehicle _x}} forEach (if ismultiplayer then {playableunits} else {switchableunits});

{if (!( isPlayer _x ) and (_x in (units group player))) then  {_x addAction ["<t color='#00FFFF'>Dismiss</t>","ParamsPlus\dismiss.sqf",[],100,false,true,""];}} forEach (if ismultiplayer then {playableunits} else {switchableunits});

{if (_x in (units group player)) then  {

	_x addEventHandler ["InventoryOpened", {
		params ["_unit", "_container"];
		if (count (_unit nearSupplies 50) >0) then {			
			_SupplyMarkers = [];
			_mrkrColor 	= [];
			switch (side _unit) do {
         		case blufor:		{_mrkrcolor = "ColorWEST"};
         		case opfor:			{_mrkrcolor = "ColorEAST"};
         		case independent:	{_mrkrcolor = "ColorGUER"};
         		case civilian:		{_mrkrcolor = "ColorCIV"};
			};
			hintSilent "Near Supplies Marked On Map!";
			for "_a" from SupplyMrkrCount to (SupplyMrkrCount + (count (_unit nearSupplies 50)) - 1) do {
				for "_b" from 0 to (count (_unit nearSupplies 50) - 1) do {
					_supplyType = typeOf ((_unit nearSupplies 50) select _b);
	           		_n = format["SupplyMarker_%1", _a];
	           		_m = createMarker [_n, (_unit nearSupplies 50) select _b];
	           		_m setMarkerType "mil_dot";
	           		_m setMarkerColor _mrkrColor;
	           		_m setMarkerText (str _supplyType);
	           		_SupplyMarkers pushBack _m;
	           		SupplyMrkrCount = SupplyMrkrCount + 1;
           		};
           	};
		} else {hintSilent "No Supplies Near Unit!";};	// nearSupplies [typeName, radius]
	}];
}} forEach (if ismultiplayer then {playableunits} else {switchableunits});

{if (_x in (units group player)) then  {
	_x addEventHandler ["InventoryClosed", {
		params ["_unit", "_container"];
		_addWeapon = [_unit,currentWeapon _unit,1] call BIS_fnc_addWeapon;
		_unit setVariable ["loadout",(getUnitLoadout _unit)];
		titletext ["\nLoadout Saved", "PLAIN DOWN"];
	}];
}} forEach (if ismultiplayer then {playableunits} else {switchableunits});

[west, "PETTKA"] call BIS_fnc_addRespawnInventory;
[west, "NORTHGATE"] call BIS_fnc_addRespawnInventory;
[west, "KERRY"] call BIS_fnc_addRespawnInventory;
[west, "MCKAY"] call BIS_fnc_addRespawnInventory;
[west, "JAMES"] call BIS_fnc_addRespawnInventory;
[west, "HARDY"] call BIS_fnc_addRespawnInventory;
[west, "KELLY"] call BIS_fnc_addRespawnInventory;
[west, "SQUADLEADER"] call BIS_fnc_addRespawnInventory;
[west, "MARKSMAN"] call BIS_fnc_addRespawnInventory;
