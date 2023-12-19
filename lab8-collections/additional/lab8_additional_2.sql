create or replace type raport_studenci is object (
    ID_STUDENT VARCHAR2(7),
    IMIE       VARCHAR2(15),
    NAZWISKO   VARCHAR2(25)
);

create or replace type raport_studenci_tab is table of raport_studenci;

create or replace type raport_egzaminatorzy is object (
    ID_EGZAMINATOR VARCHAR2(4),
    IMIE VARCHAR2(15),
    NAZWISKO VARCHAR2(25),
    egzaminowani_studenci raport_studenci_tab
);

create or replace type raport_egzaminatorzy_tab is table of raport_egzaminatorzy;

create table Raport_Roczny (
    rok varchar2(4),
    miesiac varchar2(2),
    raport_egzaminatorzy raport_egzaminatorzy_tab
) nested table raport_egzaminatorzy store as Raport_Roczny_egzaminatorzy_nt(nested table egzaminowani_studenci store as raport_egzaminatorzy_egzaminowani_studenci_nt);

declare
    v_raport_egzaminatorzy_tab raport_egzaminatorzy_tab := raport_egzaminatorzy_tab();
    v_raport_studenci_tab raport_studenci_tab := raport_studenci_tab();
begin
    for vc_daty in (select distinct extract(year from e.DATA_EGZAMIN) as rok, extract(month from e.DATA_EGZAMIN) as miesiac from EGZAMINY e order by 1, 2) loop

        for vc_egzaminatorzy in (select distinct eg.ID_EGZAMINATOR, eg.IMIE, eg.NAZWISKO
                                 from EGZAMINY e
                                          inner join EGZAMINATORZY eg on eg.ID_EGZAMINATOR = e.ID_EGZAMINATOR
                                 where extract(year from e.DATA_EGZAMIN) = vc_daty.rok
                                   and extract(month from e.DATA_EGZAMIN) = vc_daty.miesiac) loop

            for vc_studenci in (select distinct s.ID_STUDENT, s.IMIE, s.NAZWISKO
                                from STUDENCI s
                                         inner join EGZAMINY e on s.ID_STUDENT = e.ID_STUDENT
                                where extract(year from e.DATA_EGZAMIN) = vc_daty.rok
                                  and extract(month from e.DATA_EGZAMIN) = vc_daty.miesiac
                                  and e.ID_EGZAMINATOR = vc_egzaminatorzy.ID_EGZAMINATOR) loop

                v_raport_studenci_tab.extend();
                v_raport_studenci_tab(v_raport_studenci_tab.COUNT) := raport_studenci(vc_studenci.ID_STUDENT, vc_studenci.IMIE, vc_studenci.NAZWISKO);
            end loop;
            v_raport_egzaminatorzy_tab.extend();
            v_raport_egzaminatorzy_tab(v_raport_egzaminatorzy_tab.COUNT) := raport_egzaminatorzy(vc_egzaminatorzy.ID_EGZAMINATOR, vc_egzaminatorzy.IMIE, vc_egzaminatorzy.NAZWISKO, v_raport_studenci_tab);
            v_raport_studenci_tab := raport_studenci_tab();
        end loop;

        insert into Raport_Roczny
        values (vc_daty.rok, vc_daty.miesiac, v_raport_egzaminatorzy_tab);

        v_raport_egzaminatorzy_tab := raport_egzaminatorzy_tab();

    end loop;
end;

begin
    for vc_daty in (select distinct extract(year from e.DATA_EGZAMIN) as rok, extract(month from e.DATA_EGZAMIN) as miesiac from EGZAMINY e order by 1, 2) loop

        insert into Raport_Roczny
            values (vc_daty.rok, vc_daty.miesiac, raport_egzaminatorzy_tab());

        for vc_egzaminatorzy in (select distinct eg.ID_EGZAMINATOR, eg.IMIE, eg.NAZWISKO
                                 from EGZAMINY e
                                          inner join EGZAMINATORZY eg on eg.ID_EGZAMINATOR = e.ID_EGZAMINATOR
                                 where extract(year from e.DATA_EGZAMIN) = vc_daty.rok
                                   and extract(month from e.DATA_EGZAMIN) = vc_daty.miesiac) loop

            insert into the (select r.raport_egzaminatorzy from Raport_Roczny r where r.rok = vc_daty.rok and r.miesiac = vc_daty.miesiac)
                values (vc_egzaminatorzy.ID_EGZAMINATOR, vc_egzaminatorzy.IMIE, vc_egzaminatorzy.NAZWISKO, raport_studenci_tab());

            for vc_studenci in (select distinct s.ID_STUDENT, s.IMIE, s.NAZWISKO
                                from STUDENCI s
                                         inner join EGZAMINY e on s.ID_STUDENT = e.ID_STUDENT
                                where extract(year from e.DATA_EGZAMIN) = vc_daty.rok
                                  and extract(month from e.DATA_EGZAMIN) = vc_daty.miesiac
                                  and e.ID_EGZAMINATOR = vc_egzaminatorzy.ID_EGZAMINATOR) loop

                insert into the (select re.egzaminowani_studenci from Raport_Roczny rr, table(rr.raport_egzaminatorzy) re where rr.rok = vc_daty.rok and rr.miesiac = vc_daty.miesiac and re.ID_EGZAMINATOR = vc_egzaminatorzy.ID_EGZAMINATOR)
                    values (vc_studenci.ID_STUDENT, vc_studenci.IMIE, vc_studenci.NAZWISKO);

            end loop;
        end loop;
    end loop;
end;

select * from Raport_Roczny;

select r.rok, cast(r.miesiac as number), re.ID_EGZAMINATOR, re.IMIE, re.NAZWISKO, es.ID_STUDENT, es.IMIE, es.NAZWISKO
from Raport_Roczny r, table(r.raport_egzaminatorzy) re, table(re.egzaminowani_studenci) es
order by 1, 2, 3, 4, 5, 6, 7, 8