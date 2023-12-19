/*
Utworzyć tabelę o nazwie Osrodki_Obj, która będzie zawierała dwie kolumny: Osrodek
typu T_Osrodek_Obj oraz Adres typu T_Adres_Obj. Wykorzystując tabelę relacyjną
Osrodki, wstawić do tabeli Osrodki_Obj odpowiednie dane do kolumn Osrodek oraz Adres.
Do kolumny Osrodek należy wstawić dane z pól ID_Osrodek oraz Nazwa_Osrodek,
natomiast wartości z pozostałych pól tabeli relacyjnej Osrodki – do kolumny Adres. Po
zakończeniu operacji wstawiania danych do tabeli Osrodki_Obj, należy wyświetlić jej
zawartość.
*/

create table Osrodki_Obj (
    Osrodek T_Osrodek_Obj,
    Adres T_Adres_Obj
);

select * from OSRODKI;

begin
    for osr in (select * from OSRODKI o) loop
       insert into Osrodki_Obj values (T_Osrodek_Obj(osr.ID_OSRODEK, osr.NAZWA_OSRODEK), T_Adres_Obj(null, null, null, osr.MIASTO));
    end loop;
end;

-- wyswietlenie:

select * from Osrodki_Obj;

-- lub

begin
    for osr in (select * from Osrodki_Obj o) loop
       dbms_output.put_line(osr.Osrodek.NAZWA || ', ' || osr.Osrodek.ID_OSRODEK || ', ' ||  osr.Adres.MIASTO);
    end loop;
end;