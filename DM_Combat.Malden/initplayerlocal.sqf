// initPlayerLocal.sqf //
enableRadio false;
enableSentences false;
{_x disableConversation true} forEach units group player;

[playerSide, "HQ"] commandChat "Initiating InitPlayer!";

//if !isMultiplayer then { execVM "ParamsPlus\respawn.sqf"; };

if !isMultiplayer then { 
	onTeamSwitch { [_from, _to] execVM "OnTeamSwitch.sqf"; }; 
	[playerSide, "HQ"] commandChat "Team Switch Enabled!";
};
	
call compile preprocessFileLineNumbers "briefing.sqf";
        	
call compile preprocessFileLineNumbers "bon_recruit_units\init.sqf";

call compile preprocessFileLineNumbers "ParamsPlus\mortarBag.sqf";

player execVM "ParamsPlus\HolsterAction.sqf";

player execVM "ParamsPlus\SafeWeapon.sqf";

_PJTAC = "PJTAC" call BIS_fnc_getParamValue;
if (_PJTAC isEqualTo 2) then {

	call compile preprocessFileLineNumbers "EPD\VirtualJTAC\init.sqf";
};
	
call compile preprocessFileLineNumbers "arsenalTriggerAction.sqf";

call compile preprocessFileLineNumbers "garageTriggerAction.sqf";

call compile preprocessFileLineNumbers "ParamsPlus\menu.sqf";

//call compile preprocessFileLineNumbers "008\menu2.sqf";

//player addEventHandler ["HandleDamage", { 0 }];

player addMPEventHandler ["MPHit", {
	params ["_unit", "_causedBy", "_damage", "_instigator"];
	[_unit,_causedBy] remoteExec ["lookat", group _unit];
    _rhv = 35;
    _armor = _rhv/100;
    getDammage _unit;
    scopeName "main";
    while {((getDammage _unit) > .1)} do {
        scopeName "loop1";
        _newDamage = (damage _unit) - _armor;
        _unit setdamage _newDamage;
        hintSilent parsetext format ["<t size='0.85' align='left'>Unit Name: </t><t size='0.85' color='#00bbff' align='left'>%1</t><br/><t size='0.85' align='left'>Before Regen: </t><t size='0.85' color='#00bbff' align='left'> %2m</t><br/><t size='0.85' align='left'>After Regen: $</t> <t size='0.85' color='#00bbff' align='left'> %3</t>", name _unit, damage _unit, round _newdamage];
        if ((getDammage _unit) > .9) then {breakTo "main"}; // Breaks all scopes and return to "main"
        if ((getDammage _unit) < .1) then {breakOut  "loop1"}; // Breaks scope named "loop1"
    };
}];
/*
player addEventHandler ["HitPart", { 
    params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];
    [_target,_shooter] remoteExec ["lookat", group _target];
    _rhv = 35;
    _armor = _rhv/100;
    getDammage _target;
    scopeName "main";
    while {((getDammage _target) > .1)} do {
        scopeName "loop1";
        _newDamage = (damage _target) - _armor;
        _target setdamage _newDamage;
        hintSilent parsetext format ["<t size='0.85' align='left'>Unit Name: </t><t size='0.85' color='#00bbff' align='left'>%1</t><br/><t size='0.85' align='left'>Before Regen: </t><t size='0.85' color='#00bbff' align='left'> %2m</t><br/><t size='0.85' align='left'>After Regen: $</t> <t size='0.85' color='#00bbff' align='left'> %3</t>", name _target, damage _target, round _newdamage];
        if ((getDammage _target) > .9) then {breakTo "main"}; // Breaks all scopes and return to "main"
        if ((getDammage _target) < .1) then {breakOut  "loop1"}; // Breaks scope named "loop2"
        sleep  .01; 
    };
}];
*/

if ( isNil{player getVariable "CommHalo"} ) then
{	
	[player,"HaloJump"] call BIS_fnc_addCommMenuItem;
	 player setVariable ["CommHalo", true];	
};
if ( isNil{player getVariable "CommMenuSupport"} ) then
{	
	[player,"MenuSupport"] call BIS_fnc_addCommMenuItem;
	 player setVariable ["CommMenuSupport", true];	
};
/*if ( isNil{player getVariable "CommMenuSupport2"} ) then
{	
	[player,"MenuSupport2"] call BIS_fnc_addCommMenuItem;
	 player setVariable ["CommMenuSupport2", true];	
};
if ( isNil{player getVariable "CommCursorInf"} ) then
{	
	[player,"CursorInf"] call BIS_fnc_addCommMenuItem;
	 player setVariable ["CommCursorInf", true];	
};*/
if ( isNil{player getVariable "CommManCursorMG"} ) then
{	
	[player,"ManCursorMG"] call BIS_fnc_addCommMenuItem;
	 player setVariable ["CommManCursorMG", true];	
};
if ( isNil{player getVariable "CommCursorMG"} ) then
{	
	[player,"CursorMG"] call BIS_fnc_addCommMenuItem;
	 player setVariable ["CommCursorMG", true];	
};
if ( isNil{player getVariable "BisLightning"} ) then
{	
	[player,"BisLightning"] call BIS_fnc_addCommMenuItem;
	 player setVariable ["CommBisLightning", true];	
};
// };
/*
if ( isNil{player getVariable "CommHeliTransport"} ) then
{	
	[player,"CursorHeliTransport"] call BIS_fnc_addCommMenuItem;
	 player setVariable ["CommCursorHeliTransport", true];	
};
if ( isNil{player getVariable "CommMortar"} ) then
{	
	[player,"SpawnMortar"] call BIS_fnc_addCommMenuItem;
	 player setVariable ["CommMortar", true];	
};
if ( isNil{player getVariable "CommParaDrop"} ) then
{	
	[player,"SpawnParaDrop"] call BIS_fnc_addCommMenuItem;
	 player setVariable ["CommParaDrop", true];	
};

if ( isNil{player getVariable "CommReenforcements"} ) then
{	
	[player,"SpawnReenforcements"] call BIS_fnc_addCommMenuItem;
	 player setVariable ["CommReenforcements", true];	
};

if ( isNil{player getVariable "CommWindSpeed"} ) then
{	
	[player,"WindSpeed"] call BIS_fnc_addCommMenuItem;
	 player setVariable ["CommWindSpeed", true];	
};
*/
if ( isNil{player getVariable "CommGroupManager"} ) then
{	
	execVM "Group_Manager.sqf";
	player setVariable ["CommGroupManager", true];	
};

/*
if ( isNil{player getVariable "CommAirLift"} ) then
{	
   [player,"AirLift"] call BIS_fnc_addCommMenuItem;
	 player setVariable ["CommAirLift", true];	
};
if ( isNil{player getVariable "CommAirSupport"} ) then
{	
   [player,"AirSupport"] call BIS_fnc_addCommMenuItem;
	 player setVariable ["CommAirSupport", true];	
};
if ( isNil{player getVariable "CommArty"} ) then
{	
	[player,"Artillery"] call BIS_fnc_addCommMenuItem;
	 player setVariable ["CommArty", true];	
};
if ( isNil{player getVariable "CommMortarBag"} ) then
{	
	[player,"SpawnMortarBag"] call BIS_fnc_addCommMenuItem;
	 player setVariable ["CommMortarBag", true];	
};
if ( isNil{player getVariable "CommCargo"} ) then
{	
	[player,"SpawnCargoDrop"] call BIS_fnc_addCommMenuItem;
	 player setVariable ["CommCargo", true];	
};
*/

enableRadio true;
enableSentences true;
{_x disableConversation false} forEach units group player;
