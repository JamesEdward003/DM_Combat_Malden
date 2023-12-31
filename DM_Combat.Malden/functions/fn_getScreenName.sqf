    private ["_suppliedtype","_type", "_cfg_type","_data", "_ret"];
    params ["_suppliedtype"];
    if ((typeName _suppliedtype) == "OBJECT") then
        {
        _type = (typeof _suppliedtype);
        }
        else
        {
        _type = _suppliedtype;
        };

    switch (true) do
    {
        case(isClass(configFile >> "CfgMagazines" >> _type)): {_cfg_type = "CfgMagazines"};
        case(isClass(configFile >> "CfgWeapons" >> _type)): {_cfg_type = "CfgWeapons"};
        case(isClass(configFile >> "CfgVehicles" >> _type)): {_cfg_type = "CfgVehicles"};
        case(isClass(configFile >> "CfgGlasses" >> _type)): {_cfg_type = "CfgGlasses"};
    };
    _ret = getText (configFile >> _cfg_type >> _type >> "displayName");
    _ret