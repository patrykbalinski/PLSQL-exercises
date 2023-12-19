-- 191.
-- Wskazać tych egzaminatorów, którzy przeprowadzili egzaminy w ciągu trzech ostatnich
-- dni egzaminowania. W odpowiedzi umieścić datę egzaminu oraz dane identyfikujące
-- egzamnatora tj. identyfikator, imię i nazwisko.

select eg.ID_EGZAMINATOR, eg.IMIE, eg.NAZWISKO, e.DATA_EGZAMIN from EGZAMINY e
inner join EGZAMINATORZY eg on eg.ID_EGZAMINATOR = e.ID_EGZAMINATOR
where e.DATA_EGZAMIN in (select distinct e.DATA_EGZAMIN from EGZAMINY e
                         order by 1 desc
                         fetch first 3 rows only);

