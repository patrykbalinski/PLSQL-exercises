-- 244.
-- Wykorzystując tabelę bazy danych o nazwie Analityka_Egzaminy, dla poszczególnych
-- studentów wskazać te przedmioty, z których zdaniem mieli oni największe problemy (tzn.
-- zdawali najwięcej razy taki przedmiot; jeśli przedmiot był zdany za pierwszym razem,
-- wówczas należy uznać, że problemu z jego zdaniem nie było).

select a.ID_STUDENT, a.IMIE, a.NAZWISKO, p.nazwa_przedmiot, p.liczba_niezdanych_egzaminow
from Analityka_Egzaminy a,
     table (a.PRZEDMIOTY) p
where liczba_niezdanych_egzaminow > 0
  and p.liczba_niezdanych_egzaminow = (select max(p2.liczba_niezdanych_egzaminow)
                                       from Analityka_Egzaminy a2,
                                            table (a2.PRZEDMIOTY) p2
                                       where a2.ID_STUDENT = a.ID_STUDENT)
order by a.ID_STUDENT;



select a.ID_STUDENT, a.IMIE, a.NAZWISKO, p.nazwa_przedmiot, p.liczba_niezdanych_egzaminow
from Analityka_Egzaminy a
         cross join TABLE (a.PRZEDMIOTY) p
where liczba_niezdanych_egzaminow > 0
  and p.liczba_niezdanych_egzaminow = (select max(p2.liczba_niezdanych_egzaminow)
                                       from Analityka_Egzaminy a2
                                                cross join TABLE (a2.PRZEDMIOTY) p2
                                       where a2.ID_STUDENT = a.ID_STUDENT)
order by a.ID_STUDENT;
