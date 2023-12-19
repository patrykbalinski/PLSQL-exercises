/*
Utworzyć typ obiektowy o nazwie T_Przedmiot_Obj, opisujący przedmiot przy pomocy
atrybutów Id_przedmiot – NUMBER(3), Nazwa_Przedmiotelna – VARCHAR2(100),
Nazwa_skrot – VARCHAR2(6) oraz metody Gen_Skrot, generującej skrót nazwy
przedmiotu na podstawie pierwszych liter z wyrazów tworzących nazwę przedmiotu.
*/

-- !!! Nazwa_skrot VARCHAR2(6 CHAR) !!!

create or replace type T_Przedmiot_Obj as object (
    Id_przedmiot NUMBER(3),
    Nazwa_Przedmiotelna VARCHAR2(100),
    Nazwa_skrot VARCHAR2(6 CHAR),
    member procedure Gen_Skrot
);

create or replace type body T_Przedmiot_Obj as
    member procedure Gen_Skrot is
    begin
        Nazwa_skrot := substr(Nazwa_Przedmiotelna, 1, 6);
    end;
end;

declare
    v_Przedmiot_Obj_1 T_Przedmiot_Obj := T_Przedmiot_Obj(1, 'Mątematyka Dyskretna', '');
begin
    dbms_output.put_line(v_Przedmiot_Obj_1.Id_przedmiot || ', ' || v_Przedmiot_Obj_1.Nazwa_Przedmiotelna || ', ' || v_Przedmiot_Obj_1.Nazwa_skrot);
    v_Przedmiot_Obj_1.Gen_Skrot();
    dbms_output.put_line(v_Przedmiot_Obj_1.Id_przedmiot || ', ' || v_Przedmiot_Obj_1.Nazwa_Przedmiotelna || ', ' || v_Przedmiot_Obj_1.Nazwa_skrot);
end;