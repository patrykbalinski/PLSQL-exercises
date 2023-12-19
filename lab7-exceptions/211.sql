-- 211.
-- Który egzaminator i kiedy egzaminował więcej niż 5 osób w ciągu jednego dnia? Podać
-- identyfikator, Nazwisko i imię egzaminatora, a także informacje o liczbie egzaminowanych
-- osób oraz dniu, w których takie zdarzenie miało miejsce. Zadanie wykonać wykorzystując
-- wyjątek użytkownika.

select eg.ID_EGZAMINATOR, eg.NAZWISKO, eg.IMIE, e.DATA_EGZAMIN, count(distinct e.ID_STUDENT)
from EGZAMINY e
inner join EGZAMINATORZY eg on eg.ID_EGZAMINATOR = e.ID_EGZAMINATOR
group by eg.ID_EGZAMINATOR, eg.NAZWISKO, eg.IMIE, e.DATA_EGZAMIN
having count(e.ID_EGZAMIN) > 3;

declare
    more_than_five_exams_exception exception;
begin
    for vc_exams in (select eg.ID_EGZAMINATOR, eg.NAZWISKO, eg.IMIE, e.DATA_EGZAMIN, count(distinct e.ID_STUDENT) exams_number
                     from EGZAMINY e
                         inner join EGZAMINATORZY eg on eg.ID_EGZAMINATOR = e.ID_EGZAMINATOR
                     group by eg.ID_EGZAMINATOR, eg.NAZWISKO, eg.IMIE, e.DATA_EGZAMIN) loop
        begin
            if vc_exams.exams_number > 3 then
                raise more_than_five_exams_exception;
            end if;
        exception when more_than_five_exams_exception then
            dbms_output.put_line(vc_exams.ID_EGZAMINATOR || ', ' || vc_exams.NAZWISKO || ' ' || vc_exams.IMIE || ': ' || to_char(vc_exams.DATA_EGZAMIN, 'dd.mm.yyyy') || ' (' || vc_exams.exams_number || ')');
        end;
    end loop;
end;