-- 1.
-- Wyświetlić podstawowe informacje o studentach (Nazwisko, Imie, ID_Student)
-- posortowane malejąco wg nazwiska.

SELECT ID_Student, Nazwisko, Imie
FROM Studenci
ORDER BY Nazwisko DESC;