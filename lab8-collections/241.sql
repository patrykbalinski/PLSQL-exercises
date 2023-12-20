-- 241.
-- Utworzyć tabelę w bazie danych o nazwie Przedmioty_Terminy. Tabela powinna zawierać
-- dwie kolumny: nazwę przedmiotu oraz tabelę o zmiennej długości, zawierającą daty
-- egzaminów z każdego przedmiotu. Następnie wstawić do tabeli Przedmioty_Terminy
-- rekordy na podstawie danych z tabeli Egzaminy i Przedmioty. Przed wstawieniem danych
-- do tabeli, należy je wyświetlić, porządkując wg nazwy przedmiotu.

drop type daty_egzaminow force;
drop table Przedmioty_Terminy;

create or replace type daty_egzaminow is varray(366) of date;

CREATE TABLE Przedmioty_Terminy
(
    nazwa_przedmiot VARCHAR2(100),
    daty_egzaminow   daty_egzaminow,
    CONSTRAINT Przedmioty_Terminy_pk PRIMARY KEY (nazwa_przedmiot)
);

select * from Przedmioty_Terminy;

delete from Przedmioty_Terminy;

-- uzupelnienie danych
declare
    v_daty_egzaminow daty_egzaminow;
    v_i number;
begin
    for przedmiot in (select distinct p.ID_PRZEDMIOT, p.NAZWA_PRZEDMIOT from PRZEDMIOTY p order by p.NAZWA_PRZEDMIOT) loop
        dbms_output.put_line('Przedmiot: ' || przedmiot.NAZWA_PRZEDMIOT);
        v_daty_egzaminow := daty_egzaminow();
        for egzamin in (select p.ID_PRZEDMIOT, p.NAZWA_PRZEDMIOT, e.DATA_EGZAMIN from PRZEDMIOTY p
                        left join EGZAMINY e on p.ID_PRZEDMIOT = e.ID_PRZEDMIOT
                        where p.ID_PRZEDMIOT = przedmiot.ID_PRZEDMIOT
                        order by e.DATA_EGZAMIN) loop
            dbms_output.put_line(egzamin.DATA_EGZAMIN);
            v_daty_egzaminow.extend();
            v_i := v_daty_egzaminow.count();
            v_daty_egzaminow(v_i) := egzamin.DATA_EGZAMIN;
        end loop;
        insert into Przedmioty_Terminy values (przedmiot.NAZWA_PRZEDMIOT, v_daty_egzaminow);
    end loop;
end;

select * from Przedmioty_Terminy;