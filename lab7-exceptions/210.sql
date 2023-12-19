-- 210.
-- Podać informację, z których przedmiotów nie przeprowadzono egzaminu. Wyświetlić
-- nazwę przedmiotu. Uporządkować wyświetlane informacje wg nazwy przedmiotu. Zadanie
-- wykonać wykorzystując wyjątek systemowy.

select p.NAZWA_PRZEDMIOT from PRZEDMIOTY p
left join EGZAMINY e on e.ID_PRZEDMIOT = p.ID_PRZEDMIOT
where e.ID_EGZAMIN is null;

declare
    v_liczba_przedmiotow number;
begin
    for vc_przedmiot in (select p.NAZWA_PRZEDMIOT, p.ID_PRZEDMIOT from PRZEDMIOTY p) loop
        begin
            select distinct 1
            into v_liczba_przedmiotow
            from EGZAMINY e
            where e.ID_PRZEDMIOT = vc_przedmiot.ID_PRZEDMIOT;
        exception when NO_DATA_FOUND then
            dbms_output.put_line(vc_przedmiot.NAZWA_PRZEDMIOT);
        end;
    end loop;
end;

insert into PRZEDMIOTY (ID_PRZEDMIOT, NAZWA_PRZEDMIOT, OPIS_PRZEDMIOT)
values ('9999', 'TEST_PRZEDMIOT', 'przedmiot bez egzaminu');

rollback;