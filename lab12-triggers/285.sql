-- 285.
-- Dla tabeli Egzaminy zdefiniować odpowiednie triggery, które będą kontrolować
-- integralność referencyjną podczas wstawiania i modyfikacji danych o egzaminie.
-- Integralność referencyjna ma dotyczyć danych o studencie, który zdawał egzamin oraz
-- przedmiotu, z którego przeprowadzono egzamin.

create or replace trigger BI_Egzaminy before insert on EGZAMINY for each row
begin
    if :new.Data_Egzamin is null then
        :new.Data_Egzamin := sysdate;
    end if;
end;