/*
Którzy studenci zdawali egzaminy z przedmiotu Bazy danych w ośrodkach o nazwie
CKMP i LBS? Podać ich identyfikator, Nazwisko oraz imię. Uwzględnić tylko tych
studentów, którzy zdawali egzaminy ze wskazanego przedmiotu w jednym i drugim
ośrodku. Wynik uporządkować według identyfikatora studenta. Zadanie należy wykonać,
wykorzystując podzapytanie.
*/

select distinct s.ID_STUDENT, s.NAZWISKO, s.IMIE --, o.NAZWA_OSRODEK, p.NAZWA_PRZEDMIOT
from STUDENCI s
         inner join EGZAMINY e on e.ID_STUDENT = s.ID_STUDENT
         inner join OSRODKI o on o.ID_OSRODEK = e.ID_OSRODEK
         inner join PRZEDMIOTY p on p.ID_PRZEDMIOT = e.ID_PRZEDMIOT
where o.NAZWA_OSRODEK in ('CKMP', 'LBS')
  and p.NAZWA_PRZEDMIOT = 'Bazy danych';

select extract(year from e.DATA_EGZAMIN)  as year,
       extract(month from e.DATA_EGZAMIN) as month,
       count(e.ID_EGZAMIN)                as examsNumber
from EGZAMINY e
group by extract(year from e.DATA_EGZAMIN), extract(month from e.DATA_EGZAMIN)
having count(e.ID_EGZAMIN) = (select max(count(e2.ID_EGZAMIN))
                              from EGZAMINY e2
                              group by extract(year from e2.DATA_EGZAMIN), extract(month from e2.DATA_EGZAMIN))
order by 1, 3 desc;

