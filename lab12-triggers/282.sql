-- 282.
-- Dla tabeli Egzaminy zdefiniować trigger dla operacji wstawiania nowego rekordu. Będzie
-- on automatycznie wstawiał datę systemową w polu Data_Egzamin w przypadku, gdy
-- wartości takiej nie podano w instrukcji INSERT.

create or replace trigger BI_Egzaminy before insert on EGZAMINY for each row
begin
    if :new.Data_Egzamin is null then
        :new.Data_Egzamin := sysdate;
    end if;
end;

-- przed triggerem
select * from EGZAMINY e order by e.ID_EGZAMIN desc;

-- dodanie wiersza
insert into egzaminy (ID_EGZAMIN, ID_STUDENT, ID_PRZEDMIOT, ID_EGZAMINATOR, ID_OSRODEK)
values ((select max(e.ID_EGZAMIN) + 1 from EGZAMINY e), '0000018', '15', '0005', 8);

-- po triggerze
select * from EGZAMINY e order by e.ID_EGZAMIN desc;
