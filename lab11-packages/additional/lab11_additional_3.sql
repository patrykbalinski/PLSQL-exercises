/*
Utworzyć procedurę składowaną, która dokona weryfikacji poprawności wartości pola
Nr_ECDL w tabeli Studenci. Weryfikacja tej wartości jest dwuetapowa. Pierwszy etap to
sprawdzenie, czy wartość ta może wystąpić. Warunkiem istnienia tej wartości jest zdanie
przez studenta egzaminów ze wszystkich przedmiotów, które znajdują się w tabeli
Przedmioty. Drugi etap polega na sprawdzeniu, czy wartość występująca w tym polu w
danym wierszu jest równa identyfikatorowi studenta, którego ten wiersz dotyczy.
*/

CREATE OR REPLACE PROCEDURE check_Nr_ECDL_validity(in_studentId STUDENCI.ID_STUDENT%type,in_Nr_ECDL varchar2) IS
    v_exams_valid BOOLEAN;
BEGIN
    BEGIN
        select distinct DECODE(e.ZDAL, 'T', true, false) into v_exams_valid from EGZAMINY e where e.ID_STUDENT = in_studentId;
    exception when others then
        v_exams_valid := false;
    END;


    DBMS_OUTPUT.PUT_LINE('in_Nr_ECDL invalid, student has failed exams!');
    DBMS_OUTPUT.PUT_LINE('in_Nr_ECDL invalid, value NR_ECDL is not equal value ID_STUDENT!');
    DBMS_OUTPUT.PUT_LINE('in_Nr_ECDL valid!');
END;

select * from studenci;