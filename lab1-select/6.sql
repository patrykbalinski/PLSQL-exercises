-- 6.
-- Wyświetlić podstawowe dane (Nazwisko, Imie, ID_Egzaminator) o tych egzaminatorach,
-- których nazwiska zaczynają się na literę M. Posortować wyświetlane dane wg miasta,
-- w którym mieszkają egzaminatorzy.

SELECT Nazwisko, Imie, ID_Egzaminator
FROM egzaminatorzy
WHERE LOWER(Nazwisko) LIKE 'm%'
ORDER BY miasto;