/*
Utworzyć typ obiektowy o nazwie T_Egzamin_Obj, opisujący egzamin. Typ ten będzie
zawierał atrybuty identyczne jak kolumny tabeli Egzaminy (zgodność nazw i typów
danych). Dodatkowo utworzyć metodę Ustaw_date, która będzie wstawiała datę systemową
jako wartość atrybutu Data_Egzamin.
*/

select * from EGZAMINY;

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

create or replace type body T_Egzamin_Obj as
    member procedure Ustaw_date is
    begin
        DATA_EGZAMIN := sysdate;
    end;
end;
