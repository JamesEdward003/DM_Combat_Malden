////////////////  "functions\fn_getCursorInf.sqf"  //////////////////
private ["_caller","_position","_target","_is3D","_id"];
params ["_caller","_position","_target","_is3D","_id"];
_caller 	= _this select 0;
_position 	= _this select 1;
_group		= group _caller;
_mrkrcolor      = [];
_mrkrCnt        = 0;

if (!(isNil { missionNamespace getVariable "markerInfGroup"})) then
    {
        _mrkrCnt = missionNamespace getVariable "markerInfGroup";
        _mrkrCnt = _mrkrCnt + 1;
        missionNamespace setVariable ["markerInfGroup", _mrkrCnt, true];
    } else {       
        _mrkrCnt = 1;
        missionNamespace setVariable ["markerInfGroup", _mrkrCnt, true];
};

_mrkrCnt = missionNamespace getVariable "markerInfGroup"; 

//_group = format ["%1_%2",_group,_mrkrCnt];

_mrkrname = format ["Inf_%1",_mrkrCnt];

_myNearestEnemy = _caller findNearestEnemy _caller;

_randPos = [getPos vehicle _caller, 1, 60, 3, 0, 10, 0] call BIS_fnc_findSafePos;
 
_relDir = _myNearestEnemy getRelDir _randPos;

switch (side _caller) do {
	
	case west: {
		
		_reUnits_w = ["B_Captain_Pettka_F","B_Captain_Jay_F","B_Captain_Dwarden_F","B_Story_SF_Captain_F","B_G_Captain_Ivan_F","B_CTRG_soldier_AR_A_F","B_CTRG_soldier_GL_LAT_F","B_Story_Protagonist_F","B_CTRG_soldier_engineer_exp_F","B_CTRG_soldier_M_medic_F"];
			
		_reUnits_w = [_position, side _caller, _reUnits_w, [[0,4,0],[0,4,0],[0,4,0],[0,4,0],[0,4,0],[0,4,0],[0,4,0],[0,4,0],[0,4,0],[0,4,0]],["Captain","Captain","Captain","Captain","Captain","Lieutenant","Sergeant","Sergeant","Corporal","Corporal"],[],[],[],0] call BIS_fnc_spawnGroup;	

		for "_i" from 0 to count (units _reUnits_w) -1 do {
			
			_unit = (units _reUnits_w) select _i;

			_unit addAction ["<t color='#00FFFF'>Dismiss</t>","dismiss.sqf",[],-100,false,true,""];
			_unit action ["WEAPONONBACK", _unit];
			_unit allowDamage true;
			[_unit] joinSilent (group _caller);
			addswitchableunit _unit;
		};
	};		
	case east: {		//_reUnits_e_diver = ["O_diver_TL_F","O_diver_exp_F","O_diver_F"];

		_reUnits_e = ["O_G_Soldier_SL_F","O_G_Soldier_lite_F","O_G_Soldier_LAT2_F","O_G_Soldier_LAT_F","O_G_Soldier_M_F","O_G_Soldier_GL_F","O_G_Soldier_exp_F","O_G_engineer_F","O_G_medic_F","O_G_Soldier_AR_F","O_G_Soldier_A_F"];

//		_reUnits_e = ["O_Story_Colonel_F","O_Story_CEO_F","O_officer_F","O_A_soldier_TL_F","O_Soldier_GL_F","O_Soldier_AT_F","O_soldier_M_F","O_soldier_exp_F","O_engineer_F","O_soldier_mine_F","O_medic_F"];

		_reUnits_e = [_position, side _caller, _reUnits_e, [[0,4,0],[0,4,0],[0,4,0],[0,4,0],[0,4,0],[0,4,0],[0,4,0],[0,4,0],[0,4,0],[0,4,0],[0,4,0]],["Colonel","Major","Captain","Lieutenant","Lieutenant","Lieutenant","Sergeant","Sergeant","Sergeant","Corporal","Corporal"],[],[],[],0] call BIS_fnc_spawnGroup;
					
		for "_i" from 0 to count (units _reUnits_e) -1 do {
			
			 _unit = (units _reUnits_e) select _i;
			
			_unit addAction ["<t color='#00FFFF'>Dismiss</t>","dismiss.sqf",[],-100,false,true,""];
			_unit action ["WEAPONONBACK", _unit];
			_unit allowDamage true;
			[_unit] joinSilent (group _caller);
			addswitchableunit _unit;
		};
	};		
	case resistance: {	//_reUnits_r_diver = ["I_diver_TL_F","I_diver_exp_F","I_diver_F"];
		
		_reUnits_r = ["I_Story_Colonel_F","I_Captain_Hladas_F","I_C_Soldier_Camo_F","I_Story_Officer_01_F","I_engineer_F","I_soldier_mine_F","I_medic_F"];
		
		_reUnits_r = [_position, side _caller, _reUnits_r, [[0,4,0],[0,4,0],[0,4,0],[0,4,0],[0,4,0],[0,4,0],[0,4,0]],["Colonel","Captain","Captain","Lieutenant","Sergeant","Sergeant","Corporal"],[],[],[],0] call BIS_fnc_spawnGroup;	

		for "_i" from 0 to count (units _reUnits_r) -1 do {
			
			 _unit = (units _reUnits_r) select _i;
			
			_unit addAction ["<t color='#00FFFF'>Dismiss</t>","dismiss.sqf",[],-100,false,true,""];
			_unit action ["WEAPONONBACK", _unit];
			_unit allowDamage true;
			[_unit] joinSilent (group _caller);
			addswitchableunit _unit;
		};
	};
	case civilian: {	//_reUnits_c_diver = ["C_Nikos","C_Story_Scientist_01_F","C_Story_Scientist_02_F"];
		
		_reUnits_c = ["C_Story_Mechanic_01_F","C_Nikos","C_Nikos_aged","C_Orestes","C_Story_Scientist_01_F","C_Story_Scientist_02_F"];
		
		_reUnits_c = [_position, side _caller, _reUnits_c, [[0,4,0],[0,4,0],[0,4,0],[0,4,0],[0,4,0],[0,4,0]],["Captain","Lieutenant","Sergeant","Sergeant","Corporal","Corporal"],[],[],[],0] call BIS_fnc_spawnGroup;	

		for "_i" from 0 to count (units _reUnits_c) -1 do {
			
			 _unit = (units _reUnits_c) select _i;
			
			_unit addAction ["<t color='#00FFFF'>Dismiss</t>","dismiss.sqf",[],-100,false,true,""];
			_unit action ["WEAPONONBACK", _unit];
			_unit allowDamage true;
			[_unit] joinSilent (group _caller);
			addswitchableunit _unit;
		};
	};
};
                                                            
systemChat "To switch squad, use Keyboard (T) on one of the squad members."; 

    wp0 = _group addwaypoint [_position, 0];
    wp0 setwaypointtype "HOLD"; 
    wp0 setWaypointBehaviour "AWARE";
    wp0 setWaypointCombatMode "RED";
    wp0 setWaypointSpeed "NORMAL";
    wp0 setWaypointStatements ["true",""];

_text = toArray(str _group);
_text set[0,"**DELETE**"];
_text set[1,"**DELETE**"];
_text = _text - ["**DELETE**"];
_grp = toString(_text);

switch (side _caller) do {

    case west:             {_mrkrcolor = "ColorWEST"};
    case east:             {_mrkrcolor = "ColorEAST"};
    case resistance:       {_mrkrcolor = "ColorGUER"};
    case civilian:         {_mrkrcolor = "ColorCIV"};
    default                {_mrkrColor = "ColorRed"};
};

    _marker = createMarkerLocal [_mrkrname, _position];
    _marker setMarkerShapeLocal "ICON";
    _marker setMarkerTypeLocal "mil_dot";
    _marker setMarkerColor _mrkrcolor;
    _marker setMarkerTextLocal _grp;
    _marker setMarkerSizeLocal [0.75,0.75];

_caller createDiaryRecord ["Diary", ["Infantry Placement", format ["%1 on grid <marker name='%2'>position</marker>",_grp,_mrkrname]]];

//hint parseText format["<t size='1.25' color='#44ff00'>Check Map Objectives!</t>"];

titleText ["<t color='#ff0000' size='5'>RED ALERT!</t><br/>***********", "PLAIN", -1, true, true];

            mysleep = 
                {
                    if (!canSuspend) exitWith {_this spawn mysleep};
                    sleep _this;
                    systemChat ("Gimme " + str _this);
                };

                5 call mysleep;

titleText ["Enemy in the area!\nLock and load!", "PLAIN DOWN", -1];

playSound3D ["A3\Sounds_F\sfx\alarm_independent.wss", _caller];

//playSound3D [getMissionPath "sounds\ATTACKING!.ogg", _caller];

playSound3D ["a3\dubbing_radio_f\data\eng\male02eng\radioprotocoleng\combat\100_commands\lockandload.ogg", _caller];

_group setCombatMode "YELLOW";
