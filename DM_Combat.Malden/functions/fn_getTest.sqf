
titleText ["CompatibleItems PrimaryWeapon\nPress PageUp to activate!\nCopied To ClipBoard!\nPress PageDown to quit!", "PLAIN DOWN", 3];

[] spawn {
    disableSerialization;
    _spaceEH = (findDisplay 46) displayAddEventHandler ["KeyDown", {
        if (_this # 1 == 201) then {

          [] spawn { 
Fn_Gear_CompatibleAttachments = { //0 - muzzle, 1 - optic, 2 - pointer, 3 - bipod
    private _wpn = _this select 0;
    private _asi = _this select 1;
    private _asn = ["MuzzleSlot", "CowsSlot", "PointerSlot", "UnderBarrelSlot"] select _asi;
    private _cfa = configfile >> "CfgWeapons" >> _wpn >> "WeaponSlotsInfo" >> _asn >> "compatibleItems";    
    private _res = nil;

    if (isClass _cfa) then {
        _res = configProperties [_cfa, "isNumber _x"] select {getNumber _x > 0} apply {configName _x};
    } else {
        if (isArray _cfa) then {
            _res = getArray _cfa;
        };
    };

    hint format ["%1",_res];
}; [primaryWeapon player,0] call Fn_Gear_CompatibleAttachments; 
            }; 
/*
            [] spawn {   
                _className = primaryWeapon player; // 'LMG_Mk200_F';

                _compatibleItems = _className call bis_fnc_compatibleItems;
                _txt = [];
                //_t = [];
                    {
                    _scope = str getNumber (configFile >> "CfgWeapons" >> _x >> 'scope');
                    _itemType = str (_x call bis_fnc_itemType);
                    _itemName = _x;
                    diag_log(_scope + " " + _itemType + " " + _itemName);
                    //_txt = (_scope + " " + _itemType + " " + _itemName );
                    _txt = _txt + [(_scope + " " + _itemType + " " + _itemName)];
                    } forEach _compatibleItems;                
                sleep 0.03;
                //for "_i" from 0 to count _txt -1 do {
                //_tx = _txt select _i;
                //_t = _t + [formatText ["%1%2", _tx, lineBreak]];};

                copyToClipboard format ["%1",_txt];
                hint format ["%1",_txt];
            }; 
*/
            [] spawn {
            titleText ["<t color='#ff0000' shadow = 0 size='5'>Renfro: </t><t color ='#FFFFFF' shadow = 0 size ='5'>Hello World</t>", "PLAIN DOWN", -1, true, true];
            
            mysleep = 
                {
                    if (!canSuspend) exitWith {_this spawn mysleep};
                    sleep _this;
                    systemChat ("Gimme " + str _this);
                };

                5 call mysleep;

            titleText ["<t color='#00fff7' shadow = 0 size='5'>Renfro: </t><t color ='#4400ff' shadow = 0 size ='5'>Hello World</t>", "PLAIN DOWN", -1, true, true];

            mysleep2 = 
                {
                    if (!canSuspend) exitWith {_this spawn mysleep2};
                    sleep _this;
                    systemChat ("Gimme " + str _this);
                };

                5 call mysleep2;

            _time = round triggerTimeoutCurrent trg1;
            format ["Time left to vacate the area: %1 seconds!", _time] remoteExec ["hint", 0]; 
            [_time, "#FF5500"] spawn LM_fnc_timeoutCountdown;
            //format ["Next enemy spawn in: %1 seconds!", _time] remoteExec ["hint", 0];    

            //[[{hint parseText format["<t size='1.25' color='#44ff00'>Check Map Objectives!</t>"]}],"BIS_fnc_Spawn",true] call BIS_fnc_MP;

            mysleep3 = 
                {
                    if (!canSuspend) exitWith {_this spawn mysleep3};
                    sleep _this;
                    systemChat ("Gimme " + str _this);
                };

                5 call mysleep3;

            hint parseText format["<t size='1.25' color='#44ff00'></t>"];

            };
        };
        if (_this # 1 == 209) then {

            (findDisplay 46) displayRemoveEventHandler ["KeyDown", uiNamespace getVariable "BIS_WL_spaceEH"];
        };
    }];
    uiNamespace setVariable ["BIS_WL_spaceEH", _spaceEH];
};

/*
[
    [ player,"AmovPercMstpSrasWrflDnon_AadjPpneMstpSrasWrflDleft"],
    "switchMove"
] call BIS_fnc_MP;


[
    [
        player,
        "AmovPercMstpSrasWrflDnon_AadjPpneMstpSrasWrflDleft"
    ],
    "switchMoveEverywhere"
] call BIS_fnc_MP; 
*/
