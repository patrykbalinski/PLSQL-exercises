-- Zadanie dodatkowe nr 1:
-- Utworzyć w bazie danych tabelę o nazwie RaportEgz, która będzie zawierać dwie kolumny.
-- Pierwsza z nich będzie opisywać egzaminatora, druga rok - rok, miesiąc, liczbę egzaminów i liczbę studentów egzaminowanych przez egzaminatora.
-- Dane o egzaminatorze (Id, nazwisko, imie) należy umieścić w jednej kolumnie, pozostałe dane należy umieścić w postaci kolekcji,
-- której  elementy opisują rok, nazwę miesiąca, liczbę egzaminów i liczbę studentów w danym miesiącu. Posortować dane o miesiącach w obrębie roku
-- zgodnie z kolejnością ich występowania w roku.
-- Następnie proszę wyświetlić zawartośc tabeli RaportEgz.

create or replace type rok_egzaminowania is object
(
    rok VARCHAR2(4),
    nazwa_miesiaca VARCHAR2(25),
    liczba_egzaminow NUMBER,
    liczba_studentow NUMBER
);

create or replace type lata_egzaminowania_tab is table of rok_egzaminowania;

create or replace type egzaminator_type is object
(
    id_egzaminator VARCHAR2(4),
    nazwisko VARCHAR2(25),
    imie VARCHAR2(15)
);

create table RaportEgz (
    egzaminator egzaminator_type,
    lata_egzaminowania lata_egzaminowania_tab
) nested table lata_egzaminowania store as RaportEgz_lata_egzaminowania_nt;

select * from RaportEgz;

-- uzupelnienie danych
begin
    for vc_egzaminator in (select * from EGZAMINATORZY e) loop

        insert into RaportEgz values (egzaminator_type(vc_egzaminator.ID_EGZAMINATOR, vc_egzaminator.NAZWISKO, vc_egzaminator.IMIE), lata_egzaminowania_tab());

        for vc_lata_egzaminowania in (select extract(year from e.DATA_EGZAMIN) rok, to_char(e.DATA_EGZAMIN, 'Month') miesiac, count(e.ID_EGZAMIN) liczba_egzaminow, count(distinct e.ID_STUDENT) liczba_studentow
                                    from EGZAMINY e
                                    where e.ID_EGZAMINATOR = vc_egzaminator.ID_EGZAMINATOR
                                    group by extract(year from e.DATA_EGZAMIN), extract(month from e.DATA_EGZAMIN), to_char(e.DATA_EGZAMIN, 'Month')
                                    order by extract(year from e.DATA_EGZAMIN), extract(month from e.DATA_EGZAMIN)) loop

            insert into the (select r.lata_egzaminowania from RaportEgz r where r.egzaminator.ID_EGZAMINATOR = vc_egzaminator.ID_EGZAMINATOR)
                values (vc_lata_egzaminowania.rok, vc_lata_egzaminowania.miesiac, vc_lata_egzaminowania.liczba_egzaminow, vc_lata_egzaminowania.liczba_studentow);
        end loop;
    end loop;
end;

select * from RaportEgz;

select r.egzaminator.ID_EGZAMINATOR, r.egzaminator.IMIE, r.egzaminator.NAZWISKO, nt.rok, nt.nazwa_miesiaca, nt.liczba_egzaminow, nt.liczba_studentow
from RaportEgz r
         cross join TABLE (r.lata_egzaminowania) nt
order by 1, 4, 5