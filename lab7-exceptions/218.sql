-- 218.
-- Utworzyć tabelę Wynik_Synchro, której struktura jest zgodna ze strukturą tabeli
-- Przedmioty. Następnie wstawić do tabeli Wynik_Synchro dodatkowe pole o nazwie Miejsce.
-- Pole to będzie zawierało daną informującą o miejscu występowania rekordu, brakującego w
-- drugiej z synchronizowanych tabel (wartości dopuszczalne w tym polu to P – jeśli rekord
-- występuje tylko w tabeli Przedmioty lub K – jeśli rekord występuję tylko w tabeli
-- Kopia_Przedmioty). Wygenerować informacje niezbędne do synchronizacji zawartości
-- tabel Przedmioty i Kopia_Przedmioty, przy wykorzystaniu kodu PL/SQL (wyjątki, kursory,
-- itp.). Jako podstawę identyczności rekordów przyjąć równość identyfikatorów
-- porównywanych przedmiotów.

create table Wynik_Synchro as (select * from PRZEDMIOTY p where 1=0);
alter table Wynik_Synchro add Miejsce varchar2(1);
alter table Wynik_Synchro add constraint Wynik_Synchro_PK primary key (ID_PRZEDMIOT);

select * from Wynik_Synchro;

begin
    for vc_przedmiot in (select * from PRZEDMIOTY p) loop
        insert into Wynik_Synchro values (vc_przedmiot.ID_PRZEDMIOT, vc_przedmiot.NAZWA_PRZEDMIOT, vc_przedmiot.OPIS_PRZEDMIOT, 'P');
    end loop;

    for vc_kopia_przedmiot in (select * from KOPIA_PRZEDMIOTY) loop
        begin
            insert into Wynik_Synchro values (vc_kopia_przedmiot.ID_PRZEDMIOT, vc_kopia_przedmiot.NAZWA_PRZEDMIOT, vc_kopia_przedmiot.OPIS_PRZEDMIOT, 'K');
        exception when DUP_VAL_ON_INDEX then
            delete from Wynik_Synchro w where w.ID_PRZEDMIOT = vc_kopia_przedmiot.ID_PRZEDMIOT;
        end;
    end loop;
end;

select * from Wynik_Synchro;