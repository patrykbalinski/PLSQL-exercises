/*
Wykorzystując typ obiektowy T_Przedmiot_Obj z poprzedniego zadania, zdefiniować w
bloku PL/SQL trzy obiekty, opisujące następujące przedmioty: Bazy danych, Języki baz
danych i Hurtownie danych. Jako identyfikatory przedmiotów przyjąć wartości 101, 102 i
103. Po zainicjowaniu wartości atrybutów obiektów, wyświetlić te wartości.
*/

declare
    v_Przedmiot_1 T_Przedmiot_Obj := T_Przedmiot_Obj(101, 'Bazy danych', '');
    v_Przedmiot_2 T_Przedmiot_Obj := T_Przedmiot_Obj(102, 'Języki baz danych', '');
    v_Przedmiot_3 T_Przedmiot_Obj := T_Przedmiot_Obj(103, 'Hurtownie danych', '');
begin
    v_Przedmiot_1.Gen_Skrot();
    v_Przedmiot_2.Gen_Skrot();
    v_Przedmiot_3.Gen_Skrot();
    dbms_output.put_line(v_Przedmiot_1.Id_przedmiot || ', ' || v_Przedmiot_1.Nazwa_Przedmiotelna || ', ' || v_Przedmiot_1.Nazwa_skrot);
    dbms_output.put_line(v_Przedmiot_2.Id_przedmiot || ', ' || v_Przedmiot_2.Nazwa_Przedmiotelna || ', ' || v_Przedmiot_2.Nazwa_skrot);
    dbms_output.put_line(v_Przedmiot_3.Id_przedmiot || ', ' || v_Przedmiot_3.Nazwa_Przedmiotelna || ', ' || v_Przedmiot_3.Nazwa_skrot);
end;