/*
Utworzyć tabelę bazy danych o nazwie Analityka_Studenci. Tabela powinna zawierać
informacje o liczbie egzaminów każdego studenta w każdym z ośrodków. W tabeli
utworzyć kolumny opisujące studenta (identyfikator, Nazwisko i imię), ośrodek
(identyfikator i nazwa) oraz liczbę egzaminów studenta w danym ośrodku. Dane dotyczące
ośrodka i liczby egzaminów należy umieścić w kolumnie, będącej tabelą zagnieżdżoną.
Wprowadzić dane do tabeli Analityka_Studenci na podstawie danych zgromadzonych w
tabelach Egzaminy, Osrodki i Studenci.
*/

drop type analityka_osrodek force;
drop type analityka_osrodki force;
drop table Analityka_Studenci;

create or replace type analityka_osrodek is object
(
    id_osrodek       NUMBER(5),
    nazwa_osrodek    VARCHAR2(50),
    liczba_egzaminow NUMBER
);

create or replace type analityka_osrodki is table of analityka_osrodek;

CREATE TABLE Analityka_Studenci
(
    id_student VARCHAR2(7),
    nazwisko   VARCHAR2(25),
    imie       VARCHAR2(15),
    osrodki   analityka_osrodki,
    CONSTRAINT Analityka_Studenci_pk PRIMARY KEY (id_student)
) nested table osrodki store as analityka_osrodki_nt;

select * from Analityka_Studenci;

-- uzupelnienie danych
begin
    for student in (select * from STUDENCI s) loop
        insert into Analityka_Studenci values (student.id_student, student.NAZWISKO, student.IMIE, analityka_osrodki());
        for egz_w_osr in (select s.ID_STUDENT, o.ID_OSRODEK, o.NAZWA_OSRODEK, (select count(*) from EGZAMINY e where e.ID_STUDENT = s.ID_STUDENT and e.ID_OSRODEK = o.ID_OSRODEK) liczba_egzaminow
                            from STUDENCI s
                            cross join OSRODKI o
                            where s.ID_STUDENT = student.ID_STUDENT) loop
            insert into the ( select a.OSRODKI from Analityka_Studenci a where a.id_student = student.ID_STUDENT) values (analityka_osrodek(egz_w_osr.ID_OSRODEK, egz_w_osr.NAZWA_OSRODEK, egz_w_osr.liczba_egzaminow));
        end loop;
    end loop;
end;

select * from Analityka_Studenci;