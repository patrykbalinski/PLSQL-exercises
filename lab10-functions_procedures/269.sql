-- 269.
-- Zdefiniować kod PL/SQL, który umożliwi kontrolę liczby egzaminów zdawanych przez
-- studenta z danego przedmiotu. Kontrola ma polegać na uniemożliwieniu wstawienia do
-- tabeli Egzaminy rekordu opisującego taki egzamin w sytuacji, gdy student zdawał już 3
-- razy egzamin z tego przedmiotu. W rozwiązaniu proszę wykorzystać podprogram (-y)
-- PL/SQL, który umożliwi kontrolę liczby egzaminów zdawanych przez studenta z danego
-- przedmiotu. Ponadto, można kod PL/SQL zorganizować w podprogramy PL/SQL,
-- realizujące dodatkowe funkcje, np. generowanie liczby punktów dla egzaminu.

declare
    function number_of_students_exams(in_id_student STUDENCI.ID_STUDENT%TYPE, in_id_przedmiot PRZEDMIOTY.ID_PRZEDMIOT%TYPE) return number is
        v_res number;
    begin
        select count(*)
        into v_res
        from EGZAMINY e
        where e.ID_STUDENT = in_id_student
        and e.ID_PRZEDMIOT = in_id_przedmiot;

        return v_res;
    end;

    function student_can_take_an_exam(in_id_student STUDENCI.ID_STUDENT%TYPE, in_id_przedmiot PRZEDMIOTY.ID_PRZEDMIOT%TYPE) return boolean is
    begin
        return number_of_students_exams(in_id_student, in_id_przedmiot) < 3;
    end;

    function generate_random_points_number return number is
    begin
        return round(dbms_random.value(2, 5.001));
    end;

    function exam_result(in_points_number number) return varchar2 is
    begin
        if in_points_number >= 3 then
            return 'T';
        else
            return 'N';
        end if;
    end;

    procedure add_students_exam(in_id_student EGZAMINY.ID_STUDENT%TYPE,
                                in_id_przedmiot EGZAMINY.ID_PRZEDMIOT%TYPE,
                                in_id_egzaminator EGZAMINY.ID_EGZAMINATOR%TYPE,
                                in_data_egzamin EGZAMINY.DATA_EGZAMIN%TYPE,
                                in_id_osrodek EGZAMINY.ID_OSRODEK%TYPE) is
        v_exam_points number;
        v_exam_result varchar2(1);
    begin
        if student_can_take_an_exam(in_id_student, in_id_przedmiot) then
            v_exam_points := generate_random_points_number();
            v_exam_result := exam_result(v_exam_points);
            insert into EGZAMINY values ((select count(*) + 1 from EGZAMINY e), in_id_student, in_id_przedmiot, in_id_egzaminator, in_data_egzamin, in_id_osrodek, v_exam_result, v_exam_points);
        else
            dbms_output.put_line('ERROR! The student has already taken the exam more than 2 times.');
        end if;
    end;
begin
    add_students_exam('0000001', 1, 0001, sysdate, 1);
end;