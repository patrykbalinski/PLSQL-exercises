-- 193.
-- Dla poszczególnych lat wskazać tego studenta, który w danym roku zdawał najwięcej
-- egzaminów. W zbiorze wynikowym należy umieścić dane o roku, studencie i liczbie
-- egzaminów. Do opisu roku proszę użyć 4 cyfr. Studenta należy opisać jego
-- identyfikatorem, nazwiskiem i imieniem. Uporządkować dane wynikowe wg roku i
-- nazwiska studenta.

-- wersja na instrukcji select
select extract(year from e.DATA_EGZAMIN) rok, s.ID_STUDENT, s.IMIE, s.NAZWISKO, count(e.ID_EGZAMIN) from EGZAMINY e
inner join STUDENCI s on s.ID_STUDENT = e.ID_STUDENT
group by extract(year from e.DATA_EGZAMIN), s.ID_STUDENT, s.IMIE, s.NAZWISKO
having count(e.ID_EGZAMIN) = (select max(count(e2.ID_EGZAMIN))
                              from EGZAMINY e2
                              where extract(year from e2.DATA_EGZAMIN) = extract(year from e.DATA_EGZAMIN)
                              group by extract(year from e2.DATA_EGZAMIN), e2.ID_STUDENT)
order by 1;

begin
    for vc_lata in (select distinct extract(year from e.DATA_EGZAMIN) rok from EGZAMINY e order by 1) loop

        dbms_output.put_line('ROK: ' || vc_lata.rok);

        for vc_student in (select s.ID_STUDENT, s.IMIE, s.NAZWISKO, count(e.ID_EGZAMIN) liczba_egzaminow
                       from EGZAMINY e
                           inner join STUDENCI s on s.ID_STUDENT = e.ID_STUDENT
                       where extract(year from e.DATA_EGZAMIN) = vc_lata.rok
            group by s.ID_STUDENT, s.IMIE, s.NAZWISKO
            having count(e.ID_EGZAMIN) = (select max(count(e.ID_EGZAMIN))
                                          from EGZAMINY e2
                                          where extract(year from e2.DATA_EGZAMIN) = vc_lata.rok
                                          group by e2.ID_STUDENT, extract(year from e2.DATA_EGZAMIN))) loop

                dbms_output.put_line('  ' || vc_student.NAZWISKO || ' ' || vc_student.IMIE || ': ' || vc_student.liczba_egzaminow);
        end loop;
    end loop;
end;