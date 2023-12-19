-- 19.
-- W jakich dniach przeprowadzono egzaminy w poszczególnych ośrodkach? Dla każdego
-- ośrodka, opisanego przez jego identyfikator, podać datę przeprowadzonego w nim
-- egzaminu. Uporządkować wyświetlane informacje wg ośrodka oraz daty egzaminu.

select o.ID_OSRODEK, e.DATA_EGZAMIN
from OSRODKI o
         inner join EGZAMINY e on o.ID_OSRODEK = e.ID_OSRODEK
order by o.ID_OSRODEK, e.DATA_EGZAMIN;