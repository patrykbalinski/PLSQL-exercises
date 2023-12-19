-- 216.
-- Przeprowadzić kontrolę danych w tabeli Studenci, polegającą na weryfikacji możliwości
-- istnienia wartości w kolumnach Nr_ECDL i Data_ECDL. Wartości w tych kolumnach
-- mogą istnieć tylko wówczas, gdy student zdał wszystkie przedmioty. Zadanie należy
-- rozwiązać z użyciem techniki wyjątków. Jako wyjątek należy uznać istnienie wartości w
-- podanych w kolumnach w sytuacji, gdy student nie zdał wszystkich przedmiotów. Jeśli
-- zostanie zidentyfikowany taki student to należy wyświetlić jego dane, tj. identyfikator,
-- nazwisko i imię.

--update STUDENCI s set s.NR_ECDL = s.ID_STUDENT where s.ID_STUDENT in ('0000001', '0000003', '0000005');
--update STUDENCI s set s.DATA_ECDL = sysdate where s.ID_STUDENT in ('0000002', '0000004', '0000006');

declare
    v_number_of_subjects number;
    v_number_of_passed_subjects number;

    e_invalid_value_in_Nr_ECDL exception;
    e_invalid_value_in_Data_ECDL exception;
begin
    select count(*)
    into v_number_of_subjects
    from PRZEDMIOTY p;

    for vc_student in (select * from STUDENCI s) loop
        begin
            select count(distinct e.ID_PRZEDMIOT)
            into v_number_of_passed_subjects
            from EGZAMINY e
            where e.ID_STUDENT = vc_student.ID_STUDENT
              and e.ZDAL = 'T';

            if vc_student.NR_ECDL is not null and v_number_of_subjects != v_number_of_passed_subjects then
                raise e_invalid_value_in_Nr_ECDL;
            elsif vc_student.DATA_ECDL is not null and v_number_of_subjects != v_number_of_passed_subjects then
                raise e_invalid_value_in_Data_ECDL;
            end if;

        exception
            when e_invalid_value_in_Nr_ECDL then
                dbms_output.put_line('Niepoprawna wartosc w polu STUDENCI.NR_ECDL dla studenta o ID: ' || vc_student.ID_STUDENT || ' (' || vc_student.IMIE || ' ' || vc_student.NAZWISKO || ')');
            when e_invalid_value_in_Data_ECDL then
                dbms_output.put_line('Niepoprawna wartosc w polu STUDENCI.DATA_ECDL dla studenta o ID: ' || vc_student.ID_STUDENT || ' (' || vc_student.IMIE || ' ' || vc_student.NAZWISKO || ')');
        end;
    end loop;
end;

--rollback;