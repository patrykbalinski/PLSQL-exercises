/*
Zmodyfikować kod źródłowy poprzedniego zadania tak, aby usunąć z tabeli VT_Studenci
elementy, odpowiadające studentom, którzy nie przystąpili jeszcze do egzaminu
*/

-- https://docs.oracle.com/cd/B19306_01/appdev.102/b14261/collection_method.htm
-- Varrays are dense, so you cannot delete their individual elements.
-- Because PL/SQL keeps placeholders for deleted elements, you can replace a deleted element by assigning it a new value.
-- However, PL/SQL does not keep placeholders for trimmed elements.

declare
    type egzaminy_studenta is record
       (
           id_student       STUDENCI.ID_STUDENT%TYPE,
           nazwisko         STUDENCI.NAZWISKO%TYPE,
           imie             STUDENCI.IMIE%TYPE,
           liczba_egzaminow NUMBER
       );
    type egzaminy_studentow is VARRAY(999) of egzaminy_studenta;
    v_egzaminy_studentow egzaminy_studentow := egzaminy_studentow();
    v_i number;

    procedure delete_from_varray(out_egzaminy_studentow in out egzaminy_studentow, in_index number) is
        v_egzaminy_studentow egzaminy_studentow := egzaminy_studentow();
        v_i number;
    begin
        for i in 1 .. out_egzaminy_studentow.count() loop
            if i != in_index then
                v_egzaminy_studentow.extend();
                v_i := v_egzaminy_studentow.count();
                v_egzaminy_studentow(v_i) := out_egzaminy_studentow(i);
            end if;
        end loop;
        out_egzaminy_studentow := v_egzaminy_studentow;
    end;

    procedure usun_studentow_bez_egzaminow(out_egzaminy_studentow in out egzaminy_studentow) is
    begin
        for i in 1 .. out_egzaminy_studentow.count() loop
            if out_egzaminy_studentow(i).liczba_egzaminow = 0 then
                delete_from_varray(out_egzaminy_studentow, i);
            end if;
        end loop;
    end;
begin
    for student_egzaminy in (select s.ID_STUDENT, s.NAZWISKO, s.IMIE, count(e.ID_EGZAMIN) liczba_egzaminow
                             from STUDENCI s
                                      left join EGZAMINY e on s.ID_STUDENT = e.ID_STUDENT
                             group by s.ID_STUDENT, s.NAZWISKO, s.IMIE
                             order by liczba_egzaminow desc) loop
    v_egzaminy_studentow.extend();
    v_i := v_egzaminy_studentow.count();
    v_egzaminy_studentow(v_i) := egzaminy_studenta(student_egzaminy.ID_STUDENT, student_egzaminy.NAZWISKO, student_egzaminy.IMIE, student_egzaminy.liczba_egzaminow);
    end loop;

    -- wyswietelnie tabeli
    dbms_output.put_line('przed usunieciem:');
    for i in 1 .. v_egzaminy_studentow.count() loop
        dbms_output.put_line(v_egzaminy_studentow(i).id_student || ', ' || v_egzaminy_studentow(i).imie || ', ' || v_egzaminy_studentow(i).nazwisko || ', ' || v_egzaminy_studentow(i).liczba_egzaminow);
    end loop;

    usun_studentow_bez_egzaminow(v_egzaminy_studentow);

    dbms_output.put_line('po usunieciu:');
    for i in 1 .. v_egzaminy_studentow.count() loop
        dbms_output.put_line(v_egzaminy_studentow(i).id_student || ', ' || v_egzaminy_studentow(i).imie || ', ' || v_egzaminy_studentow(i).nazwisko || ', ' || v_egzaminy_studentow(i).liczba_egzaminow);
    end loop;
end;