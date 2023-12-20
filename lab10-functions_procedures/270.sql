-- 270.
-- Utworzyć procedurę o nazwie SprawdzRefEgzaminy. Zadaniem procedury będzie kontrola
-- poprawności wartości identyfikatorów: przedmiotu, ośrodka, studenta oraz egzaminatora,
-- wprowadzanych do tabeli Egzaminy. Wartości identyfikatorów powinny odpowiadać
-- istniejącym wartościom w odpowiednich tabelach. Następnie zdefiniować zmienne,
-- których wartości będą równe wartościom poszczególnych identyfikatorów i użyć tych
-- zmiennych w instrukcji wstawienia rekordu do tabeli Egzaminy. Przed wykonaniem
-- wstawienia sprawdzić poprawność wartości zmiennych przy pomocy procedury,
-- przekazując jako parametry poszczególne zmienne. W przypadku, gdy wartość
-- identyfikatora nie istnieje, należy zgłosić wyjątek i obsłużyć go, wyświetlając odpowiedni
-- komunikat.

declare
    WRONG_EXAM_REFERENCE exception;

    procedure SprawdzRefEgzaminy(in_id_student EGZAMINY.ID_STUDENT%TYPE,
                                 in_id_przedmiot EGZAMINY.ID_PRZEDMIOT%TYPE,
                                 in_id_egzaminator EGZAMINY.ID_EGZAMINATOR%TYPE,
                                 in_id_osrodek EGZAMINY.ID_OSRODEK%TYPE) is
        v_id_student EGZAMINY.ID_STUDENT%TYPE;
        v_id_przedmiot EGZAMINY.ID_PRZEDMIOT%TYPE;
        v_id_egzaminator EGZAMINY.ID_EGZAMINATOR%TYPE;
        v_id_osrodek EGZAMINY.ID_OSRODEK%TYPE;
    begin
        begin
            select s.ID_STUDENT into v_id_student from STUDENCI s where s.ID_STUDENT = in_id_student;
            select p.ID_PRZEDMIOT into v_id_przedmiot from PRZEDMIOTY p where p.ID_PRZEDMIOT = in_id_przedmiot;
            select e.ID_EGZAMINATOR into v_id_egzaminator from EGZAMINATORZY e where e.ID_EGZAMINATOR = in_id_egzaminator;
            select o.ID_OSRODEK into v_id_osrodek from OSRODKI o where o.ID_OSRODEK = in_id_osrodek;
        exception when NO_DATA_FOUND then
            raise WRONG_EXAM_REFERENCE;
        end;
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

    procedure add_exam(in_id_student EGZAMINY.ID_STUDENT%TYPE,
                       in_id_przedmiot EGZAMINY.ID_PRZEDMIOT%TYPE,
                       in_id_egzaminator EGZAMINY.ID_EGZAMINATOR%TYPE,
                       in_id_osrodek EGZAMINY.ID_OSRODEK%TYPE) is
        v_exam_points number;
        v_exam_result varchar2(1);
    begin
        SprawdzRefEgzaminy(in_id_student, in_id_przedmiot, in_id_egzaminator,in_id_osrodek);

        v_exam_points := generate_random_points_number();
        v_exam_result := exam_result(v_exam_points);
        insert into EGZAMINY values ((select count(*) + 1 from EGZAMINY e), in_id_student, in_id_przedmiot, in_id_egzaminator, sysdate, in_id_osrodek, v_exam_result, v_exam_points);
    end;
begin
    add_exam(123456789, 123456789, 123456789, 123456789);
exception
    when WRONG_EXAM_REFERENCE then
        dbms_output.put_line('ERROR! Wrong exam references.');
    when others then
        dbms_output.put_line('ERROR! An unexpected error occurred/');
end;