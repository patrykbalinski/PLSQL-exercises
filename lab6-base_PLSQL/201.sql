-- 201.
-- Utworzyć tabelę o nazwie TLOEgzaminy, która będzie zawierać informacje o liczbie
-- egzaminów przeprowadzonych w poszczególnych ośrodkach. Następnie zdefiniować
-- odpowiedni wyzwalacz dla tabeli Egzaminy, który w momencie wstawienia nowego
-- egzaminu spowoduje aktualizację danych w tabeli TLOEgzaminy.

DROP TABLE TLOEgzaminy;

CREATE TABLE TLOEgzaminy
(
    Id_osrodek       NUMBER(5),
    Liczba_egzaminow NUMBER(7) default 0,
    CONSTRAINT TLOEgzaminy_pk PRIMARY KEY (Id_osrodek)
);

-- uzupelnienie tabeli TLOEgzaminy
begin
    for osrodek in (select o.ID_OSRODEK, count(e.ID_EGZAMIN) egzaminy
                    from OSRODKI o
                             left join EGZAMINY e on o.ID_OSRODEK = e.ID_OSRODEK
                    group by o.ID_OSRODEK) loop
        insert into TLOEgzaminy values (osrodek.ID_OSRODEK, osrodek.egzaminy);
    end loop;
end;

select * from TLOEgzaminy;

-- triggery
create or replace trigger BI_Egzaminy_update_TLOEgzaminy
    before insert
    on EGZAMINY
    for each row
begin
    update TLOEgzaminy tlo set tlo.LICZBA_EGZAMINOW = tlo.LICZBA_EGZAMINOW + 1 where tlo.ID_OSRODEK = :NEW.ID_OSRODEK;
end;

create or replace trigger BD_Egzaminy_update_TLOEgzaminy
    before delete
    on EGZAMINY
    for each row
begin
    update TLOEgzaminy tlo set tlo.LICZBA_EGZAMINOW = tlo.LICZBA_EGZAMINOW - 1 where tlo.ID_OSRODEK = :OLD.ID_OSRODEK;
end;

-- sprawdzenie
select * from TLOEgzaminy;

insert into egzaminy (ID_EGZAMIN, ID_STUDENT, ID_PRZEDMIOT, ID_EGZAMINATOR, ID_OSRODEK)
values ((select max(e.ID_EGZAMIN) + 1 from EGZAMINY e), '0000018', '15', '0005', 1);

select * from TLOEgzaminy;