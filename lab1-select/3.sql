-- 3.
-- Wyświetlić podstawowe dane (ID_Osrodek, Nazwa_Osrodek, Miasto) o ośrodkach.
-- Posortować wyświetlane dane wg identyfikatora (rosnąco) oraz miasta (malejąco). Kod
-- pocztowy oraz nazwę miasta wyświetlić w jednej kolumnie, którą należy opisać aliasem
-- Miejsce.

SELECT ID_Osrodek, Nazwa_Osrodek, Miasto AS Miejsce
FROM Osrodki
ORDER BY ID_Osrodek, Miasto DESC;