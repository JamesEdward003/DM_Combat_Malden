// fn_BisCountdownHint.sqf // [round triggerTimeoutCurrent trg0, "#FF5500"] spawn REN_fnc_BisCountdownHint;
// _colour = "#45f442";//green _colour = "#eef441"; //yellow _colour = "#ff0000"; //red
private ["_time","_colour","_timeout","_timeFormat","_remainingTime"];
    params ["_time","_colour"];
    _timeout = time + _time;
    while { time < _timeout } do
    {
        private _remainingTime = _timeout - time;
        private _timeFormat = [_remainingTime, "MM:SS", false] call BIS_fnc_secondsToString;
        
        private _text = format ["<t align='left' color='%2'>                The zombies are coming!<br/>                Time to bug out: %1</t>",_timeFormat,_colour];
        hintSilent parseText _text;
        sleep 1;
    };
    _colour = "#ff0000";
    hintSilent parseText format ["<t align='left' color='%2'>                The zombies are here!<br/>                Time to bug out: %1</t>",0,_colour]; 

//  [[], {hintSilent parseText _text}] remoteExec ["call", 0];
//  _timeLeft = [0] call BIS_fnc_countdown;
//  call BIS_fnc_missionTimeLeft
//  estimatedTimeLeft
//  //private _timeFormat = [_remainingTime] call BIS_fnc_countdown;
//  //private _timeFormat = [_remainingTime] call BIS_fnc_countdown;
