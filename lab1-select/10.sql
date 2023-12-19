-- 10.
-- Podać identyfikatory tych studentów, którzy w okresie od 01 stycznia 2010 do 31 grudnia
-- 2010 zdali egzaminy. Uporządkować wyświetlane informacje według identyfikatora
-- studenta.

SELECT ID_Student
FROM Egzaminy
WHERE Data_Egzamin BETWEEN '2010-01-01' AND '2010-12-31' AND Zdal = 'Y'
ORDER BY ID_Student;