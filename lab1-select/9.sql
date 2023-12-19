-- 9.
-- Podać identyfikatory ośrodków, w których przeprowadzono egzaminy w okresie od 20
-- kwietnia 2012 do 20 kwietnia 2012. Dodatkowo wyświetlić datę tych egzaminów
-- w postaci komunikatu: Egzamin w ośrodku ... odbył się w dniu .... Uporządkować
-- wyświetlane informacje według ośrodka i daty egzaminu.

SELECT DISTINCT ID_Osrodek, 'Egzamin w ośrodku ' || ID_Osrodek || ' odbył się w dniu: ' || Data_Egzamin
FROM Egzaminy
WHERE Data_Egzamin BETWEEN '2012-04-20' AND '2012-04-20'
ORDER BY 1, 2;