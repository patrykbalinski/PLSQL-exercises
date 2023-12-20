-- 263.
-- W bloku PL/SQL utworzyć procedurę o nazwie PMOsrodek. Procedura ma za zadanie
-- modyfikować dane dotyczące nazwy ośrodka oraz miasta, w którym on się znajduje.
-- Identyfikator ośrodka należy przekazać jako parametr procedury. Jeśli ośrodek o podanym
-- identyfikatorze nie istnieje, należy wyświetlić odpowiedni komunikat.

declare
    v_osrodek OSRODKI%rowtype;

    procedure PMOsrodek(in_id_osrodek OSRODKI.ID_OSRODEK%TYPE, in_osrodek_nazwa OSRODKI.NAZWA_OSRODEK%TYPE, in_miasto OSRODKI.MIASTO%TYPE) is
    begin
        update OSRODKI o set o.NAZWA_OSRODEK = in_osrodek_nazwa, o.MIASTO = in_miasto where o.ID_OSRODEK = in_id_osrodek;
    end;
begin
    dbms_output.put_line('before:');
    select * into v_osrodek from OSRODKI o where o.ID_OSRODEK = 1;
    dbms_output.put_line(v_osrodek.ID_OSRODEK || ', ' || v_osrodek.NAZWA_OSRODEK || ', ' || v_osrodek.MIASTO);

    PMOsrodek(1, 'CKMP_UPDATED', 'Lublin_UPDATED');

    dbms_output.put_line('after:');
    select * into v_osrodek from OSRODKI o where o.ID_OSRODEK = 1;
    dbms_output.put_line(v_osrodek.ID_OSRODEK || ', ' || v_osrodek.NAZWA_OSRODEK || ', ' || v_osrodek.MIASTO);

    rollback;
end;