waitUntil {!isNil {player}};
waitUntil {player == player};
if (!isNil {player getVariable "Briefing"}) exitWith {};

player setVariable ["Briefing",true];

switch (side player) do 
{
	case WEST: // BLUFOR briefing goes here
	{
	player createDiaryRecord ["Diary", ["Rules Of Play","At game start if the civilians have guns, they are your enemies. In the multiplayer lobby you can select civilians with or without weapons."]];
	player createDiaryRecord ["Diary", ["Rules Of Engagement","Captain Pettka's  10 Rules Of Engagement<br/><br/>Rule #1 - Don't get shot.<br/>Rule #2 - Short, controlled bursts.<br/>Rule #3 - Be proud you are a soldier.<br/>Rule #4 - Watch your bullet drop.<br/>Rule #5 - Patch your wounds.<br/>Rule #6 - Keep a full mag.<br/>Rule #7 - If in doubt, fall back.<br/>Rule #8 - Keep the enemy suppressed.<br/>Rule #9 - Follow orders.<br/>Rule #10 - Beware of confined spaces."]];
	player createDiaryRecord ["Diary", ["Opposition","Enemies are east soldiers or resistance guerillas, and civilians.<br/>If the civilians have obtained weapons, and you would like them to join your team, intercept their path into town by sending one of your men. Along the way the closest civilian to town will trigger a join silent closest group script.<br/><br/>"]];
	player createDiaryRecord ["Diary", ["Help", "Hints from Captain Pettka:<br/>
	- Press 'NUMPAD /' to toggle scope/open sight.<br/>
	- Press '[ or ]' for L and R Panel GPS, radar and miniMap.<br/>
	- Press 'V' twice in rapid succession to Open Parachute!<br/>
	- Use the available supports to overthrow the town!"]];
	};

	case EAST: // OPFOR briefing goes here
	{ 
	player createDiaryRecord ["Diary", ["Rules Of Play","At game start if the civilians have guns, they are your enemies. In the multiplayer lobby you can select civilians with or without weapons."]];
	player createDiaryRecord ["Diary", ["Rules Of Engagement","Colonel Namdar's 10 Rules Of Engagement]]<br/><br/>Rule #1 - Don't get shot.<br/>Rule #2 - Short, controlled bursts.<br/>Rule #3 - Be proud you are a soldier.<br/>Rule #4 - Watch your bullet drop.<br/>Rule #5 - Patch your wounds.<br/>Rule #6 - Keep a full mag.<br/>Rule #7 - If in doubt, fall back.<br/>Rule #8 - Keep the enemy suppressed.<br/>Rule #9 - Follow orders.<br/>Rule #10 - Beware of confined spaces."]];
	player createDiaryRecord ["Diary", ["Opposition","Enemies are west soldiers or resistance guerillas, and civilians.<br/>If the civilians have obtained weapons, and you would like them to join your team, intercept their path into town by sending one of your men. Along the way the closest civilian to town will trigger a join silent closest group script.<br/><br/>"]];
	player createDiaryRecord ["Diary", ["Help", "Hints from Colonel Namdar:<br/>
	- Press 'NUMPAD /' to toggle scope/open sight.<br/>
	- Press '[ or ]' for L and R Panel GPS, radar and miniMap.<br/>
	- Press 'V' twice in rapid succession to Open Parachute!<br/>
	- Use the available supports to overthrow the town!"]];
	};

	case RESISTANCE: // RESISTANCE/INDEPENDENT briefing goes here
	{ 
	player createDiaryRecord ["Diary", ["Rules Of Play","At game start if the civilians have guns, they are your enemies. In the multiplayer lobby you can select civilians with or without weapons."]];
	player createDiaryRecord ["Diary", ["Rules Of Engagement","Colonel Akhanteros' 10 Rules Of Engagement]]<br/><br/>Rule #1 - Don't get shot.<br/>Rule #2 - Short, controlled bursts.<br/>Rule #3 - Be proud you are a soldier.<br/>Rule #4 - Watch your bullet drop.<br/>Rule #5 - Patch your wounds.<br/>Rule #6 - Keep a full mag.<br/>Rule #7 - If in doubt, fall back.<br/>Rule #8 - Keep the enemy suppressed.<br/>Rule #9 - Follow orders.<br/>Rule #10 - Beware of confined spaces."]];
	player createDiaryRecord ["Diary", ["Opposition","Enemies are west or east soldiers, and civilians.<br/>If the civilians have obtained weapons, and you would like them to join your team, intercept their path into town by sending one of your men. Along the way the closest civilian to town will trigger a join silent closest group script.<br/><br/>"]];
	player createDiaryRecord ["Diary", ["Help", "Hints from Colonel Akhanteros:<br/>
	- Press 'NUMPAD /' to toggle scope/open sight.<br/>
	- Press '[ or ]' for L and R Panel GPS, radar and miniMap.<br/>
	- Press 'V' twice in rapid succession to Open Parachute!<br/>
	- Use the available supports to overthrow the town!"]];
	};

	case CIVILIAN: // CIVILIAN briefing goes here
	{ 
	player createDiaryRecord ["Diary", ["Rules Of Play","If as a civilian you have guns, determine your enemies. In the multiplayer lobby you can select civilians with or without weapons."]];
	player createDiaryRecord ["Diary", ["Rules Of Engagement","Colonel Mylonaki's 10 Rules Of Engagement]]<br/><br/>Rule #1 - Don't get shot.<br/>Rule #2 - Short, controlled bursts.<br/>Rule #3 - Be proud you are a civilian.<br/>Rule #4 - Watch your bullet drop.<br/>Rule #5 - Patch your wounds.<br/>Rule #6 - Keep a full mag.<br/>Rule #7 - If in doubt, fall back.<br/>Rule #8 - Keep the enemy suppressed.<br/>Rule #9 - Follow orders.<br/>Rule #10 - Beware of confined spaces."]];
	player createDiaryRecord ["Diary", ["Opposition","Civilians either have weapons or they don't. Adjust accordingly. Enemies can be west, east, or resistance. On the way into town you will encounter a join silent trigger that will join you and your group to the closest engaging group.<br/><br/>"]];
	player createDiaryRecord ["Diary", ["Help", "Hints from Colonel Mylonaki:<br/>
	- Press 'NUMPAD /' to toggle scope/open sight.<br/>
	- Press '[ or ]' for L and R Panel GPS, radar and miniMap.<br/>
	- Press 'V' twice in rapid succession to Open Parachute!<br/>
	- Use the available supports to overthrow the town!"]];
	};
};
waitUntil { (isServer || !isNull player) };

[playerSide, "HQ"] commandChat "Briefing Done!";

player addEventHandler ["Killed", {
	private ["_unit","_killer"];
	_unit = _this select 0;
	_killer = _this select 1;
	[] spawn {
		waitUntil {alive player};
		waitUntil {!isNil {player getVariable "Briefing"}};
	};
}];


