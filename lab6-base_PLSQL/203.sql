-- 203.
-- Dla tabeli Osrodki zdefiniować odpowiedni trigger, który podczas operacji usuwania
-- ośrodka z tej tabeli będzie kontrolował, czy w tabeli Egzaminy istnieją egzaminy
-- powiązane z tym ośrodkiem. Jeśli takie egzaminy istnieją, należy wyświetlić komunikat
-- "Nie można usunąć ośrodka, gdyż istnieją dla niego powiązane egzaminy".

-- sposob 1 - rzucanie dynamicznego wyjatku
create or replace trigger BD_Osrodki_check_egzaminy
    before insert
    on OSRODKI
    for each row
declare
    v_egzams_number number;
begin
    select count(*)
    into v_egzams_number
    from EGZAMINY e
    where e.ID_OSRODEK = :NEW.ID_OSRODEK;

    if v_egzams_number > 0 then
        raise_application_error(-20000, 'Nie można usunąć ośrodka, gdyż istnieją dla niego powiązane egzaminy');
    end if;
end;

-- sposob 2 - deklaracja i obsluzenie wlasnego wyjatku
create or replace trigger BD_Osrodki before delete on OSRODKI for each row
declare
    v_exams_number number;
    recordCannotBeDeleted exception;
    PRAGMA EXCEPTION_INIT (recordCannotBeDeleted, -20002);
begin
    select count(e.ID_EGZAMIN) into v_exams_number from EGZAMINY e where e.ID_OSRODEK = :OLD.ID_OSRODEK;

    if v_exams_number > 0 then
        raise recordCannotBeDeleted;
    end if;
end;

-- przed triggerem
select o.ID_OSRODEK, count(e.ID_EGZAMIN) from OSRODKI o left join EGZAMINY e on o.ID_OSRODEK = e.ID_OSRODEK group by o.ID_OSRODEK order by 2;

-- usuniecie wiersza
declare
    recordCannotBeDeleted exception;
    PRAGMA EXCEPTION_INIT (recordCannotBeDeleted, -20002);
begin
    delete from OSRODKI o where o.ID_OSRODEK = 1;
exception
when recordCannotBeDeleted then
    dbms_output.put_line('Nie można usunąć ośrodka, gdyż istnieją dla niego powiązane egzaminy');
when others then
    dbms_output.put_line(sqlerrm);
end;

-- po triggerze
select o.ID_OSRODEK, count(e.ID_EGZAMIN) from OSRODKI o left join EGZAMINY e on o.ID_OSRODEK = e.ID_OSRODEK group by o.ID_OSRODEK order by 2;