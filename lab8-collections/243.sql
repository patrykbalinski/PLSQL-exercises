-- 243.
-- Utworzyć tabelę bazy danych o nazwie Analityka_Egzaminy. Tabela powinna zawierać
-- informacje o liczbie niezdanych egzaminów poszczególnych studentów z poszczególnych
-- przedmiotów oraz ogólnej liczbie egzaminów studenta z danego przedmiotu. W tabeli
-- utworzyć kolumny opisujące studenta (identyfikator, Nazwisko i imię), przedmiot (nazwa),
-- liczbę niezdanych egzaminów z przedmiotu oraz liczbę wszystkich egzaminów studenta z
-- danego przedmiotu. Dane dotyczące przedmiotu oraz poszczególnych liczb należy umieścić
-- w kolumnie, będącej tabelą zagnieżdżoną. Wprowadzić dane do tabeli Analityka_Egzaminy
-- na podstawie danych zgromadzonych w tabelach Egzaminy, Przedmioty i Studenci.

drop type analityka_przedmiot force;
drop type analityka_przedmioty force;
drop table Analityka_Egzaminy;

create or replace type analityka_przedmiot is object
(
    nazwa_przedmiot VARCHAR2(100),
    liczba_egzaminow NUMBER,
    liczba_niezdanych_egzaminow NUMBER
);

create or replace type analityka_przedmioty is table of analityka_przedmiot;

CREATE TABLE Analityka_Egzaminy
(
    id_student VARCHAR2(7),
    nazwisko   VARCHAR2(25),
    imie       VARCHAR2(15),
    przedmioty   analityka_przedmioty,
    CONSTRAINT Analityka_Egzaminy_pk PRIMARY KEY (id_student)
) nested table przedmioty store as analityka_przedmioty_nt;

select * from Analityka_Egzaminy;

-- uzupelnienie danych
begin
    for student in (select * from STUDENCI s) loop
        insert into Analityka_Egzaminy values (student.id_student, student.NAZWISKO, student.IMIE, analityka_przedmioty());
        for egz_z_przedmiotu in (select p.NAZWA_PRZEDMIOT, p.ID_PRZEDMIOT, (select count(*) from EGZAMINY e where e.ID_STUDENT = student.ID_STUDENT and e.ID_PRZEDMIOT = p.ID_PRZEDMIOT) liczba_egzaminow, count(e.ID_EGZAMIN) liczba_niezdanych_egzaminow from EGZAMINY e
                                    inner join PRZEDMIOTY p on e.ID_PRZEDMIOT = p.ID_PRZEDMIOT
                                    where e.ID_STUDENT = student.ID_STUDENT
                                    and e.ZDAL = 'N'
                                    group by p.NAZWA_PRZEDMIOT, p.ID_PRZEDMIOT) loop
            insert into the ( select a.przedmioty from Analityka_Egzaminy a where a.id_student = student.ID_STUDENT) values (analityka_przedmiot(egz_z_przedmiotu.NAZWA_PRZEDMIOT, egz_z_przedmiotu.liczba_egzaminow, egz_z_przedmiotu.liczba_niezdanych_egzaminow));
        end loop;
    end loop;
end;

select * from Analityka_Egzaminy;