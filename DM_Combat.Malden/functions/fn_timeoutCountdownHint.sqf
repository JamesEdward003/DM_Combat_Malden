// fn_timeoutCountdownHint.sqf // REN_fnc_timeoutCountdownHint
private ["_time","_colour","_timeout","_timeFormat","_remainingTime"];
    params [
        ["_time", 30, [0]],
        ["_colour", "#FF5500", [""]]
    ];
    private _timeout = time + _time;
    RscFiringDrillTime_done = false;
    //1 cutRsc ["RscFiringDrillTime", "PLAIN"];
    while { time < _timeout } do
    {
        private _remainingTime = _timeout - time;
        private _timeFormat = [_remainingTime, "MM:SS", true] call BIS_fnc_secondsToString;
        private _text = format ["<t align='left' color='%1'>                The zombies are coming!<br/>                Time to bug out: <img image='%2'/>%3:%4<t size='0.8'>.%5</t>",
            _colour,
            "A3\Modules_F_Beta\data\FiringDrills\timer_ca",
            _timeFormat select 0,
            _timeFormat select 1,
            _timeFormat select 2
        ];
        RscFiringDrillTime_current = [[], {hintSilent parseText _text}] remoteExec ["call", 0];
        sleep 0.01;
    };
    private _timeFormat = [0, "MM:SS", true] call BIS_fnc_secondsToString;
    RscFiringDrillTime_current = hintSilent parseText format ["<t align='left' color='%1'>                The zombies are here!<br/>       No more time to bug out! <img image='%2'/>%3:%4<t size='0.8'>.%5</t>",
        _colour,
        "A3\Modules_F_Beta\data\FiringDrills\timer_ca",
        _timeFormat select 0,
        _timeFormat select 1,
        _timeFormat select 2]; [[], {RscFiringDrillTime_current}] remoteExec ["call", 0];
    sleep 4;
    RscFiringDrillTime_done = true;

//  [[], {hintSilent parseText _text}] remoteExec ["call", 0];
//  _timeLeft = [0] call BIS_fnc_countdown;