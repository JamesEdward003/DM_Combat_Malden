// fn_initCountDownTimer.sqf // REN_fnc_initCountdownTimer
// Initialize the countdown timer for all players
sv_currentTime = _this select 0;
[ "itemAdd", [ 
    "countdownTimer", {     
        sv_currentTime = sv_currentTime - 1;
        if (sv_currentTime isEqualTo 0) then {
            sv_currentTime = nil;
            "EveryoneLost" call BIS_fnc_endMissionServer;
        };
    }, 
    1, "seconds", {
        !isNil "sv_currentTime" && {sv_currentTime >= 0}
    }
] ] call BIS_fnc_loop; 



// Here's how I like to display the timer (via hint message):
sxf_fnc_loopMessage = { 
    _output = "";
    _timerMessage = ""; 
    
    if (!isNil "sv_currentTime") then {
        _timerMessage = _timerMessage + "<t size='1.3'>Time remaining:</t><br/>";
        _timerMessage = _timerMessage + format["<t size='2' align='center' color='#F1BD1D'>%1m %2s</t>", floor (sv_currentTime/60), sv_currentTime%60];
    };  
    
    _output = (
        "<br/><t align='left'>" +
        _timerMessage +
        "<br/><br/></t>"
    );
    
    {   //show the mission info hint message only to the players who have their loop message turned ON
        if (_x getVariable ["sxf_bLoopEnabled", false]) then {
            (parseText _output) remoteExec ["hintSilent", _x];
        };
    } forEach (call BIS_fnc_listPlayers);
};
[ "itemAdd", [ "loopMessage", { call sxf_fnc_loopMessage; }, 1, "seconds", {
  { _x getVariable ["sxf_bLoopEnabled", false] } count (call BIS_fnc_listPlayers) > 0  
} ] ] call BIS_fnc_loop;


/* Allow the players to toggle the looping hint message described above:
//(move everything below this line to initPlayerServer.sqf if you want it to work for JIPs, I guess
{!(IsNull (findDisplay 46))} remoteExec ["waitUntil"];
[(findDisplay 46), "KeyDown"] remoteExec ["displayRemoveAllEventHandlers"];
[
    (findDisplay 46),
    [
        "KeyDown",
        {
            if (!isDedicated && {!isNil "sxf_fnc_handleKey_F1"}) then {
                sxf_fnc_handleKey_F1 = {
                    _temp = player getVariable ['sxf_bLoopEnabled', false];
                    if (_temp) then {hintSilent '';};
                    playSound ( ['AddItemFailed', 'AddItemOK'] select !_temp );
                    player setVariable ['sxf_bLoopEnabled', !_temp, true];
                };
            };
            if ( (_this select 1) in ( (actionKeys 'User1') OR [0x3b] ) ) then {call sxf_fnc_handleKey_F1;};
        }
    ]
] remoteExec ["displayAddEventHandler"];
*/

