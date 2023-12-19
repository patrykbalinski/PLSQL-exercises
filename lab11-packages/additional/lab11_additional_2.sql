/*
Utworzyć funkcję składowaną o nazwie Check_PESEL, która dokona sprawdzenia
poprawności wartości PESEL w tabeli Studenci. Proces ten powinien składać się z dwóch
etapów. Pierwszy to kontrola długości ciągu znaków. Drugi – poprawny rodzaj znaków tj.
tylko cyfry. Jeśli kontrolowana wartość nie spełnia powyższych warunków, funkcja
powinna zwrócić wartość FALSE.
*/

CREATE OR REPLACE FUNCTION Check_PESEL(in_pesel VARCHAR2) RETURN BOOLEAN IS
v_length_valid BOOLEAN;
v_type_valid BOOLEAN;
BEGIN
    v_length_valid := LENGTH(in_pesel) = 11;
    v_type_valid := REGEXP_LIKE(in_pesel, '^[[:digit:]]*$');
    return v_length_valid AND v_type_valid;
END;

begin
    if Check_PESEL('12341234123') then
        DBMS_OUTPUT.PUT_LINE('PESEL valid');
    else
        DBMS_OUTPUT.PUT_LINE('PESEL invalid');
    end if;
end;