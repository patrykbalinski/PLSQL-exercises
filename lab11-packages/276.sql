-- 276.
-- Utworzyć funkcję składowaną, która będzie kontrolowała proces wprowadzania danych do
-- tabeli Egzaminy. Funkcja powinna zwrócić wartość FALSE, jeśli podjęto próbę
-- wprowadzenia egzaminu z przedmiotu, który został już zdany przez studenta. Jako
-- parametry funkcji przyjąć identyfikator studenta, identyfikator przedmiotu oraz wynik
-- egzaminu.

create or replace function check_students_exam(studentsID STUDENCI.ID_STUDENT%TYPE, subjectID PRZEDMIOTY.ID_PRZEDMIOT%TYPE) return boolean is
    v_passed_exams_number number;
begin
    select count(*) into v_passed_exams_number from EGZAMINY e where e.ID_STUDENT = studentsID and e.ID_PRZEDMIOT = subjectID and e.ZDAL = 'T';

    return v_passed_exams_number < 1;
end;

select distinct e.ID_PRZEDMIOT from EGZAMINY e where e.ID_STUDENT = '0000001' order by 1;

-- dodanie nowego przedmiotu
insert into PRZEDMIOTY p values (99, 'Testowy Przedmiot', null);

select * from PRZEDMIOTY

-- test pozytywny
begin
    if check_students_exam('0000001', 99) then
        dbms_output.put_line('valid');
    else
        dbms_output.put_line('invalid');
    end if;
end;

-- test negatywny
begin
    if check_students_exam('0000001', 5) then
        dbms_output.put_line('valid');
    else
        dbms_output.put_line('invalid');
    end if;
end;