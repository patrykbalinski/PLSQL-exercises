/* 235
Utworzyć tabelę bazy danych o nazwie Analityka. Tabela powinna zawierać informacje o
liczbie egzaminów poszczególnych egzaminatorów w poszczególnych ośrodkach. W tabeli
utworzyć kolumny opisujące ośrodek (identyfikator oraz nazwa), egzaminatora
(identyfikator, imię i Nazwisko) oraz liczbę egzaminów egzaminatora w danym ośrodku.
Dane dotyczące egzaminatora i liczby jego egzaminów należy umieścić w kolumnie,
będącej tabelą zagnieżdżoną. Wprowadzić dane do tabeli Analityka na podstawie danych
zgromadzonych w tabelach Egzaminy, Osrodki i Egzaminatorzy.
*/

drop type analityka_egzaminator force;
drop type analityka_egzaminatorzy force;
drop table Analityka;

create or replace type analityka_egzaminator is object
(
    id_egzaminator VARCHAR2(4),
    nazwisko       VARCHAR2(25),
    imie           VARCHAR2(15),
    liczba_egzaminow NUMBER
);

create or replace type analityka_egzaminatorzy is table of analityka_egzaminator;

CREATE TABLE Analityka
(
    id_osrodek    NUMBER(5),
    nazwa_osrodek VARCHAR2(50),
    egzaminatorzy   analityka_egzaminatorzy,
    CONSTRAINT Analityka_pk PRIMARY KEY (id_osrodek)
) nested table egzaminatorzy store as analityka_egzaminatorzy_nt;

select * from Analityka;

-- uzupelnienie danych
begin
    for osrodek in (select * from OSRODKI o) loop

        insert into Analityka values (osrodek.ID_OSRODEK, osrodek.NAZWA_OSRODEK, analityka_egzaminatorzy());

        for egzaminy_egzaminatora in (select e.ID_EGZAMINATOR, e.NAZWISKO, e.IMIE, count(eg.ID_EGZAMIN) liczba_egzaminow from EGZAMINATORZY e
                                        inner join EGZAMINY eg on eg.ID_EGZAMINATOR = e.ID_EGZAMINATOR
                                        where eg.ID_OSRODEK = osrodek.ID_OSRODEK
                                        group by e.ID_EGZAMINATOR, e.NAZWISKO, e.IMIE) loop

            insert into the (select a.EGZAMINATORZY from Analityka a where a.ID_OSRODEK = osrodek.ID_OSRODEK)
                values (analityka_egzaminator(egzaminy_egzaminatora.ID_EGZAMINATOR,
                        egzaminy_egzaminatora.NAZWISKO,
                        egzaminy_egzaminatora.IMIE,
                        egzaminy_egzaminatora.liczba_egzaminow));

        end loop;
    end loop;
end;

select * from Analityka;

select a.ID_OSRODEK, a.NAZWA_OSRODEK, e.id_egzaminator, e.nazwisko, e.imie, e.liczba_egzaminow
from ANALITYKA a
         cross join TABLE (a.EGZAMINATORZY) e
order by 1, 2, 3;

select a.id_osrodek, a.nazwa_osrodek, nt.id_egzaminator, nt.nazwisko, nt.imie, nt.liczba_egzaminow
from analityka a, table(a.egzaminatorzy) nt;