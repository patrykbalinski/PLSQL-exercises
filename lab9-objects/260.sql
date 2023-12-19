/*
Do tabeli Egzaminy_Obj wstawić nowy egzamin. Podczas wstawiania obiektu wierszowego
dokonać kontroli istnienia ośrodka na podstawie tabeli Osrodki_Obj, a przedmiotu – na
podstawie tabeli Przedmioty_Obj. Kontrolę identyfikatorów studenta oraz egzaminatora
przeprowadzić odpowiednio w oparciu o tabele relacyjne Studenci oraz Egzaminatorzy.
*/

declare
    osrodekDoesNotExists exception;
    przedmiotDoesNotExists exception;
    studentDoesNotExists exception;
    egzaminatorDoesNotExists exception;

    v_id_osrodek EGZAMINY.ID_OSRODEK%TYPE;
    v_id_przedmiot EGZAMINY.ID_PRZEDMIOT%TYPE;
    v_id_student EGZAMINY.ID_STUDENT%TYPE;
    v_id_egzaminator EGZAMINY.ID_EGZAMINATOR%TYPE;

    procedure addNewExam(in_id_egzamin EGZAMINY.ID_EGZAMIN%type, in_id_student EGZAMINY.ID_STUDENT%TYPE, in_id_przedmiot EGZAMINY.ID_PRZEDMIOT%TYPE, in_id_egzaminator EGZAMINY.ID_EGZAMINATOR%TYPE, in_data_egzamin EGZAMINY.DATA_EGZAMIN%TYPE, in_id_osrodek EGZAMINY.ID_OSRODEK%TYPE, in_zdal EGZAMINY.ZDAL%TYPE, in_punkty EGZAMINY.PUNKTY%TYPE) is
    begin
        begin
            select distinct o.OSRODEK.ID_OSRODEK into v_id_osrodek from Osrodki_Obj o where o.OSRODEK.ID_OSRODEK = in_id_osrodek;
        exception when NO_DATA_FOUND then
            raise osrodekDoesNotExists;
        end;

        begin
            select distinct p.ID_PRZEDMIOT into v_id_przedmiot from Przedmioty_Obj p where p.ID_PRZEDMIOT = in_id_przedmiot;
        exception when NO_DATA_FOUND then
            raise przedmiotDoesNotExists;
        end;

        begin
            select distinct s.ID_STUDENT into v_id_student from STUDENCI s where s.ID_STUDENT = in_id_student;
        exception when NO_DATA_FOUND then
            raise studentDoesNotExists;
        end;

        begin
            select distinct e.ID_EGZAMINATOR into v_id_egzaminator from EGZAMINATORZY e where e.ID_EGZAMINATOR = in_id_egzaminator;
        exception when NO_DATA_FOUND then
            raise egzaminatorDoesNotExists;
        end;

        insert into Egzaminy_Obj values (in_id_egzamin, in_id_student, in_id_przedmiot, in_id_egzaminator, in_data_egzamin, in_id_osrodek, in_zdal, in_punkty);
        commit;
        dbms_output.put_line('Pomyslnie dodano egzamin o id: ' || in_id_egzamin);
    exception
        when osrodekDoesNotExists then dbms_output.put_line('Podany osrodek nie istnieje');
        when przedmiotDoesNotExists then dbms_output.put_line('Podany przedmiot nie istnieje');
        when studentDoesNotExists then dbms_output.put_line('Podany student nie istnieje');
        when egzaminatorDoesNotExists then dbms_output.put_line('Podany egzaminator nie istnieje');
        when others then dbms_output.put_line('Nieoczekiwany blad');
    end;
begin
    addNewExam(1, '0000001', 1, '0001', sysdate, 1, 'T', 4.85);
end;

select * from STUDENCI;
select * from PRZEDMIOTY;
select * from EGZAMINATORZY;
select * from OSRODKI;
select * from EGZAMINY_OBJ e where e.ID_EGZAMIN = 1;