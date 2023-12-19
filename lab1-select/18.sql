-- 18.
-- Dokonać identyfikacji sposobu określenia wyniku egzaminu. Informacja taka znajduje się
-- w kolumnie Zdal w tabeli Egzaminy.

select e.ID_EGZAMIN, e.PUNKTY, e.ZDAL
from EGZAMINY e
order by e.PUNKTY desc;

-- egzamin jest zdany jezeli liczba punktow z egzaminu >= 3.00