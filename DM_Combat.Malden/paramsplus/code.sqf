// paramsplus\code.sqf //
//this addAction ["get weapon1","code.sqf", ["arifle_TRG20_F", ["optic_Nightstalker", "muzzle_snds_M", "acc_flashlight"]]];
//this addAction ["get weapon2","code.sqf", ["arifle_MXM_F", ["muzzle_snds_H_snd_F", "acc_pointer_IR", "optic_Hamr", "bipod_01_F_snd"]]];

_group = createGroup west;
//_unit = _group createUnit [ "B_Soldier_F", [0, 0, 0], [], 0, "CAN_COLLIDE" ];
_unit = _group createUnit [ "B_Soldier_F", position player, [], 0, "CAN_COLLIDE" ];

waitUntil { !isNull _unit };
//hideObjectGlobal _unit;

removeAllWeapons _unit;
_unit addWeapon ((_this select 3) select 0);

_weapon = primaryWeapon _unit;
_container = backpackContainer player;

{
  _unit addPrimaryWeaponItem _x;
  waitUntil { _x in ( _unit weaponAccessories _weapon ) };
} forEach ((_this select 3) select 1);

_unit action [ "DropWeapon", _container, _weapon ];
sleep 2;

deleteVehicle _unit;
deleteGroup _group;
