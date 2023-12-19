-- 287.
-- Dla tabeli Egzaminy zdefiniować odpowiedni wyzwalacz, który zrealizuje aktualizację
-- danych w tabeli Studenci w kolumnie Nr_ECDL oraz Data_ECDL. Wartość Nr_ECDL
-- powinna być równa identyfikatorowi studenta, a Data_ECDL – dacie ostatniego zdanego
-- egzaminu. Wartości te należy wstawić tylko dla tych studentów, którzy zdali już wszystkie
-- przedmioty (tj. te, które znajdują się w tabeli Przedmioty). Modyfikacja danych w tabeli
-- Studenci powinna odbyć się automatycznie po zdaniu przez studenta ostatniego egzaminu i
-- wprowadzeniu danych na ten temat. W rozwiązaniu zastosować podprogramy typu funkcja
-- i procedura (samodzielnie określić strukturę kodu źródłowego w PL/SQL).

select * from STUDENCI s;

create or replace function student_passed_all_exams(in_id_student STUDENCI.ID_STUDENT%TYPE) return boolean is
    v_przedmioty_count number;
    v_students_przedmioty_count number;
begin
    select count(*) into v_przedmioty_count from PRZEDMIOTY p;
    select count(distinct ID_PRZEDMIOT) into v_students_przedmioty_count from EGZAMINY e where e.ID_STUDENT = in_id_student and e.ZDAL = 'T';
    return v_przedmioty_count = v_students_przedmioty_count;
end;

create or replace procedure update_student_ECDL(in_id_student STUDENCI.ID_STUDENT%TYPE, last_exam_date STUDENCI.DATA_ECDL%TYPE) is
begin
    update STUDENCI s set s.NR_ECDL = s.ID_STUDENT, s.DATA_ECDL = last_exam_date where s.ID_STUDENT = in_id_student;
end;

create or replace trigger AI_EGZAMINY_ECDL after insert on EGZAMINY for each row
begin
    if student_passed_all_exams(:NEW.ID_STUDENT) then
        update_student_ECDL(:NEW.ID_STUDENT, :NEW.DATA_EGZAMIN);
    end if;
end;

begin
    if student_passed_all_exams('0000001') then
        dbms_output.put_line('zdal wszystko');
    else
        dbms_output.put_line('nie zdal wszystko');
    end if;
end;

-- test przed (student 0000001 nie ma ustawionych nr_ecdl i data_ecdl)
select * from STUDENCI s;

-- zeby przetestowac trzeba dla studenta '0000001' dodac zdany egzamin z przedmiotu 12 (tylko tego przedmiotu jeszcze nie zdal)
select distinct e.ID_PRZEDMIOT from EGZAMINY e where e.ID_STUDENT = '0000001' and e.ZDAL = 'T' order by 1;

insert into EGZAMINY values ((select max(e.ID_EGZAMIN) + 1 from EGZAMINY e), '0000001', 12, '0002', sysdate, 1, 'T', 4.55);

-- test po (ma dane)
select * from STUDENCI s;

select * from EGZAMINY e where e.ID_STUDENT = '0000001' order by e.ID_EGZAMIN desc;