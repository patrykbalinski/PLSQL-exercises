-- 15.
-- W jakie dni przeprowadzono egzaminy? Przedstawić wynik w porządku malejącym.

select distinct e.DATA_EGZAMIN
from EGZAMINY e
order by e.DATA_EGZAMIN desc;