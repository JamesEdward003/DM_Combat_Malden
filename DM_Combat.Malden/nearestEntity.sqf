// nearestEntity.sqf //
_unit = _this select 0;
_dist = 3000;

//_nearEntities = _unit nearEntities [["BLU_F","BLU_G_F","BLU_T_F","BLU_CTRG_F","BLU_GEN_F","BLU_W_F","OPF_F","OPF_G_F","OPF_T_F","OPF_R_F","IND_F","IND_G_F","IND_C_F","IND_E_F","IND_L_F"], 300];
//_nearEntities = _unit nearEntities ["ALL", 300];
//_entities = entities [["BLU_F","BLU_G_F","BLU_T_F","BLU_CTRG_F","BLU_GEN_F","BLU_W_F","OPF_F","OPF_G_F","OPF_T_F","OPF_R_F","IND_F","IND_G_F","IND_C_F","IND_E_F","IND_L_F"], ["CIV_F","CIV_IDAP_F"], false, true];
_entities = entities [["SoldierWB","SoldierEB","SoldierGB"], ["Civilian_F"], false, true];

_nearestEntity = [_entities, _unit] call BIS_fnc_nearestPosition;

hintSilent parseText format ["<t color='#bb00ff' size='1.0'>Civilians Join The Revolution!</t>"];
{
    if ((side _x == side _unit) and ((_x distance _nearestEntity) <= _dist)) then
    {
        [_x] join grpNull;
        [_x] joinSilent (group _nearestEntity);
    };
} forEach allUnits;
/*
//(group _nearestEntity) selectLeader (leader _nearestEntity);
[group _nearestEntity, leader _nearestEntity] remoteExec ["selectLeader", groupOwner group _nearestEntity];

[group _nearestEntity, 1] setWPPos [0,0,0];
_pos = getWPPos [_group1, 1]; // returns [200, 600, 0]

_nearestCity = nearestLocation [getPos _nearestEntity, "nameCity"];

wp0 = (group _nearestEntity) addwaypoint [_nearestCity, 20];
wp0 setwaypointtype "MOVE"; 
wp0 setWaypointBehaviour "AWARE";
wp0 setWaypointCombatMode "RED";
wp0 setWaypointSpeed "NORMAL";
wp0 setWaypointStatements ["true",""];
*/
/*
if (_x in (_x nearEntities [["BLU_F","BLU_G_F","BLU_T_F","BLU_CTRG_F","BLU_GEN_F","BLU_W_F"], 1000]))

_nearestGroup = [["Rambo","Snake","Viper","Nazari","Namdar","Attar","Rosco","Kouris","Elias"], this Triggering entity] call BIS_fnc_nearestPosition;

["Revolution","Jester","Cosmos"]

nearestObjects [player, ["house"], 1000];

player nearEntities ["Man", 1000];

_nearestEntities = nearestObjects [_unit, ["man"], 1000];

_nearestEntity = _nearestEntities select 0;

BLU_F (NATO)
BLU_G_F (FIA)
BLU_T_F (Pacific NATO, Apex Expansion)
BLU_CTRG_F (Pacific CTRG, Apex Expansion)
BLU_GEN_F (Gendarmerie, Apex Expansion)
BLU_W_F (Woodland NATO, Contact Expansion)

OPF_F (Iranian CSAT)
OPF_G_F (FIA)
OPF_T_F (Chinese CSAT, Apex Expansion)
OPF_R_F (Spetznatz, Contact Expansion)

IND_F (AAF)
IND_G_F (FIA)
IND_C_F (Syndikat, Apex Expansion)
IND_E_F (LDF, Contact Expansion)
IND_L_F (Looters, Contact Expansion)

CIV_F
CIV_IDAP_F (Laws of War DLC)

*/