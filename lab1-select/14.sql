-- 14.
-- Którzy egzaminatorzy przeprowadzili już egzaminy? Podać ich identyfikator.
-- Uporządkować rezultat według identyfikatora egzaminatora.

select distinct e.ID_EGZAMINATOR
from EGZAMINATORZY e
order by e.ID_EGZAMINATOR;