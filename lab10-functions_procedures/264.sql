-- 264. Utworzyć procedurę, umożliwiającą wyświetlenie identyfikatora i nazwy ośrodka, w
-- których odbyły się już egzaminy. Następnie sprawdzić poprawność jej działania. Zadanie
-- należy zrealizować, wykorzystując kod PL/SQL.

declare
    procedure show_osrodki_with_exams is
    begin
        for vc_osrodek in (select distinct e.ID_OSRODEK, o.NAZWA_OSRODEK
                           from EGZAMINY e
                                    inner join OSRODKI o on e.ID_OSRODEK = o.ID_OSRODEK
                           order by 1)
            loop
                dbms_output.put_line(vc_osrodek.ID_OSRODEK || ', ' || vc_osrodek.NAZWA_OSRODEK);
            end loop;
    end;
begin
    show_osrodki_with_exams();
end;