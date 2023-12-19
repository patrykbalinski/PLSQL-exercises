-- 20.
-- Kiedy poszczególni studenci zdawali swoje egzaminy? Podać identyfikator studenta oraz
-- datę zdawania egzaminu. Wynik wyświetlić w nastepującej postaci: Student
-- o identyfikatorze ... zdawał egzamin w dniu ... Kolumnę wynikową nazwać Informacja
-- o egzaminie studenta. Uporządkować otrzymany wynik według identyfikatora studenta
-- oraz daty zdawania egzaminu.

select 'Student o identyfikatorze ' || s.ID_STUDENT || ' zdawał egzamin w dniu ' || to_char(e.DATA_EGZAMIN, 'DD-MM-YYYY') as "Informacja o egzaminie studenta"
from STUDENCI s
         inner join EGZAMINY E on s.ID_STUDENT = E.ID_STUDENT;