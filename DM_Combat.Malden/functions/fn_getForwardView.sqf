private ["_caller","_cam1","_lightsource","_spaceEH1","_spaceEH2","_spaceEH3"];
_caller = _this select 0;
_cam1 = "Land_HandyCam_F" createVehicleLocal [0,0,0];
_cam1 hideObject true;
_cam1 attachTo [vehicle _caller, [0,-3,5]];
_cam1 setVectorUp [0,0.60,0.40];
_cam1 switchCamera "EXTERNAL";

vehicle player allowDamage false;

titleText ["Top Down View Loaded!          \nPress Left Mouse Button To Fire!\nPress R Key To Reload!        \nPress Right Windows Key To Return!", "PLAIN DOWN", -1];

_dispEH1=findDisplay 46 displayAddEventHandler ["MouseButtonDown", {
    if (_this select 1 == 0) then {
        vehicle _caller forceWeaponFire [currentMuzzle vehicle _caller, currentWeaponMode vehicle _caller];
    };
    false
}];
uiNamespace setVariable ["BIS_WL_dispEH1", _dispEH1];

_dispEH2=findDisplay 46 displayAddEventHandler ["KeyDown", {
    if (_this select 1 in actionKeys "ReloadMagazine") then {
        reload vehicle _caller;
    };
    false
}];
uiNamespace setVariable ["BIS_WL_dispEH2", _dispEH2];

_dispEH3=findDisplay 46 displayAddEventHandler ["KeyDown", {
    if (_this select 1 == 220) then {
        vehicle _caller switchCamera "INTERNAL";
        detach _cam1;
        deleteVehicle _cam1;
        vehicle player allowDamage true;
        (findDisplay 46) displayRemoveEventHandler ["MouseButtonDown", uiNamespace getVariable "BIS_WL_dispEH1"];
        (findDisplay 46) displayRemoveEventHandler ["KeyDown", uiNamespace getVariable "BIS_WL_dispEH2"];
        (findDisplay 46) displayRemoveEventHandler ["KeyDown", uiNamespace getVariable "BIS_WL_dispEH3"];
    };
    false
}];
uiNamespace setVariable ["BIS_WL_dispEH3", _dispEH3];
