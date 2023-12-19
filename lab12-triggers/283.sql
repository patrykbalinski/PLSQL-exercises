-- 283.
-- Dla tabeli Osrodki zdefiniować wyzwalacz, który podczas wstawiania lub modyfikacji
-- danych dokona konwersji na duże znaki wartości wprowadzonej do pola Miasto.

create or replace trigger BI_BU_Osrodki before insert or update on OSRODKI for each row
begin
    :NEW.miasto := upper(:new.MIASTO);
end;

-- przed triggerem
select * from OSRODKI o order by o.ID_OSRODEK desc;

-- dodanie wiersza
insert into OSRODKI values ((select max(o.ID_OSRODEK) + 1 from OSRODKI o), 'Test Nazwa', 'lublin');

-- po triggerze
select * from OSRODKI o order by o.ID_OSRODEK desc;