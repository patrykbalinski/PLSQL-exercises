-- 194.
-- Dla każdego roku wskazać ten przedmiot, z którego egzamin zdawało najwięcej osób.
-- W zbiorze wynikowym umieścić dane o numerze roku (4 cyfry), nazwie przedmiotu oraz
-- liczbie egzaminowanych osób. Uporządkować ten zbiór według roku i nazwy przedmiotu.

select extract(year from e.DATA_EGZAMIN), p.NAZWA_PRZEDMIOT, count(e.ID_EGZAMIN) from EGZAMINY e
inner join PRZEDMIOTY p on p.ID_PRZEDMIOT = e.ID_PRZEDMIOT
group by extract(year from e.DATA_EGZAMIN), p.NAZWA_PRZEDMIOT
having count(e.ID_EGZAMIN) = (select max(count(*))
                              from EGZAMINY e2
                              where extract(year from e2.DATA_EGZAMIN) = extract(year from e.DATA_EGZAMIN)
                              group by extract(year from e2.DATA_EGZAMIN), e2.ID_PRZEDMIOT);

begin
    for vc_rok in (select distinct extract(year from e.DATA_EGZAMIN) rok from EGZAMINY e order by 1) loop
        dbms_output.put_line('ROK: ' || vc_rok.rok);

        for vc_egzaminy in (select max(count(e.ID_EGZAMIN)) max_liczba_egzaminow
                            from EGZAMINY e
                            where extract(year from e.DATA_EGZAMIN) = vc_rok.rok
                            group by extract(year from e.DATA_EGZAMIN), e.ID_PRZEDMIOT) loop
            for vc_przedmiot in (select p.NAZWA_PRZEDMIOT, count(e.ID_EGZAMIN) liczba_egzaminow
                                 from EGZAMINY e
                                   inner join PRZEDMIOTY p on p.ID_PRZEDMIOT = e.ID_PRZEDMIOT
                                 where extract(year from e.DATA_EGZAMIN) = vc_rok.rok
                                 group by extract(year from e.DATA_EGZAMIN), p.ID_PRZEDMIOT, p.NAZWA_PRZEDMIOT
                                 having count(e.ID_EGZAMIN) = vc_egzaminy.max_liczba_egzaminow) loop
                dbms_output.put_line('  ' || vc_przedmiot.NAZWA_PRZEDMIOT || ' -> ' || vc_egzaminy.max_liczba_egzaminow);
            end loop;
        end loop;
    end loop;
end;