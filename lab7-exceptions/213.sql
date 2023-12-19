-- 213.
-- Przeprowadzić kontrolę, czy w ośrodku (ośrodkach) o nazwie LBS przeprowadzono
-- egzaminy. Dla każdego ośrodka o podanej nazwie, w którym odbył się egzamin, wyświetlić
-- odpowiedni komunikat podający liczbę egzaminów. Jeśli nie ma ośrodka o podanej nazwie,
-- wyświetlić komunikat o treści "Ośrodek o podanej nazwie nie istnieje". Jeśli w ośrodku nie
-- było egzaminu, należy wyświetlić komunikat "Ośrodek nie uczestniczył w egzaminach". Do
-- rozwiązania zadania wykorzystać wyjątki systemowe i/lub wyjątki użytkownika.

-- USUNIECIE EGZAMINOW Z OSRODKA LBS
-- delete from EGZAMINY e where e.ID_OSRODEK = (select o.ID_OSRODEK from OSRODKI o where o.NAZWA_OSRODEK = 'LBS');

declare
    v_liczba_osrodkow number;
    v_liczba_egzaminow number;
    c_nazwa_osrodka OSRODKI.NAZWA_OSRODEK%TYPE := 'LBS';
begin
    select count(*)
    into v_liczba_osrodkow
    from OSRODKI o
    where upper(o.NAZWA_OSRODEK) = upper(c_nazwa_osrodka);

    if v_liczba_osrodkow = 0 then
        raise_application_error(-20000, 'Ośrodek o podanej nazwie ' || '(' || c_nazwa_osrodka || ')' || ' nie istnieje');
    end if;

    for vc_osrodek in (select o.ID_OSRODEK from OSRODKI o where upper(o.NAZWA_OSRODEK) = upper(c_nazwa_osrodka)) loop

        select count(*)
        into v_liczba_egzaminow
        from EGZAMINY e
        where e.ID_OSRODEK = vc_osrodek.ID_OSRODEK;

        if v_liczba_egzaminow = 0 then
            raise_application_error(-20000, 'Ośrodek ' || '(' || c_nazwa_osrodka || ')' || ' o ID: ' || vc_osrodek.ID_OSRODEK || ' nie uczestniczył w egzaminach');
        end if;

        dbms_output.put_line('ID_OSRODKA: ' || vc_osrodek.ID_OSRODEK || ' -> ' || 'LICZBA EGZAMINOW = ' || v_liczba_egzaminow);
    end loop;

exception
    when others then
        DBMS_OUTPUT.PUT_LINE (SQLERRM);
end;

-- PRZYWROCENIE ZMIAN
-- rollback;