/*
Zmodyfikować kod źródłowy w poprzednim zadaniu tak, aby po zainicjowaniu tabeli
zagnieżdżonej usunąć z niej elementy, zawierające ośrodki, w których nie przeprowadzono
egzaminu. Dokonać sprawdzenia poprawności wykonania zadania, wyświetlając elementy
tabeli po wykonaniu operacji usunięcia. Zadanie rozwiązać z wykorzystaniem
podprogramów PL/SQL.
*/

-- dodanie pustych osrodkow
insert into OSRODKI values ((select max(o.ID_OSRODEK) + 1 from OSRODKI o), 'test1', 'test1');
insert into OSRODKI values ((select max(o.ID_OSRODEK) + 1 from OSRODKI o), 'test2', 'test2');

-- sprawdzenie
select distinct o.ID_OSRODEK, o.NAZWA_OSRODEK
from OSRODKI o
    left join EGZAMINY e on e.ID_OSRODEK = o.ID_OSRODEK
where e.ID_EGZAMIN is null;

declare
    TYPE Typ_Rec_Osr IS RECORD(
        Id OSRODKI.ID_Osrodek%TYPE,
        Nazwa OSRODKI.Nazwa_Osrodek%TYPE
    );
    TYPE NT_Osrodki is table of Typ_Rec_Osr;
    v_osrodki_tab NT_Osrodki := NT_Osrodki();
    v_i number := 1;

    function liczba_egzaminow_w_osrodku(in_id_osrodek OSRODKI.ID_Osrodek%TYPE) return number is
        v_res number;
    begin
        select count(*)
        into v_res
        from EGZAMINY e
        where e.ID_OSRODEK = in_id_osrodek;

        return v_res;
    end;

    procedure usun_osrodki_bez_egzaminow(out_osrodki_tab in out NT_Osrodki) is
    begin
        for i in 1 .. out_osrodki_tab.COUNT() loop
            if liczba_egzaminow_w_osrodku(out_osrodki_tab(i).Id) = 0 then
                out_osrodki_tab.DELETE(i);
            end if;
        end loop;
    end;
begin
    for osrodek in (select * from OSRODKI o) loop
        v_osrodki_tab.extend();
        v_osrodki_tab(v_i) := Typ_Rec_Osr(osrodek.ID_OSRODEK, osrodek.NAZWA_OSRODEK);
        v_i := v_i + 1;
    end loop;

    dbms_output.put_line('przed usunieciem osrodkow bez egzaminow:');

    for i in 1 .. v_osrodki_tab.COUNT() loop
        dbms_output.put_line(v_osrodki_tab(i).Id || ', ' || v_osrodki_tab(i).Nazwa);
    end loop;

    usun_osrodki_bez_egzaminow(v_osrodki_tab);

    dbms_output.put_line('po usunieciu osrodkow bez egzaminow:');

    for i in v_osrodki_tab.FIRST..v_osrodki_tab.LAST loop
        dbms_output.put_line(v_osrodki_tab(i).Id || ', ' || v_osrodki_tab(i).Nazwa);
    end loop;
end;

rollback;

-- dodanie pustych osrodkow
insert into OSRODKI values ((select max(o.ID_OSRODEK) + 1 from OSRODKI o), 'Arena Lublin', 'test1');
insert into OSRODKI values ((select max(o.ID_OSRODEK) + 1 from OSRODKI o), 'test2', 'test2');

-- sprawdzenie
select distinct o.ID_OSRODEK, o.NAZWA_OSRODEK
from OSRODKI o
    left join EGZAMINY e on e.ID_OSRODEK = o.ID_OSRODEK
where e.ID_EGZAMIN is null;

declare
    TYPE Typ_Rec_Osr IS RECORD(
        Id OSRODKI.ID_Osrodek%TYPE,
        Nazwa OSRODKI.Nazwa_Osrodek%TYPE
    );
    TYPE NT_Osrodki is table of Typ_Rec_Osr;
    v_osrodki_tab NT_Osrodki := NT_Osrodki();
    v_i number := 1;

    function ilosc_egzaminow_w_osrodku(in_id_osrodek OSRODKI.ID_Osrodek%TYPE) return number is
        v_res number;
    begin
        select count(*)
        into v_res
        from EGZAMINY e
        where e.ID_OSRODEK = in_id_osrodek;

        return v_res;
    end;

    procedure usun_osrodki_bez_egzaminow(out_osrodki_tab in out NT_Osrodki) is
    begin
        for i in 1 .. out_osrodki_tab.COUNT() loop
            if ilosc_egzaminow_w_osrodku(out_osrodki_tab(i).Id) = 0 then
                out_osrodki_tab.DELETE(i);
            end if;
        end loop;
    end;
begin
    for osrodek in (select * from OSRODKI o order by nazwa_osrodek) loop
        v_osrodki_tab.extend();
        v_osrodki_tab(v_i) := Typ_Rec_Osr(osrodek.ID_OSRODEK, osrodek.NAZWA_OSRODEK);
        v_i := v_i + 1;
    end loop;

    dbms_output.put_line('przed usunieciem osrodkow bez egzaminow:');

    for i in 1 .. v_osrodki_tab.COUNT() loop
        dbms_output.put_line(v_osrodki_tab(i).Id || ', ' || v_osrodki_tab(i).Nazwa);
    end loop;

    usun_osrodki_bez_egzaminow(v_osrodki_tab);

    dbms_output.put_line('po usunieciu osrodkow bez egzaminow:');

    for i in v_osrodki_tab.FIRST..v_osrodki_tab.LAST loop
        if v_osrodki_tab.EXISTS(i) then
            dbms_output.put_line(v_osrodki_tab(i).Id || ', ' || v_osrodki_tab(i).Nazwa);
        end if;
    end loop;
end;