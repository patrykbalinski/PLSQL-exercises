-- 91.
-- W których ośrodkach student o identyfikatorze 0000050 nie zdawał jeszcze żadnego
-- egzaminu? Podać identyfikator ośrodka, jego nazwę oraz miasto.

select o.ID_OSRODEK, o.NAZWA_OSRODEK, o.MIASTO
from OSRODKI o
where o.ID_OSRODEK not in (select e.ID_OSRODEK
                           from EGZAMINY e
                           where e.ID_STUDENT = '0000050')
order by o.ID_OSRODEK;