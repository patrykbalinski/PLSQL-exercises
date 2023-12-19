/*
Wykorzystując typ obiektowy T_Egzamin_Obj, zdefiniowany w poprzednim zadaniu,
utworzyć tabelę o nazwie Egzaminy_Obj, która umożliwi przechowywanie obiektów
wierszowych, opisujących egzaminy. Następnie utworzyć obiekty tej tabeli, z których
każdy będzie opisywał jeden egzamin. Wartości atrybutów kolejnych obiektów mają być
zgodne z wartościami znajdującymi się w rekordach tabeli Egzaminy.
*/

create table Egzaminy_Obj of T_Egzamin_Obj;

create or replace type T_Egzamin_Obj as object (
    ID_EGZAMIN NUMBER(12),
    ID_STUDENT VARCHAR2(7),
    ID_PRZEDMIOT NUMBER(2),
    ID_EGZAMINATOR VARCHAR2(4),
    DATA_EGZAMIN DATE,
    ID_OSRODEK NUMBER(5),
    ZDAL VARCHAR2(1),
    PUNKTY NUMBER(3, 2),
    member procedure Ustaw_date
);

begin
    for egzamin in (select * from EGZAMINY e) loop
        insert into Egzaminy_Obj values (egzamin.ID_EGZAMIN, egzamin.ID_STUDENT, egzamin.ID_PRZEDMIOT, egzamin.ID_EGZAMINATOR, egzamin.DATA_EGZAMIN, egzamin.ID_OSRODEK, egzamin.ZDAL, egzamin.PUNKTY);
    end loop;
end;

select * from egzaminy;
select * From Egzaminy_Obj;