/*
Wyświetlić z tabeli Indeks informacje, jakie przedmioty i kiedy zostały zdane przez
poszczególnych studentów. Uporządkować wyświetlane dane wg nazwiska studenta.
*/

select i.ID_STUDENT, i.NAZWISKO_STUDENT, i.IMIE_STUDENT, e.nazwa_przedmiot, e.data_zdania_egzaminu
from INDEKS i,
     table (i.ZDANE_EGZAMINY) e
order by i.NAZWISKO_STUDENT, i.IMIE_STUDENT;

select i.ID_STUDENT, i.NAZWISKO_STUDENT, i.IMIE_STUDENT, z.nazwa_przedmiot, z.data_zdania_egzaminu
from INDEKS i
         cross join TABLE (i.ZDANE_EGZAMINY) z