-- 265.
-- Wyświetlić informację o liczbie punktów uzyskanych z egzaminów przez każdego
-- studenta. W odpowiedzi należy uwzględnić również tych studentów, którzy jeszcze nie
-- zdawali egzaminów. Liczbę punktów należy wyznaczyć używając funkcji. Jeżeli student
-- nie zdawał egzaminu, należy wyświetlić odpowiedni komunikat. Zadanie należy
-- zrealizować, wykorzystując kod PL/SQL.

select sum(e.PUNKTY) from egzaminy e where e.ID_STUDENT = '0000019';

insert into STUDENCI s (ID_STUDENT, IMIE, NAZWISKO) values ('0000019', 'TEST', 'TEST');

declare
    function get_points_number(in_id_student STUDENCI.ID_STUDENT%TYPE) return number is
        v_points_number number;
    begin
        select sum(e.PUNKTY)
        into v_points_number
        from EGZAMINY e
        where e.ID_STUDENT = in_id_student;

        return v_points_number;
    end;
begin
    for vc_student in (select * from STUDENCI) loop
        if get_points_number(STUDENCI.ID_STUDENT) is null then
            dbms_output.put_line('student o id: ' || vc_student.ID_STUDENT || ' nie zdawal zadnego egzaminu');
        else
            dbms_output.put_line('STUDENT(ID): ' || vc_student.ID_STUDENT || get_points_number(vc_student.ID_STUDENT));
        end if;
    end loop;
end;

rollback;