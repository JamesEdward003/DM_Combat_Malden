
titleText ["Press any key to hint number\n  Right windows key to quit!", "PLAIN DOWN", 3];

[] spawn {
    disableSerialization;
    _spaceEH = (findDisplay 46) displayAddEventHandler ["KeyDown", {
        if !(_this # 1 == 220) then {
            hint str _this;
        };
        if (_this # 1 == 220) then {
            (findDisplay 46) displayRemoveEventHandler ["KeyDown", uiNamespace getVariable "BIS_WL_spaceEH"];
        };
    }];
    uiNamespace setVariable ["BIS_WL_spaceEH", _spaceEH];
};

