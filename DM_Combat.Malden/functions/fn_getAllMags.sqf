    params[ "_playerID", "_containerID", "_type" ];
    
    _player = _playerID call BIS_fnc_objectFromNetId;
    _container = _containerID call BIS_fnc_objectFromNetId;
    
    _mags = magazinesAmmoCargo _container call BIS_fnc_consolidateArray;
    
    _weapon = _player call compile format[ "%1weapon _this", _type ];
    _weaponCfg = configFile >> "CfgWeapons" >> _weapon;
    _compatibleMags = [];
    {
        if ( _x == "this" ) then {
            _compatibleMags = _compatibleMags + getArray( _weaponCfg >> "magazines" );
        }else{
            _compatibleMags = _compatibleMags + getArray( _weaponCfg >> _x >> "magazines" );
        };
    } forEach getArray( _weaponCfg >> "muzzles" );
        
    {
        _magType = _x;
        {
            _x params[ "_magInfo", "_count" ];
            _magInfo params[ "_mag", "_ammo" ];
            
            if ( _mag == _magType ) then {
                _taken = for "_i" from 1 to _count do {
                    if !( _player canAdd _mag ) exitWith { _i - 1 };
                    _player addMagazine [ _mag, _ammo ];
                };
                systemChat format[ "Taken %1 %2", if ( isNil "_taken" ) then { _count }else{ _taken }, _mag ];
            };
        } forEach _mags;
    } forEach _compatibleMags;