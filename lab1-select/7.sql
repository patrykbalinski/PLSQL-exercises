-- 7.
-- Podać identyfikatory przedmiotów, z których przeprowadzono egzaminy w ośrodkach
-- o identyfikatorze 1 oraz 3. W odpowiedzi uwzględnić te przedmioty, z których egzamin
-- odbył się przynajmniej w jednym z podanych ośrodków. Uporządkować rezultat wg
-- ośrodka oraz przedmiotu.

SELECT DISTINCT ID_Osrodek, Id_przedmiot
FROM Egzaminy
WHERE ID_Osrodek IN (1, 3);