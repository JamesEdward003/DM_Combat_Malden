    private ["_Title","_vitalbox1","_wepboxarray","_contentsbox","_c","_w","_n"];
    params ["_Title","_vitalbox1","_wepboxarray"];
    _location = _vitalbox1 call BIS_fnc_locationDescription;
    _location_contentsbox = format ["Location: %1<br/>Contents:<br/>",_location];    

    if (true) then
    {
        _c=count _wepboxarray;
        for [ {_i=0}, {_i<_c}, {_i=_i+1} ] do
        {
            _w = _wepboxarray select _i;
            sleep 0.1;
            _n = _w call REN_fnc_getScreenName;
            sleep 0.1;
            _location_contentsbox = _location_contentsbox + format["%1 : %2<br/>",_n,_w];
            sleep 0.1;
        };        
        if (player diarySubjectExists _Title) then {
        //    hint format ["Diary Subject Exists: %1",(player diarySubjectExists _Title)];
            player removeDiarySubject _Title;
            player createDiarySubject [_Title,_Title];
            player createDiaryRecord [_Title, [_Title, _location_contentsbox]];
        } else {
        //    hint format ["Diary Subject Exists: %1",(player diarySubjectExists _Title)];
            player createDiarySubject [_Title,_Title];
            player createDiaryRecord [_Title, [_Title, _location_contentsbox]];
        }

    } else {
        titleText ["Box is null", "PLAIN DOWN", -1];
    };
    
/*
_exists = player diarySubjectExists "subjectName"

player createDiarySubject ["myPage","My page"];

player removeDiarySubject "myPage";

[diaryName] call BIS_fnc_selectDiarySubject

player createDiaryRecord [subject, text, task, taskState, showTitle]

player createDiaryRecord [subject, [title, text], task, taskState, showTitle]

_exists = player diarySubjectExists "subjectName"

player createDiarySubject [subject, displayName, picture]


player setDiaryRecordText [["Diary", diaryRecord], [_Title, _contentsbox]]

*/