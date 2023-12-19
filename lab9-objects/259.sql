/*
Z tabeli Osrodki_Obj usunąć te ośrodki, w których nie odbyły się jeszcze egzaminy. Do
rozwiązania zadania wykorzystać także tabelę Egzaminy_Obj, w której należy kontrolować
istnienie egzaminu w ośrodku przed jego usunięciem.
*/

-- wyswietlenie osrodkow ktore nie maja egzaminow
select * from OSRODKI o
where o.ID_OSRODEK in (select o.ID_OSRODEK from OSRODKI o left join EGZAMINY e on e.ID_OSRODEK = o.ID_OSRODEK where e.ID_EGZAMIN is null)

-- usuniecie osrodkow ktore nie maja egzaminow
delete from OSRODKI_OBJ o where o.OSRODEK.ID_OSRODEK in (select o.ID_OSRODEK from OSRODKI o left join EGZAMINY e on e.ID_OSRODEK = o.ID_OSRODEK where e.ID_EGZAMIN is null);

-- sprawdzenie
select * from OSRODKI_OBJ;