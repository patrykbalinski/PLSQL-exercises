-- 275.
-- Utworzyć procedurę lub funkcję składowaną, która dokona weryfikacji poprawności
-- wartości pola Nr_ECDL w tabeli Studenci. Weryfikacja tej wartości jest dwuetapowa.
-- Pierwszy etap to sprawdzenie, czy wartość ta może wystąpić. Warunkiem istnienia tej
-- wartości jest zdanie przez studenta egzaminów ze wszystkich przedmiotów, które znajdują
-- się w tabeli Przedmioty. Drugi etap polega na sprawdzeniu, czy wartość występująca w tym
-- polu w danym wierszu jest równa identyfikatorowi studenta, którego ten wiersz dotyczy.
-- Następnie wykorzystać ten podprogram w bloku PL/SQL, w którym zostanie sprawdzony
-- każdy rekord w tabeli Studenci. Jeżeli istnieje rekord, który nie zostanie pozytywnie
-- zweryfikowany, należy go skopiować do tabeli St_NrInvalid, która zawiera kolumny
-- ID_Student, Nazwisko i Imie (tabelę należy utworzyć przed walidacją danych).

CREATE TABLE St_NrInvalid
  AS (SELECT s.ID_STUDENT, s.IMIE, s.NAZWISKO FROM STUDENCI s where 1=0);

begin
    -- student ktory zdal egzaminy ale ma zly nr_ecdl
    insert into STUDENCI s (ID_STUDENT, NAZWISKO, IMIE, NR_ECDL) values ('9999999', 'nazwisko1', 'imie1', '1');
    for vc_przedmioty in (select p.ID_PRZEDMIOT from PRZEDMIOTY p) loop
        insert into EGZAMINY e (ID_EGZAMIN, ID_STUDENT, ID_PRZEDMIOT, ID_EGZAMINATOR, DATA_EGZAMIN, ID_OSRODEK, ZDAL, PUNKTY) values ((select max(e.ID_EGZAMIN) + 1 from EGZAMINY e), '9999999', vc_przedmioty.ID_PRZEDMIOT, '0001', sysdate, 1, 'T', 5.0);
    end loop;
    -- student ktory nie zdal egzaminow ale ma poprawny nr_ecdl
    insert into STUDENCI s (ID_STUDENT, NAZWISKO, IMIE, NR_ECDL) values ('9999998', 'nazwisko2', 'imie2', '9999998');
    -- student ktory nie zdal egzaminow i nie ma poprawnego nr_ecdl
    insert into STUDENCI s (ID_STUDENT, NAZWISKO, IMIE, NR_ECDL) values ('9999997', 'nazwisko3', 'imie3', '2');
end;

select * from studenci s order by s.ID_STUDENT desc;
select * from EGZAMINY e where e.ID_STUDENT in ('9999999');

create or replace function check_nr_ecdl_valid(in_student_id STUDENCI.ID_STUDENT%TYPE, in_nr_ecdl STUDENCI.NR_ECDL%TYPE) return boolean is
    function passed_all_exams(in_id_student STUDENCI.ID_STUDENT%TYPE) return boolean is
        v_number_of_subjects number;
        v_number_of_passed_subjects number;
    begin
        select count(*)
        into v_number_of_subjects
        from PRZEDMIOTY p;

        select count(distinct e.ID_PRZEDMIOT)
        into v_number_of_passed_subjects
        from EGZAMINY e
        where e.ID_STUDENT = in_id_student
          and e.ZDAL = 'T';

        return v_number_of_subjects = v_number_of_passed_subjects;
    end;
begin
    /*if in_nr_ecdl is not null and not passed_all_exams(in_student_id) then
      return false;
    elsif in_nr_ecdl is not null and in_student_id != in_nr_ecdl then
      return false;
    end if;

    return true;*/

    return (in_nr_ecdl is null) or
        (in_nr_ecdl is not null and (passed_all_exams(in_student_id) and
                                     in_nr_ecdl = in_student_id));
end;

begin
    for vc_student in (select * from STUDENCI s) loop
        if not check_nr_ecdl_valid(vc_student.ID_STUDENT, vc_student.NR_ECDL) then
            dbms_output.put_line(vc_student.ID_STUDENT);

            merge into St_NrInvalid st
            using dual
            on (st.ID_STUDENT = vc_student.ID_STUDENT)
            when not matched then
                insert (ID_STUDENT, IMIE, NAZWISKO)
                values (vc_student.ID_STUDENT, vc_student.IMIE, vc_student.NAZWISKO);
        end if;
    end loop;
end;

select * from St_NrInvalid;

rollback;