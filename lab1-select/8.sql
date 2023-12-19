-- 8.
-- Podać nazwy miast, w których znajduje się ośrodek o nazwie CKMP. Uporządkować
-- alfabetycznie wynik zapytania.

SELECT DISTINCT Miasto
FROM Osrodki
WHERE UPPER(Nazwa_Osrodek) = 'CKMP'
ORDER BY Miasto ;