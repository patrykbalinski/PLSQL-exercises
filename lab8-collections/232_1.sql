/*
Utworzyć tabelę bazy danych o nazwie Indeks. Tabela powinna zawierać informacje o
studencie (identyfikator, Nazwisko, imię), przedmiotach (nazwa przedmiotu), z których
student zdał już swoje egzaminy oraz datę zdanego egzaminu. Lista przedmiotów wraz z
datami dla danego studenta powinna być kolumną typu tabela zagnieżdżona. Dane w tabeli
Indeks należy wygenerować na podstawie zawartości tabeli Egzaminy, Studenci oraz
Przedmioty.
*/

drop type passed_exam force;
drop type passed_exams force;
drop table Indeks;

create or replace type passed_exam is object
(
    nazwa_przedmiot      VARCHAR2(100),
    data_zdania_egzaminu DATE
);

create or replace type passed_exams is table of passed_exam;

CREATE TABLE Indeks
(
    id_student       VARCHAR2(7),
    imie_student     VARCHAR2(15),
    nazwisko_student VARCHAR2(25),
    zdane_egzaminy   passed_exams,
    CONSTRAINT Index_pk PRIMARY KEY (id_student)
) nested table zdane_egzaminy store as zdane_egzaminy_tab;

select * from INDEKS;

--uzupelnienie danych
declare
    v_passed_exams passed_exams := passed_exams();
    v_i number;
begin
    for student in (select * from STUDENCI s) loop
        for zdany_egzamin in (select p.NAZWA_PRZEDMIOT, max(e.DATA_EGZAMIN) max_data_egzamin from EGZAMINY e
                                inner join PRZEDMIOTY p on p.ID_PRZEDMIOT = e.ID_PRZEDMIOT
                            where e.ID_STUDENT = student.ID_STUDENT
                              and e.ID_PRZEDMIOT in (select distinct e.ID_PRZEDMIOT from EGZAMINY e where e.ID_STUDENT = '0000001' and e.ZDAL = 'T')
                                and e.ZDAL = 'T'
                            group by e.ID_STUDENT, p.NAZWA_PRZEDMIOT) loop
                v_passed_exams.extend();
                v_i := v_passed_exams.count();
                v_passed_exams(v_i) := passed_exam(zdany_egzamin.NAZWA_PRZEDMIOT, zdany_egzamin.max_data_egzamin);
            end loop;
        insert into Indeks values (student.ID_STUDENT, student.IMIE, student.NAZWISKO, v_passed_exams);
        v_passed_exams := passed_exams();
    end loop;
end;

select * from INDEKS;