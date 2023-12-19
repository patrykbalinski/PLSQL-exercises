-- 92.
-- Który student nie zdawał egzaminu z przedmiotu Bazy danych? Podać identyfikator,
-- Nazwisko oraz imię studenta. Uwzględnić także tych studentów, którzy jeszcze nie
-- zdawali żadnego egzaminu. Wynik uporządkować według identyfikatora studenta.
-- Zadanie należy wykonać, wykorzystując podzapytanie.

select s.ID_STUDENT, s.NAZWISKO, s.IMIE
from STUDENCI s
where s.ID_STUDENT not in (select distinct s.ID_STUDENT
                           from STUDENCI s
                                    inner join EGZAMINY e on e.ID_STUDENT = s.ID_STUDENT
                                    inner join PRZEDMIOTY p on p.ID_PRZEDMIOT = e.ID_PRZEDMIOT
                           where p.NAZWA_PRZEDMIOT = 'Bazy danych')
order by s.ID_STUDENT;