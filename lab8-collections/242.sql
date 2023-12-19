/*
W tabeli Przedmioty_Terminy usunąć te przedmioty, z których nie przeprowadzono
żadnego egzaminu. Po wykonaniu zadania sprawdzić zawartość tabeli
Przedmioty_Terminy.
*/

select * from Przedmioty_Terminy;

begin
    for przedmiot in (select * from Przedmioty_Terminy) loop
        if przedmiot.DATY_EGZAMINOW.COUNT() = 1 and przedmiot.DATY_EGZAMINOW(1) is null then
            delete from Przedmioty_Terminy p where p.NAZWA_PRZEDMIOT = przedmiot.NAZWA_PRZEDMIOT;
        end if;
    end loop;
end;

select * from Przedmioty_Terminy;