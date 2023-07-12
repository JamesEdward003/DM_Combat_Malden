private ["_mrkrname","_marker","_cam3","_lightsource","_spaceEH1","_spaceEH2","_spaceEH3"];
uisleep 0.25;
location=false;
openmap [true,false];
titleText["Map location", "PLAIN"];
PAPABEAR=[side player,"HQ"]; PAPABEAR SideChat format ["On mapclick, %1, set a location", name player];
onMapSingleClick "onMapSingleClick ''; mappos = _pos; location=true;";      
waitUntil {sleep 1; (!visiblemap OR location == true OR !alive player)};
    if (!(location == true) OR !alive player) exitWith {
    mappos = nil;
    PAPABEAR=[side player,"HQ"]; PAPABEAR SideChat "Map location canceled";
    hint parseText format["<t size='1.25' color='#ff0000'>Map location canceled</t>"];
    titletext ["","plain"];
    };

    _mrkrname = format ["Cam_%1",random 100];

    _marker = createMarkerLocal [_mrkrname, mappos];
    _marker setMarkerShapeLocal "ICON";
    _marker setMarkerTypeLocal "mil_dot";
    _marker setMarkerColor "ColorRed";
    _marker setMarkerSizeLocal [0.75,0.75];
    
titletext ["","plain",0.2];
hint parseText format["<t size='1.25' color='#208000'>Mapclick location successful</t>"];
uisleep 2;
hintSilent "";
openmap [false,false];
    
    private _cam3 = "Land_HandyCam_F" createVehicleLocal (getMarkerPos _mrkrname);
    _cam3 hideObject true;
    _cam3 attachTo [nearestObject [_cam3, "man"], [0, 0, 10]]; // "#track" "#slop" "#mark" "#crater"
    _cam3 setVectorUp [0,0.99,0.01]; // _cam3 setVectorUp [0,0,1]; // 
    _cam3 switchCamera "EXTERNAL";

    _lightsource = "#lightpoint" createVehicleLocal (getPos _cam3);
    _lightsource attachTo [_cam3, [0,0,1]];

titleText ["Top Down View Loaded!          \nPress Left Mouse Button To Fire!\nPress R Key To Reload!        \nPress Right Windows Key To Return!", "PLAIN DOWN", -1];

vehicle player allowDamage false;

_spaceEH1=findDisplay 46 displayAddEventHandler ["MouseButtonDown", {
    if (_this select 1 == 0) then {
        vehicle player forceWeaponFire [currentMuzzle vehicle player, currentWeaponMode vehicle player];
    };
    false
}];
uiNamespace setVariable ["BIS_WL_spaceEH1", _spaceEH1];

_spaceEH2=findDisplay 46 displayAddEventHandler ["KeyDown", {
    if (_this select 1 in actionKeys "ReloadMagazine") then {
        reload vehicle player;
    };
    false
}];
uiNamespace setVariable ["BIS_WL_spaceEH2", _spaceEH2];

_spaceEH3=findDisplay 46 displayAddEventHandler ["KeyDown", {
    if (_this select 1 == 220) then {
        vehicle player switchCamera "INTERNAL";
        detach _lightsource;
        deleteVehicle _lightsource;
        detach _cam3;
        deleteVehicle _cam3;
        deleteMarker _marker;
        vehicle player allowDamage true;
        (findDisplay 46) displayRemoveEventHandler ["MouseButtonDown", uiNamespace getVariable "BIS_WL_spaceEH1"];
        (findDisplay 46) displayRemoveEventHandler ["KeyDown", uiNamespace getVariable "BIS_WL_spaceEH2"];
        (findDisplay 46) displayRemoveEventHandler ["KeyDown", uiNamespace getVariable "BIS_WL_spaceEH3"];
    };
    false
}];
uiNamespace setVariable ["BIS_WL_spaceEH3", _spaceEH3];

