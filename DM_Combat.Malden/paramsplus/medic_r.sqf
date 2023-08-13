// "paramsplus\medic_r.sqf" //
private ["_unit"];
_unit = _this;
comment "Exported from Arsenal by RENFRO";

comment "[!] UNIT MUST BE LOCAL [!]";
//if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "arifle_MX_GL_Black_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_MRCO";
_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_black_mag";
_unit addWeapon "hgun_Pistol_heavy_01_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_I_OfficerUniform";
_unit addVest "V_TacVest_camo";
_unit addBackpack "B_AssaultPack_dgtl";

comment "Add binoculars";
_unit addMagazine "Laserbatteries";
_unit addWeapon "Laserdesignator";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "SmokeShellGreen";};
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
for "_i" from 1 to 8 do {_unit addItemToVest "FirstAidKit";};
for "_i" from 1 to 3 do {_unit addItemToVest "11Rnd_45ACP_Mag";};
_unit addItemToBackpack "Medikit";
for "_i" from 1 to 5 do {_unit addItemToBackpack "30Rnd_65x39_caseless_black_mag";};
_unit addItemToBackpack "3Rnd_HE_Grenade_shell";
_unit addHeadgear "H_MilCap_dgtl";
_unit addGoggles "G_EyeProtectors_Earpiece_F";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "I_UavTerminal";
_unit linkItem "NVGoggles_INDEP";

comment "Set identity";
[_unit,"Hladas","male05gre"] call BIS_fnc_setIdentity;
