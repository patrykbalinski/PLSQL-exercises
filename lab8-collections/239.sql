/*
Utworzyć tabelę o zmiennym rozmiarze i nazwać ją VT_Studenci. Tabela powinna zawierać
elementy opisujące liczbę egzaminów każdego studenta. Zainicjować wartości elementów
na podstawie danych z tabel Studenci i Egzaminy. Zapewnić, by studenci umieszczeni w
kolejnych elementach uporządkowani byli wg liczby zdawanych egzaminów, od
największej do najmniejszej. Po zainicjowaniu tabeli, wyświetlić wartości znajdujące się w
poszczególnych jej elementach.
*/

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
begin
    -- dodanie danych do tabeli
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
    for i in 1 .. v_egzaminy_studentow.count() loop
        dbms_output.put_line(v_egzaminy_studentow(i).id_student || ', ' || v_egzaminy_studentow(i).imie || ', ' || v_egzaminy_studentow(i).nazwisko || ', ' || v_egzaminy_studentow(i).liczba_egzaminow);
    end loop;
end;