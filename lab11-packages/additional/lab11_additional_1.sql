/*
Utworzyć procedurę składowaną, która dokona weryfikacji poprawności daty ECDL w
tabeli Studenci. Proces ten polegać będzie na sprawdzeniu, czy data ta jest większa od
bieżącej daty systemowej. Jeśli tak, wówczas należy zmodyfikować taką wartość,
wstawiając bieżącą datę systemową do tabeli Studenci.
*/

CREATE OR REPLACE PROCEDURE correctFutureDates IS
BEGIN
    update STUDENCI s SET s.DATA_ECDL = sysdate where s.DATA_ECDL > sysdate;
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' rows updated.');
    commit;
EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error while updating Student''s DATA_ECDL');
    rollback;
END;

begin
    correctFutureDates();
end;

select * from studenci;