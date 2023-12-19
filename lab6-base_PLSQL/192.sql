-- 192.
-- Dla każdego przedmiotu, z którego przeprowadzono egzamin, wskazać tych studentów,
-- którzy zdawali egzamin w ostatnich dwóch dniach egzaminowania z tego przedmiotu.
-- Uporządkować wyświetlane dane wg nazwy przedmiotu, daty oraz nazwiska studenta. Do
-- opisu przedmiotu należy użyć jego nazwy, do opisu studenta – identyfikatora, nazwiska i
-- imienia. Datę należy wyświetlić w formacie YYYY-MM-DD.

-- wersja z wykorzystaniem tylko selecta
select distinct p.NAZWA_PRZEDMIOT, s.ID_STUDENT, s.IMIE, s.NAZWISKO, e.DATA_EGZAMIN
               from EGZAMINY e
                    inner join PRZEDMIOTY p on p.ID_PRZEDMIOT = e.ID_PRZEDMIOT
                    inner join STUDENCI s on s.ID_STUDENT = e.ID_STUDENT
               where e.DATA_EGZAMIN in (select e2.DATA_EGZAMIN
                                        from EGZAMINY e2
                                        where e2.ID_PRZEDMIOT = p.ID_PRZEDMIOT
                                        order by 1 desc fetch first 2 rows only);

-- wersja z kursorem (na sile)
begin
    for vc in (select distinct p.NAZWA_PRZEDMIOT, s.ID_STUDENT, s.IMIE, s.NAZWISKO, e.DATA_EGZAMIN
               from EGZAMINY e
                    inner join PRZEDMIOTY p on p.ID_PRZEDMIOT = e.ID_PRZEDMIOT
                    inner join STUDENCI s on s.ID_STUDENT = e.ID_STUDENT
               where e.DATA_EGZAMIN in (select e2.DATA_EGZAMIN
                                        from EGZAMINY e2
                                        where e2.ID_PRZEDMIOT = p.ID_PRZEDMIOT
                                        order by 1 desc fetch first 2 rows only)) loop
        dbms_output.put_line(vc.NAZWA_PRZEDMIOT || ' ' || vc.ID_STUDENT || ' ' || vc.IMIE || ' ' || vc.NAZWISKO || ' ' || vc.DATA_EGZAMIN);
    end loop;
end;

-- wersja z kursorami niejawnymi
begin
    for vc_przedmiot in (select distinct p.ID_PRZEDMIOT, p.NAZWA_PRZEDMIOT from EGZAMINY e inner join PRZEDMIOTY p on p.ID_PRZEDMIOT = e.ID_PRZEDMIOT) loop
        for vc_egzamin in (select distinct e.DATA_EGZAMIN, e.ID_STUDENT from EGZAMINY e where e.ID_PRZEDMIOT = vc_przedmiot.ID_PRZEDMIOT order by e.DATA_EGZAMIN desc fetch first 2 rows only) loop
            for vc_student in (select distinct s.ID_STUDENT, s.IMIE, s.NAZWISKO from STUDENCI s where s.ID_STUDENT = vc_egzamin.ID_STUDENT) loop
                dbms_output.put_line(vc_przedmiot.NAZWA_PRZEDMIOT || '; ' || vc_egzamin.DATA_EGZAMIN || '; ' || vc_student.IMIE || '; ' || vc_student.NAZWISKO);
            end loop;
        end loop;
    end loop;
end;