-- 232. Utworzyć tabelę bazy danych o nazwie Indeks. Tabela powinna zawierać informacje o
-- studencie (identyfikator, Nazwisko, imię), przedmiotach (nazwa przedmiotu), z których
-- student zdał już swoje egzaminy oraz datę zdanego egzaminu. Lista przedmiotów wraz z
-- datami dla danego studenta powinna być kolumną typu tabela zagnieżdżona. Dane w tabeli
-- Indeks należy wygenerować na podstawie zawartości tabeli Egzaminy, Studenci oraz
-- Przedmioty.

select p.NAZWA_PRZEDMIOT from PRZEDMIOTY p;
select e.DATA_EGZAMIN from EGZAMINY e;
select s.ID_STUDENT, s.NAZWISKO, s.IMIE from STUDENCI s;

declare
    type przedmiot_rec is record(
        nazwa_przedmiotu PRZEDMIOTY.NAZWA_PRZEDMIOT%TYPE,
        data_zdania EGZAMINY.DATA_EGZAMIN%TYPE
    );
    TYPE przedmiot_tab is table of przedmiot_rec;

    TYPE Indeks_Rec IS RECORD(
        id STUDENCI.ID_STUDENT%TYPE,
        nazwisko STUDENCI.NAZWISKO%TYPE,
        imie STUDENCI.IMIE%TYPE,
        zdane_przedmioty przedmiot_tab
    );
    TYPE Indeks is table of Indeks_Rec;

    v_index Indeks := Indeks();
    v_zdane_przedmioty_studenta przedmiot_tab := przedmiot_tab();
    v_i number;

    function get_zdane_przedmioty_studenta(in_id_student STUDENCI.ID_STUDENT%TYPE) return przedmiot_tab is
        v_res przedmiot_tab := przedmiot_tab();
        v_i number;
    begin
        for zdane_przedmioty in (select distinct p.NAZWA_PRZEDMIOT, e.DATA_EGZAMIN
                                from EGZAMINY e
                                         inner join PRZEDMIOTY p on p.ID_PRZEDMIOT = e.ID_PRZEDMIOT
                                where e.ID_STUDENT = in_id_student
                                  and e.ZDAL = 'T') loop
            v_res.extend();
            v_i := v_res.COUNT();
            v_res(v_i) := przedmiot_rec(zdane_przedmioty.NAZWA_PRZEDMIOT, zdane_przedmioty.DATA_EGZAMIN);
        end loop;

        return v_res;
    end;
begin
    for student in (select * from STUDENCI s) loop
        v_index.extend();
        v_i := v_index.count();
        v_zdane_przedmioty_studenta := get_zdane_przedmioty_studenta(student.ID_STUDENT);
        v_index(v_i) := Indeks_Rec(student.ID_STUDENT, student.NAZWISKO, student.IMIE, v_zdane_przedmioty_studenta);
    end loop;

    for i in 1..v_index.count() loop
        dbms_output.put_line(v_index(i).id || ', ' || v_index(i).nazwisko || ', ' || v_index(i).imie);
        for j in 1..v_index(i).zdane_przedmioty.count() loop
            dbms_output.put_line('    ' || v_index(i).zdane_przedmioty(j).nazwa_przedmiotu || ' -> ' || v_index(i).zdane_przedmioty(j).data_zdania);
        end loop;
    end loop;
end;