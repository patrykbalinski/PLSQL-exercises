-- 11.
-- Wyświetlić wszystkie dane o wszystkich ośrodkach. Uporządkować rosnąco wynik
-- zapytania wg identyfikatora ośrodka oraz miasta, w którym znajduje się ośrodek.

select o.* from OSRODKI o
order by o.ID_OSRODEK, o.MIASTO;