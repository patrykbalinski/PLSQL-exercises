-- 277.
-- Utworzyć pakiet o nazwie Pcg_Conversion. Pakiet powinien zawierać funkcje, które będą
-- realizować konwersję danych znakowych do postaci dużych znaków. Konwersja będzie
-- dotyczyć następujących danych: Studenci (Nazwisko, Imie, Miejsce, Miasto, Ulica),
-- Egzaminatorzy (Nazwisko, Imie, Miasto, Ulica, E_mail), Osrodki (Nazwa_Osrodek, Miasto,
-- Ulica), Przedmioty (Nazwa_Przedmiot).

create or replace package Pcg_Conversion as
    procedure student_uppercase(nazwisko in out varchar2, imie in out varchar2, miejsce in out varchar2, miasto in out varchar2, ulica in out varchar2);
    procedure egzaminatorzy_uppercase(nazwisko in out varchar2, imie in out varchar2, miasto in out varchar2, ulica in out varchar2, e_mail in out varchar2);
    procedure osrodki_uppercase(nazwa_osrodek in out varchar2, miasto in out varchar2, ulica in out varchar2);
    procedure przedmioty_uppercase(nazwa_przedmiot in out varchar2);
end Pcg_Conversion;

create or replace package body Pcg_Conversion as

    procedure student_uppercase(nazwisko in out varchar2, imie in out varchar2, miejsce in out varchar2, miasto in out varchar2, ulica in out varchar2) is
    begin
         nazwisko := upper(nazwisko);
         imie := upper(imie);
         miejsce := upper(miejsce);
         miasto := upper(miasto);
         ulica := upper(ulica);
    end;

    procedure egzaminatorzy_uppercase(nazwisko in out varchar2, imie in out varchar2, miasto in out varchar2, ulica in out varchar2, e_mail in out varchar2) is
    begin
        nazwisko := upper(nazwisko);
        imie := upper(imie);
        miasto := upper(miasto);
        ulica := upper(ulica);
        e_mail := upper(e_mail);
    end;

    procedure osrodki_uppercase(nazwa_osrodek in out varchar2, miasto in out varchar2, ulica in out varchar2) is
    begin
        nazwa_osrodek := upper(nazwa_osrodek);
        miasto := upper(miasto);
        ulica := upper(ulica);
    end;

    procedure przedmioty_uppercase(nazwa_przedmiot in out varchar2) is
    begin
        nazwa_przedmiot := upper(nazwa_przedmiot);
    end;

end Pcg_Conversion;

declare
    v_nazwa_przedmiot varchar2(100) := 'matematyka';
begin
    dbms_output.put_line('before conversion: ' || v_nazwa_przedmiot);
    Pcg_Conversion.przedmioty_uppercase(v_nazwa_przedmiot);
    dbms_output.put_line('after conversion: ' || v_nazwa_przedmiot);
end;