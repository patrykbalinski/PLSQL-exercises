-- 220.
-- Przeprowadzić aktualizację zawartości tabeli Kopia_Przedmioty w oparciu o dane
-- znajdujące się w tabeli Wynik_Synchro. Wykonać kopiowanie przyrostowe tzn. nie usuwać
-- rekordów już istniejących, a dodać do tabeli Kopia_Przedmioty tylko te wiersze, które
-- występują w tabeli Przedmioty, a nie ma ich w tabeli Kopia_Przedmioty.

select * from KOPIA_PRZEDMIOTY;

begin
    for vc_synchro in (select * from WYNIK_SYNCHRO s where s.MIEJSCE = 'P') loop
        insert into KOPIA_PRZEDMIOTY values (vc_synchro.ID_PRZEDMIOT, vc_synchro.NAZWA_PRZEDMIOT, vc_synchro.OPIS_PRZEDMIOT);
    end loop;
end;

select * from KOPIA_PRZEDMIOTY;