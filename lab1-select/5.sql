-- 5.
-- Którzy studenci zdawali egzaminy u poszczególnych egzaminatorów. Podać identyfikator
-- egzaminatora i identyfikator studenta. Uwzględnić tylko tych studentów, którzy
-- przystapili już do egzaminu. Uporządkować wyświetlane dane wg wartości identyfikatora
-- studenta oraz identyfikatora egzaminatora. Wynik ma być wyświetlany w następującej
-- postaci: Student o identyfikatorze ... zdawał egzamin u egzaminatora ... Kolumnę
-- wynikową nazwać Informacja o egzaminie.

SELECT DISTINCT ' Student o identyfikatorze ' || ID_Student || ' zdawał egzamin u egzaminatora ' || ID_Egzaminator AS "Informacja o egzaminie"
FROM Egzaminy
ORDER BY 1;