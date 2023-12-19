-- 268.
-- W tabeli Studenci dokonać aktualizacji danych w kolumnie Nr_ECDL oraz Data_ECDL.
-- Wartość Nr_ECDL powinna być równa identyfikatorowi studenta, a Data_ECDL – dacie
-- ostatniego zdanego egzaminu. Wartości te należy wstawić tylko dla tych studentów,
-- którzy zdali już wszystkie przedmioty. W rozwiązaniu zastosować podprogramy typu
-- funkcja i procedura (samodzielnie określić strukturę kodu źródłowego w PL/SQL).

declare
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

    procedure update_ECDL(in_id_student STUDENCI.ID_STUDENT%TYPE) is
        v_last_exam_date date := get_last_exam_date(in_id_student);
    begin
        update STUDENCI s set s.NR_ECDL = in_id_student, s.DATA_ECDL = v_last_exam_date where s.ID_STUDENT = in_id_student;
    end;
begin
    for vc_student in (select s.ID_STUDENT from STUDENCI s for update of s.NR_ECDL, s.DATA_ECDL) loop
        if passed_all_exams(vc_student.ID_STUDENT) then
            update_ECDL(vc_student.ID_STUDENT);
        end if;
    end loop;
end;

select s.* from STUDENCI s;

rollback;