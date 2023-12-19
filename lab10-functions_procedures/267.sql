-- 267.
-- Utworzyć tabelę o nazwie TAZEgzaminy, która będzie zawierała informację o liczbie
-- zdanych i niezdanych egzaminów w poszczególnych ośrodkach. Tabela powinna zawierać
-- cztery kolumny (identyfikator ośrodka, nazwa ośrodka, liczba zdanych i liczba
-- niezdanych egzaminów). Następnie dla tabeli Egzaminy zdefiniować odpowiedni
-- wyzwalacz, który w przypadku modyfikacji lub wstawienia nowego egzaminu spowoduje
-- aktualizację zawartości tabeli TAZEgzaminy.

create table TAZEgzaminy
(
    Id_osrodek                  NUMBER(5),
    Nazwa_osrodek               VARCHAR2(50),
    Liczba_zdanych_egzaminow    NUMBER(7) default 0,
    Liczba_niezdanych_egzaminow NUMBER(7) default 0,
    CONSTRAINT TAZEgzaminy_pk PRIMARY KEY (Id_osrodek)
);

-- uzupelnienie tabeli TAZEgzaminy
begin
    for osrodek in (select o.ID_OSRODEK, o.NAZWA_OSRODEK, (select count(*) from EGZAMINY e where e.ID_OSRODEK = o.ID_OSRODEK and e.ZDAL = 'T') liczba_zdanych, (select count(*) from EGZAMINY e where e.ID_OSRODEK = o.ID_OSRODEK and e.ZDAL = 'N') liczba_niezdanych from OSRODKI o) loop
        insert into TAZEgzaminy values (osrodek.ID_OSRODEK, osrodek.NAZWA_OSRODEK, osrodek.liczba_zdanych, osrodek.liczba_niezdanych);
    end loop;
end;

select * from TAZEgzaminy;

-- triggery
create or replace trigger BI_Egzaminy_update_TAZEgzaminy before insert on EGZAMINY for each row
begin
    if :new.ZDAL = 'T' then
        update TAZEgzaminy taz set taz.LICZBA_ZDANYCH_EGZAMINOW = taz.LICZBA_ZDANYCH_EGZAMINOW + 1 where taz.ID_OSRODEK = :NEW.ID_OSRODEK;
    elsif  :new.ZDAL = 'N' then
        update TAZEgzaminy taz set taz.LICZBA_NIEZDANYCH_EGZAMINOW = taz.LICZBA_NIEZDANYCH_EGZAMINOW + 1 where taz.ID_OSRODEK = :NEW.ID_OSRODEK;
    end if;
end;

create or replace trigger BU_Egzaminy_update_TAZEgzaminy before update on EGZAMINY for each row
begin
    if :old.ZDAL = 'N' and :new.ZDAL = 'T' then
        update TAZEgzaminy taz set taz.LICZBA_ZDANYCH_EGZAMINOW = taz.LICZBA_ZDANYCH_EGZAMINOW + 1, taz.LICZBA_NIEZDANYCH_EGZAMINOW = taz.LICZBA_NIEZDANYCH_EGZAMINOW - 1 where taz.ID_OSRODEK = :NEW.ID_OSRODEK;
    elsif  :old.ZDAL = 'T' and :new.ZDAL = 'N' then
        update TAZEgzaminy taz set taz.LICZBA_ZDANYCH_EGZAMINOW = taz.LICZBA_ZDANYCH_EGZAMINOW - 1, taz.LICZBA_NIEZDANYCH_EGZAMINOW = taz.LICZBA_NIEZDANYCH_EGZAMINOW + 1 where taz.ID_OSRODEK = :NEW.ID_OSRODEK;
    end if;
end;

-- sprawdzenie
select * from TAZEgzaminy order by 1;

insert into egzaminy (ID_EGZAMIN, ID_STUDENT, ID_PRZEDMIOT, ID_EGZAMINATOR, ID_OSRODEK, ZDAL)
values ((select max(e.ID_EGZAMIN) + 1 from EGZAMINY e), '0000001', '15', '0005', 1, 'T')

insert into egzaminy (ID_EGZAMIN, ID_STUDENT, ID_PRZEDMIOT, ID_EGZAMINATOR, ID_OSRODEK, ZDAL)
values ((select max(e.ID_EGZAMIN) + 1 from EGZAMINY e), '0000001', '15', '0005', 1, 'N')

update EGZAMINY e set e.ZDAL = 'T' where e.ID_EGZAMIN = 3;
update EGZAMINY e set e.ZDAL = 'N' where e.ID_EGZAMIN = 3;

select * from TAZEgzaminy order by 1;