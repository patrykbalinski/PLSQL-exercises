-- 215.
-- Przeprowadzić kontrolę wprowadzenia rekordu do tabeli egzaminy. Kontrola ta ma
-- uniemożliwić wstawienie niezdanego egzaminu określonego studenta z danego przedmiotu
-- w sytuacji, gdy taki przedmiot został już zdany przez tego studenta. Zadanie należy
-- rozwiązać z użyciem techniki wyjątków. Jeśli wstawiany rekord narusza powyższą zasadę,
-- wówczas należy wyświetlić odpowiedni komunikat. Jeśli nie – rekord z takim egzaminem
-- należy wstawić do tabeli Egzaminy.

declare
    v_examin EGZAMINY%rowtype;

    studentAlreadyPassedExamException exception;

    function passedExamsCount(in_id_student STUDENCI.ID_STUDENT%TYPE, in_id_przedmiot PRZEDMIOTY.ID_PRZEDMIOT%TYPE) return number is
        v_count number;
    begin
        select count(*)
        into v_count
        from EGZAMINY e
        where e.ID_STUDENT = in_id_student
        and e.ID_PRZEDMIOT = in_id_przedmiot
        and e.ZDAL = 'T';

        return v_count;
    end;

    procedure addNewExam(in_id_egzamin EGZAMINY.ID_EGZAMIN%type, in_id_student EGZAMINY.ID_STUDENT%TYPE, in_id_przedmiot EGZAMINY.ID_PRZEDMIOT%TYPE, in_id_egzaminator EGZAMINY.ID_EGZAMINATOR%TYPE, in_data_egzamin EGZAMINY.DATA_EGZAMIN%TYPE, in_id_osrodek EGZAMINY.ID_OSRODEK%TYPE, in_zdal EGZAMINY.ZDAL%TYPE, in_punkty EGZAMINY.PUNKTY%TYPE) is
    begin
        if passedExamsCount(in_id_student, in_id_przedmiot) > 0 and in_zdal = 'N' then
            raise studentAlreadyPassedExamException;
        end if;

        insert into EGZAMINY values (in_id_egzamin, in_id_student, in_id_przedmiot, in_id_egzaminator, in_data_egzamin, in_id_osrodek, in_zdal, in_punkty);

        dbms_output.put_line('Successfully added exam with id: ' || in_id_egzamin);
    exception
        when studentAlreadyPassedExamException then dbms_output.put_line('ERROR! Student (' || in_id_student || ') already passed exam from this subject (' || in_id_przedmiot || ')');
        when others then dbms_output.put_line('ERROR! Unexpected error');
    end;
begin
    select * into v_examin from EGZAMINY e where e.ZDAL = 'T' order by e.ID_EGZAMIN fetch first 1 row only;

    addNewExam(v_examin.ID_EGZAMIN, v_examin.ID_STUDENT, v_examin.ID_PRZEDMIOT, v_examin.ID_EGZAMINATOR, v_examin.DATA_EGZAMIN, v_examin.ID_OSRODEK, 'N', v_examin.PUNKTY);
end;