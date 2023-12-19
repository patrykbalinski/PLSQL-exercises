-- 200.
-- Dla każdego roku wskazać tego studenta (lub studentów), którzy zdawali egzamin w
-- pierwszym dniu egzaminowania w danym roku oraz studenta (studentów), którzy zdawali
-- egzamin w ostatnim dniu egzaminowania w danym roku. W zbiorze wynikowym należy
-- umieścić dane o roku (4 cyfry), dacie egzaminu, identyfikatorze, nazwisku i imieniu
-- studenta oraz daną informującą czy jest to pierwszy czy ostatni dzień egzaminowania w
-- tym roku. Uporządkować dane wg roku oraz daty egzaminu.

begin
    for vc_rok in (select distinct extract(year from e.DATA_EGZAMIN) rok from EGZAMINY e order by 1)
        loop
            dbms_output.put_line('ROK: ' || vc_rok.rok);

            for vc_exam_date in (select min(e.DATA_EGZAMIN) first_exam_date, max(e.DATA_EGZAMIN) last_exam_date
                                 from EGZAMINY e
                                 where extract(year from e.DATA_EGZAMIN) = vc_rok.rok) loop
                    dbms_output.put_line('  PIERWSZA DATA: ' || vc_exam_date.first_exam_date);
                    for vc_studenci in (select distinct e.ID_STUDENT, s.NAZWISKO, s.IMIE, e.DATA_EGZAMIN
                                        from EGZAMINY e
                                                 inner join STUDENCI s on s.ID_STUDENT = e.ID_STUDENT
                                        where e.DATA_EGZAMIN in (vc_exam_date.first_exam_date)) loop
                            dbms_output.put_line('      STUDENT: ' ||
                                                 vc_studenci.ID_STUDENT || ' ' || vc_studenci.IMIE || ' ' ||
                                                 vc_studenci.NAZWISKO);
                    end loop;
                    dbms_output.put_line('  OSTATNIA DATA: ' || vc_exam_date.last_exam_date);
                    for vc_studenci in (select distinct e.ID_STUDENT, s.NAZWISKO, s.IMIE, e.DATA_EGZAMIN
                                        from EGZAMINY e
                                                 inner join STUDENCI s on s.ID_STUDENT = e.ID_STUDENT
                                        where e.DATA_EGZAMIN in (vc_exam_date.last_exam_date)) loop
                            dbms_output.put_line('      STUDENT: ' ||
                                                 vc_studenci.ID_STUDENT || ' ' || vc_studenci.IMIE || ' ' ||
                                                 vc_studenci.NAZWISKO);
                    end loop;
            end loop;
    end loop;
end;