/*
Zmodyfikować zawartość tabeli Egzaminy_Obj tak, aby wszystkie egzaminy miały wynik
negatywny tj. wartość atrybutu Zdal dla wszystkich obiektów była równa N.
*/

update Egzaminy_Obj e set e.ZDAL = 'N';

select * from EGZAMINY_OBJ;