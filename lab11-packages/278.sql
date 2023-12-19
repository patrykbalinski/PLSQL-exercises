-- 278.
-- Utworzyć pakiet o nazwie Pcg_Intg_Egzaminy, który umożliwi kontrolę integralności
-- danych wprowadzanych do tabeli Egzaminy. Pakiet powinien zawierać dwa podprogramy.
-- Pierwszy z nich będzie realizował funkcjonalność związaną z kontrolą daty egzaminu (nie
-- może być większa niż bieżąca data systemowa). Drugi podprogram powinien zapewnić, by
-- data zdanego egzaminu przez studenta z danego przedmiotu nie była wcześniejsza niż data
-- egzaminu niezdanego, w przypadku wystąpienia takiego egzaminu. W oby przypadkach
-- należy przyjąć datę systemową jako datę egzaminu, jeśli została naruszona poprawność
-- danych.

create or replace package Pcg_Intg_Egzaminy as
    function correctExamDateNotGreaterThanSysdate(examDate date) return date;
    function correctExamDateGreaterThanFailureExamDate(examDate date, studentID STUDENCI.ID_STUDENT%type, examID EGZAMINY.ID_EGZAMIN%type) return date;
end Pcg_Intg_Egzaminy;

create or replace package body Pcg_Intg_Egzaminy as

    function correctExamDateNotGreaterThanSysdate(examDate date) return date is
        v_res date;
    begin
        if examDate > sysdate then
            v_res := sysdate;
        else
            v_res := examDate;
        end if;
        return v_res;
    end;

    function correctExamDateGreaterThanFailureExamDate(examDate date, studentID STUDENCI.ID_STUDENT%type, subjectID EGZAMINY.ID_PRZEDMIOT%type) return date is
        v_res date;
        v_lastFailedExamDate date;
    begin
        select max(e.DATA_EGZAMIN) into v_lastFailedExamDate from EGZAMINY e where e.ID_PRZEDMIOT = subjectID and e.ID_STUDENT = studentID and e.ZDAL = 'N';

        if examDate < v_lastFailedExamDate then
            v_res := sysdate;
        else
            v_res := examDate;
        end if;

        return v_res;
    end;

end Pcg_Intg_Egzaminy;


select * from studenci;