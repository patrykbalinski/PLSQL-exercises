/*
Do tabeli Przedmioty_Obj wstawić nowe obiekty. Każdy z tych obiektów będzie
odpowiadał przedmiotowi pobranemu z tabeli Przedmioty. Po wykonaniu zadania
wyświetlić zawartość tabeli Przedmioty_Obj.
*/

begin
    for przedmiot_rec in (select * from PRZEDMIOTY p) loop
        insert into PRZEDMIOTY_OBJ values (T_Przedmiot_Obj(przedmiot_rec.ID_PRZEDMIOT, przedmiot_rec.NAZWA_PRZEDMIOT, null));
    end loop;

    for record in (select * from PRZEDMIOTY_OBJ p) loop
        record.PRZEDMIOT.GEN_SKROT();
        dbms_output.put_line(record.Przedmiot.ID_PRZEDMIOT || ', ' || record.Przedmiot.Nazwa_Przedmiotelna || ', ' || record.Przedmiot.Nazwa_skrot);
    end loop;
end;

select * from PRZEDMIOTY_OBJ p;
