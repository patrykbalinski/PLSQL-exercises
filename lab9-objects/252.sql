/*
Utworzyć tabelę o nazwie Przedmioty_Obj. Tabela będzie zawierała jedną kolumnę typu
obiektowego T_Przedmiot_Obj, opisującego przedmioty. Wstawić do tabeli
Przedmioty_Obj trzy obiekty, opisujące następujące przedmioty: Zaawansowane bazy
danych, Języki baz danych i Hurtownie danych. Jako identyfikatory przedmiotów przyjąć
wartości 101, 102 i 103. Po wstawieniu danych do tabeli wyświetlić jej zawartość.
*/

create table Przedmioty_Obj (
    Przedmiot T_Przedmiot_Obj
);

insert into Przedmioty_Obj values(T_Przedmiot_Obj(101, 'Zaawansowane bazy danych', ''));
insert into Przedmioty_Obj values(T_Przedmiot_Obj(102, 'Języki baz danych', ''));
insert into Przedmioty_Obj values(T_Przedmiot_Obj(103, 'Hurtownie danych', ''));

begin
    for record in (select * from Przedmioty_Obj p) loop
        record.Przedmiot.GEN_SKROT();
        dbms_output.put_line(record.Przedmiot.ID_PRZEDMIOT || ', ' || record.Przedmiot.Nazwa_Przedmiotelna || ', ' || record.Przedmiot.Nazwa_skrot);
    end loop;
end;