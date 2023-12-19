-- 16.
-- W jakich miastach znajdują się ośrodki egzaminowania? Podać nazwy tych miast,
-- uporządkowane alfabetycznie.

select distinct o.MIASTO
from OSRODKI o
order by o.MIASTO;