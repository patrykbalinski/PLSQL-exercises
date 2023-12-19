/*
Utworzyć typ obiektowy o nazwie T_Osrodek_Obj, który będzie zawierał dwa atrybuty:
ID_Osrodek (NUMBER) Nazwa (VARCHAR2(40)). Utworzyć typ obiektowy o nazwie
T_Adres_Obj, zawierający następujące atrybuty: Ulica (VARCHAR2(30), Numer
(VARCHAR2(8)), Kod_poczta (VARCHAR2(5)) i Miasto (VARCHAR2(35)).
*/

create or replace type T_Osrodek_Obj as object (
    ID_Osrodek NUMBER(3),
    Nazwa VARCHAR2(40)
);

create or replace type T_Adres_Obj as object (
    Ulica VARCHAR2(30),
    Numer VARCHAR2(8),
    Kod_poczta VARCHAR2(5),
    Miasto VARCHAR2(35)
);