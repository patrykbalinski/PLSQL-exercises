-- 274.
-- Utworzyć procedurę składowaną, która dokona weryfikacji poprawności daty ECDL w
-- tabeli Studenci. Data ta może istnieć w tej kolumnie, jeśli student zdał wszystkie
-- przedmioty oraz musi być większa od daty ostatniego zdanego egzaminu przez studenta,
-- jeśli pierwszy warunek jest spełniony. Jeśli powyższe warunki nie są spełnione, wówczas
-- należy błędny rekord skopiować do tabeli St_DateInvalid, która zawiera kolumny
-- ID_Student, Nazwisko i Imie (tabelę należy utworzyć przed walidacją danych).

CREATE TABLE St_DateInvalid
  AS (SELECT s.ID_STUDENT, s.IMIE, s.NAZWISKO FROM STUDENCI s where 1=0);

insert into STUDENCI s (ID_STUDENT, NAZWISKO, IMIE, DATA_ECDL) values ('9999999', 'nazwisko', 'imie', sysdate);

select * from studenci s;

create or replace procedure data_ecdl_valid(in_student_id STUDENCI.ID_STUDENT%TYPE, in_data_ecdl STUDENCI.DATA_ECDL%TYPE, out_is_valid out boolean) as
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

    function get_last_exam_date(in_id_student STUDENCI.ID_STUDENT%TYPE) return date is
        v_last_exam_date date;
    begin
        select max(e.DATA_EGZAMIN)
        into v_last_exam_date
        from EGZAMINY e
        where e.ID_STUDENT = in_id_student
          and e.ZDAL = 'T';

        return v_last_exam_date;
    end;
begin
    out_is_valid := (in_data_ecdl is null) or
                    (in_data_ecdl is not null and (passed_all_exams(in_student_id) and
                                                   in_data_ecdl > get_last_exam_date(in_student_id)));
end;

declare
    v_is_data_ecdl_valid boolean;
begin
    for vc_student in (select * from STUDENCI s) loop
        data_ecdl_valid(vc_student.ID_STUDENT, vc_student.DATA_ECDL, v_is_data_ecdl_valid);

         if not v_is_data_ecdl_valid then
             dbms_output.put_line(vc_student.ID_STUDENT);
             insert into St_DateInvalid values (vc_student.ID_STUDENT, vc_student.IMIE, vc_student.NAZWISKO);
         end if;
    end loop;
end;

select * from St_DateInvalid;