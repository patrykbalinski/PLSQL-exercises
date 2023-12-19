-- 21.
-- Którzy egzaminatorzy przeprowadzili egzaminy w poszczególnych ośrodkach? Dla
-- każdego ośrodka, w którym odbył się egzamin podać identyfikator egzaminatora,
-- prowadzącego ten egzamin. Uporządkować rezultat według identyfikatora ośrodka oraz
-- identyfikatora egzaminatora.

select o.NAZWA_OSRODEK, e.ID_EGZAMINATOR
from OSRODKI o
         inner join EGZAMINY E on o.ID_OSRODEK = E.ID_OSRODEK
         inner join EGZAMINATORZY eg on eg.ID_EGZAMINATOR = e.ID_EGZAMINATOR
order by o.ID_OSRODEK, e.ID_EGZAMINATOR;