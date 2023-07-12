private ["_caller","_cam2","_lightsource","_spaceEH1","_spaceEH2","_spaceEH3"];
_caller = _this select 0;
_cam2 = "Land_HandyCam_F" createVehicleLocal (getPos (vehicle _caller));
_cam2 hideObject true;
_cam2 attachTo [vehicle _caller, [0,0,30]];
_cam2 setVectorUp [0,0.99,0.01];
_cam2 switchCamera "EXTERNAL";

_lightsource = "#lightpoint" createVehicleLocal (getPos _cam2);
_lightsource attachTo [_cam2, [0,0,1]];

titleText ["Top Down View Loaded!          \nPress Left Mouse Button To Fire!\nPress R Key To Reload!        \nPress Right Windows Key To Return!", "PLAIN DOWN", -1];

vehicle _caller allowDamage false;

_spaceEH1=findDisplay 46 displayAddEventHandler ["MouseButtonDown", {
    if (_this select 1 == 0) then {
        vehicle _caller forceWeaponFire [currentMuzzle vehicle _caller, currentWeaponMode vehicle _caller];
    };
    false
}];
uiNamespace setVariable ["BIS_WL_spaceEH1", _spaceEH1];

_spaceEH2=findDisplay 46 displayAddEventHandler ["KeyDown", {
    if (_this select 1 in actionKeys "ReloadMagazine") then {
        reload vehicle _caller;
    };
    false
}];
uiNamespace setVariable ["BIS_WL_spaceEH2", _spaceEH2];

_spaceEH3=findDisplay 46 displayAddEventHandler ["KeyDown", {
    if (_this select 1 == 220) then {
        vehicle _caller switchCamera "INTERNAL";
        detach _lightsource;
        deleteVehicle _lightsource;
        detach _cam2;
        deleteVehicle _cam2;
        (findDisplay 46) displayRemoveEventHandler ["MouseButtonDown", uiNamespace getVariable "BIS_WL_spaceEH1"];
        (findDisplay 46) displayRemoveEventHandler ["KeyDown", uiNamespace getVariable "BIS_WL_spaceEH2"];
        (findDisplay 46) displayRemoveEventHandler ["KeyDown", uiNamespace getVariable "BIS_WL_spaceEH3"];
    };
    false
}];
uiNamespace setVariable ["BIS_WL_spaceEH3", _spaceEH3];

