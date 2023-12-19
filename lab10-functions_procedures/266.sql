-- 266.
-- Utworzyć tabelę o nazwie TLSEgzaminy, która będzie zawierać informacje o liczbie
-- egzaminów zdawanych przez poszczególnych studentów. Tabela powinna zawierać 4
-- kolumny (identyfikator studenta, Nazwisko, imię, liczba egzaminów). Następnie
-- zdefiniować odpowiedni wyzwalacz dla tabeli Egzaminy, który w momencie wstawienia
-- nowego egzaminu spowoduje aktualizację danych w tabeli TLSEgzaminy. Aktualizacja
-- danych w tabeli TLSEgzaminy powinna odbywać się z wykorzystaniem procedury

create table TLSEgzaminy
(
    Id_student       VARCHAR2(7),
    Nazwisko         VARCHAR2(25),
    Imie             VARCHAR2(15),
    Liczba_egzaminow NUMBER(7) default 0,
    CONSTRAINT TLSEgzaminy_pk PRIMARY KEY (Id_student)
);

-- uzupelnienie tabeli TLSEgzaminy
begin
    for student in (select s.ID_STUDENT, s.NAZWISKO, s.IMIE, count(e.ID_EGZAMIN) egzaminy from STUDENCI s left join EGZAMINY e on s.ID_STUDENT = e.ID_STUDENT group by s.ID_STUDENT, s.NAZWISKO, s.IMIE) loop
        insert into TLSEgzaminy values (student.ID_STUDENT, student.NAZWISKO, student.IMIE, student.egzaminy);
    end loop;
end;

select * from TLSEgzaminy;

-- procedury do inkrementacji i dekrementacji
create or replace procedure increment_TLOEgzaminy(in_id_student STUDENCI.ID_STUDENT%type) is
begin
    update TLSEgzaminy tls set tls.LICZBA_EGZAMINOW = tls.LICZBA_EGZAMINOW + 1 where tls.ID_STUDENT = in_id_student;
end;

create or replace procedure decrement_TLOEgzaminy(in_id_student STUDENCI.ID_STUDENT%type) is
begin
    update TLSEgzaminy tls set tls.LICZBA_EGZAMINOW = tls.LICZBA_EGZAMINOW - 1 where tls.ID_STUDENT = in_id_student;
end;

-- triggery
create or replace trigger BI_Egzaminy_update_TLSEgzaminy before insert on EGZAMINY for each row
begin
    increment_TLOEgzaminy(:NEW.ID_STUDENT);
end;

create or replace trigger BD_Egzaminy_update_TLSEgzaminy before delete on EGZAMINY for each row
begin
    decrement_TLOEgzaminy(:OLD.ID_STUDENT);
end;

-- sprawdzenie
select * from TLSEgzaminy order by 1;

insert into egzaminy (ID_EGZAMIN, ID_STUDENT, ID_PRZEDMIOT, ID_EGZAMINATOR, ID_OSRODEK)
values ((select max(e.ID_EGZAMIN) + 1 from EGZAMINY e), '0000001', '15', '0005', 1)

select * from TLSEgzaminy order by 1;