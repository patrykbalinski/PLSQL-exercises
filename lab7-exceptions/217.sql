-- 217.
-- Utworzyć kopię tabeli Przedmioty i nazwać ją Kopia_Przedmioty. Następnie dla tej tabeli
-- zdefiniować trigger o nazwie Trg_BI_KPrzedmioty, który będzie kontrolował poprawność
-- operacji wstawiania rekordów do tej tabeli. Jeśli wstawiana wartość identyfikatora istnieje
-- już w tabeli, należy wygenerować nową wartość, większą o 1 od wartości największej. Jeśli
-- podana nazwa nowego przedmiotu istnieje w tabeli, należy ją zastąpić ciągiem znaków
-- 'Nazwa nieokreślona'. Sprawdzić poprawność działania wyzwalacza.

create table Kopia_Przedmioty as (select * from PRZEDMIOTY p);

select * from Kopia_Przedmioty k;

create or replace trigger Trg_BI_KPrzedmioty before insert on Kopia_Przedmioty for each row
declare
    v_counter number;
begin
    select count(*) into v_counter from Kopia_Przedmioty k where k.ID_PRZEDMIOT = :NEW.ID_PRZEDMIOT;

    if v_counter > 0 then
        select count(*) + 1 into :NEW.ID_PRZEDMIOT from Kopia_Przedmioty k;
    end if;

    select count(*) into v_counter from Kopia_Przedmioty k where k.NAZWA_PRZEDMIOT = :NEW.NAZWA_PRZEDMIOT;

    if v_counter > 0 then
        :NEW.NAZWA_PRZEDMIOT := 'Nazwa nieokreślona';
    end if;
end;

declare
    v_przedmiot PRZEDMIOTY%rowtype;
begin
    select * into v_przedmiot from KOPIA_PRZEDMIOTY k order by k.ID_PRZEDMIOT fetch first 1 row only;

    insert into KOPIA_PRZEDMIOTY values (v_przedmiot.ID_PRZEDMIOT, v_przedmiot.NAZWA_PRZEDMIOT, v_przedmiot.OPIS_PRZEDMIOT);
end;

select * from Kopia_Przedmioty k;
