-- 245.
-- Utworzyć tabelę bazy danych o nazwie Przedmioty_Protokol. Tabela powinna zawierać
-- dwie kolumny. Pierwsza z nich to nazwa przedmiotu. Druga to tabela zagnieżdżona, będąca
-- listą studentów, którzy zdali dany przedmiot. Lista studentów zawiera trzy kolumny:
-- identyfikator studenta, jego nazwisko i imię. Dane w tabeli Przedmioty_Protokol należy
-- posortować według nazwy przedmiotu. Lista studentów dla danego przedmiotu powinna
-- być posortowana według nazwiska studenta. Wprowadzić odpowiednie dane do tabeli
-- Przedmioty_Protokol, wykorzystując zawartość tabel Przedmioty, Egzaminy i Studenci. Po
-- wprowadzeniu danych do tej tabeli, proszę wyświetlić jej zawartość.

drop type studenci_protokol force;
drop type studenci_protokol_tab force;
drop table Przedmioty_Protokol;

create or replace type studenci_protokol is object
(
    ID_STUDENT VARCHAR2(7),
    NAZWISKO   VARCHAR2(25),
    IMIE       VARCHAR2(15)
);

create or replace type studenci_protokol_tab is table of studenci_protokol;

CREATE TABLE Przedmioty_Protokol
(
    NAZWA_PRZEDMIOT VARCHAR2(100),
    STUDENCI        studenci_protokol_tab,
    CONSTRAINT PRZEDMIOTY_PROTOKOL_PK PRIMARY KEY (NAZWA_PRZEDMIOT)
) nested table STUDENCI store as Przedmioty_Protokol_nt;

select * from Przedmioty_Protokol;

begin
    for vc_przedmiot in (select p.ID_PRZEDMIOT, p.NAZWA_PRZEDMIOT from PRZEDMIOTY p order by p.NAZWA_PRZEDMIOT) loop

        insert into PRZEDMIOTY_PROTOKOL values (vc_przedmiot.NAZWA_PRZEDMIOT, studenci_protokol_tab());

        for vc_student in (select distinct s.ID_STUDENT, s.IMIE, s.NAZWISKO
                           from STUDENCI s
                               inner join EGZAMINY e on e.ID_STUDENT = s.ID_STUDENT
                           where e.ID_PRZEDMIOT = vc_przedmiot.ID_PRZEDMIOT and e.ZDAL = 'T'
                           order by s.NAZWISKO) loop

            insert into the ( select p.STUDENCI from Przedmioty_Protokol p where p.NAZWA_PRZEDMIOT = vc_przedmiot.NAZWA_PRZEDMIOT ) values (vc_student.ID_STUDENT, vc_student.NAZWISKO, vc_student.IMIE);

        end loop;
    end loop;
end;

select * from Przedmioty_Protokol;

select p.NAZWA_PRZEDMIOT, s.ID_STUDENT, s.NAZWISKO, s.IMIE
from Przedmioty_Protokol p
         cross join table (p.STUDENCI) s;