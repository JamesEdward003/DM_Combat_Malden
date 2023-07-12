// fn_initColoredTimer.sqf // REN_fnc_initColoredTimer
// [round triggerTimeoutCurrent trg0] call  REN_fnc_initColoredTimer; // round triggerTimeoutCurrent trg0; 

_duration = _this select 0;
/*
 _color = "#45f442";  
 _timeLeft = sv_currentTime - time;
 if (_timeLeft < 16) then {_color = "#eef441";};
 if (_timeLeft < 6) then {_color = "#ff0000";}; 
 if (_timeLeft < 0) exitWith { 
  removeMissionEventhandler ["EachFrame",_thisEventHandler]; 
  hintSilent parseText format ["<t color='%1'>--- No Time Left! ---</t>",_color]; 
};

 hintSilent parseText format ["Time To Bug Out!:<br/><t color='%1'>--- %2 ---</t>", _color, [(_timeLeft/3600),"HH:MM:SS"] call BIS_fnc_timetostring]; 


 _duration = round triggerTimeoutCurrent trg0; 
sv_currentTime = time + _duration; 
addMissionEventHandler ["EachFrame",{[] call REN_fnc_initColoredTimer}];


//function:
TAG_fnc_coloredCountdownHint = {
    _color = "#45f442";//green
    _timeLeft = TAG_fnc_countdownEndTime - time;
    if (_timeLeft < 16) then {_color = "#eef441";};//yellow
    if (_timeLeft < 6) then {_color = "#ff0000";};//red
    if (_timeLeft < 0) exitWith {
        //exit and remove eventhandler while politely closing the door
        removeMissionEventhandler ["EachFrame",_thisEventHandler];
        hintSilent parseText format ["<t color='%1'>--- Time is up! ---</t>",_color];
    };
    hintSilent parseText format ["Time Left:<br/><t color='%1'>--- %2 ---</t>", _color, [(_timeLeft/3600),"HH:MM:SS"] call BIS_fnc_timetostring];
};

//calling the function:
_duration = 20;
TAG_fnc_countdownEndTime = time + _duration;
addMissionEventHandler ["EachFrame",{[] call TAG_fnc_coloredCountdownHint}];

0 = [] spawn {
    private _duration = 20;
    
    if (isServer) then { [ _duration, true ] call BIS_fnc_countdown };
    
    waitUntil{ [ true ] call BIS_fnc_countdown };
    
    while{ [ true ] call BIS_fnc_countdown } do {
        private _timeLeft = [ 0 ] call BIS_fnc_countdown;
        private _colorHTML = [
            linearConversion[ 0, _duration, _timeLeft, 1, 0 ],
            linearConversion[ 0, _duration, _timeLeft, 0, 1 ], 
            0
        ] call BIS_fnc_colorRGBtoHTML;
        
        hintSilent parseText format[ "Time Left:<br/><t color= '%1'>--- %2 ---</t>", _colorHTML, [ _timeLeft, "HH:MM:SS" ] call BIS_fnc_secondsToString ];
        uiSleep ( _timeLeft min 1 );
    };

    hintSilent parseText "<t color='#FF0000'>--- Time is up! ---</t>";
};

call {sv_currentTime = round triggerTimeoutCurrent trg0; TAG_fnc_coloredCountdownHint = { 
 _color = "#45f442"; _timeLeft = TAG_fnc_countdownEndTime - time; 
 if (_timeLeft < 16) then {_color = "#eef441";};
 if (_timeLeft < 6) then {_color = "#ff0000";}; 
 if (_timeLeft < 0) exitWith { 
  removeMissionEventhandler ["EachFrame",_thisEventHandler]; 
  hintSilent parseText format ["<t color='%1'>--- Time is up! ---</t>",_color]; 
 }; 
 hintSilent parseText format ["Time Left:<br/><t color='%1'>--- %2 ---</t>", _color, [(_timeLeft/3600),"HH:MM:SS"] call BIS_fnc_timetostring]; 
}; 
 _duration = sv_currentTime; 
TAG_fnc_countdownEndTime = time + _duration; 
addMissionEventHandler ["EachFrame",{[] call TAG_fnc_coloredCountdownHint}];};

*/  

// [[round triggerTimeoutCurrent trg0], {REN_fnc_initColoredTimer}] remoteExec ["call", 0];

0 = [] spawn {
  private _duration = round triggerTimeoutCurrent trg0;
  private "_color";
  [_duration,true] call BIS_fnc_countdown;
  waitUntil {!isNil "BIS_fnc_countdown_time"};
  _time = BIS_fnc_countdown_time;

  for "_i" from _duration to 0 step -1 do {
    call {
      if (_i < 6) exitWith {_color = "#ff0000"};
      if (_i < 16) exitWith {_color = "#eef441"};
      if (_i > 15) exitWith {_color = "#45f442"};
    };
    _tt = [{serverTime},{time}];
    hintSilent parseText format ["Time Left:<br/><t color= '%1'>--- %2 ---</t>", _color, [(_time - _tt)/3600,"HH:MM:SS"] call BIS_fnc_timetostring];
    uisleep 1;
  };
  
  uisleep 1;
  hintSilent parseText format ["<t color='%1'>--- Time is up! ---</t>",_color];
};

0 = [] spawn {
    private _duration = round triggerTimeoutCurrent trg0;
    
    if (isServer) then { [ _duration, true ] call BIS_fnc_countdown };
    
    waitUntil{ [ true ] call BIS_fnc_countdown };
    
    while{ [ true ] call BIS_fnc_countdown } do {
        private _timeLeft = [ 0 ] call BIS_fnc_countdown;
        private _colorHTML = [
            linearConversion[ 0, _duration, _timeLeft, 1, 0 ],
            linearConversion[ 0, _duration, _timeLeft, 0, 1 ], 
            0
        ] call BIS_fnc_colorRGBtoHTML;
        
        hintSilent parseText format[ "Time Left:<br/><t color= '%1'>--- %2 ---</t>", _colorHTML, [ _timeLeft, "HH:MM:SS" ] call BIS_fnc_secondsToString ];
        uiSleep ( _timeLeft min 1 );
    };

    hintSilent parseText "<t color='#FF0000'>--- Time is up! ---</t>";
};

call {[] spawn { private ["_duration","_color"];
  private _duration = round triggerTimeoutCurrent trg0; 

  if (isServer) then {[_duration,true] call BIS_fnc_countdown};
  waitUntil {!isNil "BIS_fnc_countdown_time"};
  _time = BIS_fnc_countdown_time;

  for "_i" from _duration to 0 step -1 do {
    call {
      if ((_i > 0) && (_i < 21)) then {_color = "#FF0000"};
      if ((_i > 19) && (_i < 60)) then {_color = "#FF5500"};
      if (_i > 59) then {_color = "#45F442"};
    };
    _tt = time; //if isMultiplayer then [{serverTime},{time}];
    hintSilent parseText format ["Time Left:<br/><t color= '%1'>--- %2 ---</t>", _color, [(_time - _tt)/3600,"HH:MM:SS"] call BIS_fnc_timetostring];
    uisleep 1;
    if (_time < 1) then {breakTo "outside"};
  };
  scopeName "outside";
  uisleep 1;
  hintSilent parseText format ["<t color='%1'>--- Time is up! ---</t>",_color];
};};

