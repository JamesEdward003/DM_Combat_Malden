    private ["_weapontype","_magazines","_muzzles"];
    params ["_weapontype"];

    _magazines = []; 
    _muzzles = getArray(configfile >> "cfgWeapons" >> _weapontype >> "muzzles"); 
 
    if ("this" in _muzzles) then { 
        _muzzles = _muzzles - ["this"]; 
        _magazines = _magazines + [(getArray(configfile >> "cfgWeapons" >> _weapontype >> "magazines")) select 0]; 
    }; 
    { 
        _m = [(getArray(configfile >> "cfgWeapons" >> _weapontype >> _x >> "magazines")) select 0]; 
        _magazines = _magazines - _m; 
        _magazines = _magazines + _m; 
    }forEach _muzzles; 
    _magazines