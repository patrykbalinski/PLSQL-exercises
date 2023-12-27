-- 219.
-- Zmodyfikować kod źródłowy z zadania poprzedniego (tj. 66) tak, aby podczas
-- porównywania rekordów z tabel Przedmioty i Kopia_Przedmioty były brane pod uwagę
-- wartości z dwóch pól tj. identyfikator i nazwa przedmiotu. Warunkiem identyczności
-- dwóch rekordów w tych tabelach będzie równość identyfikatorów oraz nazw przedmiotów.
-- Wynik porównania zapisać w tabeli Wynik_Synchro (przed wykonaniem zadania usunąć
-- dane z tej tabeli).

alter table WYNIK_SYNCHRO drop constraint  Wynik_Synchro_PK;
alter table Wynik_Synchro add constraint Wynik_Synchro_PK primary key (ID_PRZEDMIOT, NAZWA_PRZEDMIOT);
delete from WYNIK_SYNCHRO;

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