/*
Wyświetlić z tabeli Analityka informacje, ile egzaminów przeprowadzili poszczególni
egzaminatorzy w poszczególnych ośrodkach. Uporządkować wyświetlane dane wg nazwy
ośrodka.
*/

select a.ID_OSRODEK, a.NAZWA_OSRODEK, e.id_egzaminator, e.nazwisko, e.imie, e.liczba_egzaminow
from ANALITYKA a,
     table (a.EGZAMINATORZY) e
order by a.NAZWA_OSRODEK;

select a.ID_OSRODEK, a.NAZWA_OSRODEK, e.id_egzaminator, e.nazwisko, e.imie, e.liczba_egzaminow
from ANALITYKA a
         cross join TABLE (a.EGZAMINATORZY) e
order by a.NAZWA_OSRODEK;