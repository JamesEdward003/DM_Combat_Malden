configScore.sqf //
params ["_player"];

_player addEventHandler ["HandleScore", {
    params ["_unit", "_object", "_score"];

    //Score == 1 means you killed one soldier enemy unit (be it in or out of a vehicle)
    if (_score isEqualTo 1) then {
        ["hitMarkerAnimation.sqf"] remoteExec ["execVM", _unit];
    };
}];