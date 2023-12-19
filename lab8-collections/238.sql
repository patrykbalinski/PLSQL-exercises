/*
Wykorzystując tabelę Analityka_Studenci, utworzoną w poprzednim zadaniu, usunąć z niej
te elementy, dla których liczba egzaminów jest równa 0.
*/

select * from ANALITYKA_STUDENCI a;

begin
    for student in (select * from STUDENCI s) loop
        delete from the (select a.OSRODKI from ANALITYKA_STUDENCI a where a.ID_STUDENT = student.ID_STUDENT) o where o.liczba_egzaminow = 0;
    end loop;
end;

select * from ANALITYKA_STUDENCI a;