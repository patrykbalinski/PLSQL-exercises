-- 288.
-- Dla tabeli Egzaminy zdefiniować wyzwalacz, który będzie wstawiał wartość w polu Punkty
-- w momencie wstawienia nowego rekordu lub aktualizacji rekordu istniejącego. Wstawienie
-- wartości 2 lub 5 w polu Punkty będzie odbywało się na podstawie danej z kolumny Zdal.
-- Jeżeli wartość w kolumnie Zdal jest równa Y, wówczas należy przyznać 5 punktów. Jeżeli
-- wartość w kolumnie Zdal jest równa N – 2 punkty. Jeśli wartość w polu Zdal jest równa
-- NULL, przyjąć założenie, że egzamin był niezdany.

select * from EGZAMINY e;

create or replace trigger BI_BU_Egzaminy_punkty before insert or update on EGZAMINY for each row
begin
    if :NEW.ZDAL = 'T' then
        :NEW.PUNKTY := 5;
    else
        :NEW.PUNKTY := 2;
    end if;
end;

-- przed triggerem
select * from EGZAMINY e order by e.ID_EGZAMIN desc;

-- dodanie wiersza ze zdaniem
insert into egzaminy (ID_EGZAMIN, ID_STUDENT, ID_PRZEDMIOT, ID_EGZAMINATOR, ID_OSRODEK, ZDAL)
values ((select max(e.ID_EGZAMIN) + 1 from EGZAMINY e), '0000018', '15', '0005', 8, 'T');

-- dodanie wiersza z niezdaniem
insert into egzaminy (ID_EGZAMIN, ID_STUDENT, ID_PRZEDMIOT, ID_EGZAMINATOR, ID_OSRODEK, ZDAL)
values ((select max(e.ID_EGZAMIN) + 1 from EGZAMINY e), '0000018', '15', '0005', 8, 'N');

-- dodanie wiersza z nullem
insert into egzaminy (ID_EGZAMIN, ID_STUDENT, ID_PRZEDMIOT, ID_EGZAMINATOR, ID_OSRODEK, ZDAL)
values ((select max(e.ID_EGZAMIN) + 1 from EGZAMINY e), '0000018', '15', '0005', 8, null);

-- po triggerze
select * from EGZAMINY e order by e.ID_EGZAMIN desc;