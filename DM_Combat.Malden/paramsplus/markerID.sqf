// paramsplus\markerID.sqf //
private ["_unit","_dead","_varName","_rank","_mrkrCnt","_mrkrName","_mrkrcolor","_marker","_mrkr"];
_unit = _this;    
_varName = vehicleVarName _unit;
_rank = rank _unit;

//if (isMultiplayer) then {player addEventHandler ["Respawn", {params ["_unit", "_corpse"];_unit execVM "paramsplus\markerID.sqf"}]};

switch true do 
  {
  case (!isMultiplayer): {
    if (!(isNil {missionNamespace getVariable "markerCount"})) then
        {
        _mrkrCnt = (missionNamespace getVariable "markerCount") select 2;
        _mrkrCnt = _mrkrCnt + 1;
        missionNamespace setVariable ["markerCount", [_varName,_rank,_mrkrCnt]];
    } else {   
        _mrkrCnt = 1;
        missionNamespace setVariable ["markerCount", [_varName,_rank,_mrkrCnt]];
    };
    _mrkrcolor = switch (_rank) do 
    {
      case "COLONEL":   {"colorblack"};
      case "MAJOR":     {"colorbrown"};
      case "CAPTAIN":   {"colorred"};
      case "LIEUTENANT":  {"colororange"};
      case "SERGEANT":  {"coloryellow"};
      case "CORPORAL":  {"colorgreen"};
      case "PRIVATE":   {"colorblue"};
      default           {"colorwhite"};
    };
    _marker = createMarkerLocal [_varName, getPos _unit];
    _marker setMarkerTypeLocal "mil_start";
    _marker setMarkerColorLocal _mrkrcolor;
    _marker setMarkerTextLocal "";
    _marker setMarkerSizeLocal [.5,.5];
    while {alive _unit} do {
      _marker setMarkerPos getPos _unit;
      _marker setMarkerDir getDir _unit;  
      if (vehicle _unit != _unit) then {_marker setMarkerAlphaLocal 0} else {_marker setMarkerAlphaLocal 1};
      uisleep 0.5;
    };
    deleteMarker _marker;
    if (!(isNil { missionNamespace getVariable "markerCount"})) then
        {
        _mrkrCnt = (missionNamespace getVariable "markerCount") select 2;
        _mrkrCnt = _mrkrCnt + 1;
        missionNamespace setVariable ["markerCount", [_varName,_rank,_mrkrCnt]];
    } else {   
        _mrkrCnt = 1;
        missionNamespace setVariable ["markerCount", [_varName,_rank,_mrkrCnt]];
    };
    _mrkrCnt = (missionNamespace getVariable "markerCount") select 2;  
    _mrkrName = format ["%1_%2",_varName,_mrkrCnt];
    _mrkr = createMarkerLocal [_mrkrName, getPos _unit];
    _mrkr setMarkerTypeLocal "mil_end";
    _mrkr setMarkerColorLocal "ColorBlack";
    _mrkr setMarkerTextLocal "";
    _mrkr setMarkerSizeLocal [.5,.5];
    _mrkr setMarkerAlphaLocal .5;
    };
  case (isMultiplayer): {
      _unit addEventHandler ["Respawn", {
        params ["_unit", "_corpse"];
        _unit setVehicleVarname (vehicleVarname _corpse);
        _unit setIdentity (vehicleVarname _corpse);
        switch (rankID _corpse) do {
            case 1: {_unit setUnitRank "Private"};
            case 2: {_unit setUnitRank "Corporal"};
            case 3: {_unit setUnitRank "Sergeant"};
            case 4: {_unit setUnitRank "Lieutenant"};
            case 5: {_unit setUnitRank "Captain"};
            case 6: {_unit setUnitRank "Colonel"};
        };
        _unit execVM "ParamsPlus\markerID.sqf";
      }];
    _mrkrcolor = switch _rank do 
    {
      case "COLONEL":   {"colorblack"};
      case "MAJOR":     {"colorbrown"};
      case "CAPTAIN":   {"colorred"};
      case "LIEUTENANT":  {"colororange"};
      case "SERGEANT":  {"coloryellow"};
      case "CORPORAL":  {"colorgreen"};
      case "PRIVATE":   {"colorblue"};
      default           {"colorwhite"};
    };
    _marker = createMarkerLocal [_varName, getPos _unit];
    _marker setMarkerTypeLocal "mil_start";
    _marker setMarkerColorLocal _mrkrcolor;
    _marker setMarkerTextLocal "";
    _marker setMarkerSizeLocal [.5,.5];
    while {alive _unit} do {
      _marker setMarkerPos getPos _unit;
      _marker setMarkerDir getDir _unit;  
      if (vehicle _unit != _unit) then {_marker setMarkerAlphaLocal 0} else {_marker setMarkerAlphaLocal 1};
      uisleep 0.5;
    };
    deleteMarker _marker;
    if (!(isNil { _unit getVariable "markerCount"})) then
        {
        _mrkrCnt = (_unit getVariable "markerCount") select 2;
        _mrkrCnt = _mrkrCnt + 1;
        _unit setVariable ["markerCount", [_varName,_rank,_mrkrCnt]];
    } else {   
        _mrkrCnt = 1;
        _unit setVariable ["markerCount", [_varName,_rank,_mrkrCnt]];
    };
    _mrkrCnt = (_unit getVariable "markerCount") select 2;  
    _mrkrName = format ["%1_%2",_varName,_mrkrCnt];
    _mrkr = createMarkerLocal [_mrkrName, getPos _unit];
    _mrkr setMarkerTypeLocal "mil_end";
    _mrkr setMarkerColorLocal "ColorBlack";
    _mrkr setMarkerTextLocal "";
    _mrkr setMarkerSizeLocal [.5,.5];
    _mrkr setMarkerAlphaLocal .5;
   }; 
 };


