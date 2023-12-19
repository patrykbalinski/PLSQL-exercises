/*
W których ośrodkach nie przeprowadzono egzaminu z przedmiotu Bazy danych? Podać
ich identyfikator, nazwę oraz miasto, w którym znajduje się ośrodek. Uwzględnić także te
ośrodki, w których nie odbył się jeszcze żaden egzamin. Wynik uporządkować według
identyfikatora ośrodka. Zadanie należy wykonać, wykorzystując podzapytanie.
*/

select o.ID_OSRODEK, o.NAZWA_OSRODEK, o.MIASTO
from OSRODKI o
where o.ID_OSRODEK in (select distinct e.ID_OSRODEK
                           from EGZAMINY e
                                    inner join PRZEDMIOTY p on p.ID_PRZEDMIOT = e.ID_PRZEDMIOT
                           where p.NAZWA_PRZEDMIOT = 'Bazy danych')
order by o.ID_OSRODEK;