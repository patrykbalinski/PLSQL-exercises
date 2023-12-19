-- 190
-- Wskazać trzy przedmioty, z których przeprowadzono najwięcej egzaminów.
-- W odpowiedzi umieścić nazwę przedmiotu oraz liczbę egzaminów.

select p.NAZWA_PRZEDMIOT, count(e.ID_EGZAMIN) from EGZAMINY e
    inner join PRZEDMIOTY p on p.ID_PRZEDMIOT = e.ID_PRZEDMIOT
group by p.NAZWA_PRZEDMIOT
having count(e.ID_EGZAMIN) in (select count(e.ID_EGZAMIN) from EGZAMINY e
group by e.ID_PRZEDMIOT
    order by 1 desc
    fetch first 3 rows only)
order by 2 desc;

declare
    vc1 number ;
    cursor c1 is select distinct count(*) from egzaminy group by id_przedmiot order by 1 desc ;
    cursor c2 is select nazwa_przedmiot, count(id_egzamin) from przedmioty p
                inner join egzaminy e on p.id_przedmiot = e.id_przedmiot
                group by nazwa_przedmiot
                having count(id_egzamin) = vc1
                order by 1;
begin
    open c1 ;
    if c1%isopen then
        loop
            fetch c1 into vc1 ;
            if c1%found then
                exit when c1%rowcount > 5 ;
                dbms_output.put_line('Exam number equals ' || to_char(vc1)) ;
                for vc2 in c2 loop
                    dbms_output.put_line(vc2.nazwa_przedmiot) ;
                end loop ;
            end if ;
        end loop ;
        close c1 ;
    end if ;
end ;