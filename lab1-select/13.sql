-- 13.
-- Którzy studenci przystąpili już do egzaminu? Podać ich identyfikator. Uporządkować
-- rezultat według identyfikatora studenta.

select distinct e.ID_STUDENT
from EGZAMINY e
order by 1;