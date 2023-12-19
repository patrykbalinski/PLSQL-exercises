-- 212.
-- Określić liczbę egzaminów przeprowadzonych przez egzaminatora (egzaminatorów)
-- o nazwisku Muryjas. Uwzględnić każdego egzaminatora, również tych, którzy jeszcze nie
-- prowadzili egzaminów. Dla każdego egzaminatora o tym nazwisku podać jego
-- identyfikator oraz liczbę egzaminów. Uwzględnić przypadek, iż egzaminator o tym
-- nazwisku może nie istnieć w bazie danych. Wówczas wyświetlić komunikat "Egzaminator
-- o podanym nazwisku nie istnieje". Wykorzystać wyjątki do rozwiązania zadania

declare
    v_liczba_egzaminow number;
    v_liczba_egzaminatorow number;
begin
    select count(*)
    into v_liczba_egzaminatorow
    from EGZAMINATORZY e
    where upper(e.NAZWISKO) = 'MURYJAS';

    if v_liczba_egzaminatorow = 0 then
        raise_application_error(-20000, 'Egzaminator o podanym nazwisku nie istnieje');
    end if;

    for vc_egzaminator in (select e.ID_EGZAMINATOR, e.NAZWISKO, e.IMIE from EGZAMINATORZY e where upper(e.NAZWISKO) = 'MURYJAS') loop

        select count(*)
        into v_liczba_egzaminow
        from EGZAMINY e
        where e.ID_EGZAMINATOR = vc_egzaminator.ID_EGZAMINATOR;

        dbms_output.put_line(vc_egzaminator.ID_EGZAMINATOR || ' (' || vc_egzaminator.IMIE || ' ' || vc_egzaminator.NAZWISKO || ') -> ' || v_liczba_egzaminow);
    end loop;

exception
    when others then
        DBMS_OUTPUT.PUT_LINE (SQLERRM);
end;