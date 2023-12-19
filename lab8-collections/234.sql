/*
W tabeli Indeks dla studenta o identyfikatorze 0000060 zmodyfikować datę egzaminu z
przedmiotu Bazy danych tak, by była ona równa bieżącej dacie systemowej.
*/

update table (select i.ZDANE_EGZAMINY from INDEKS i where i.ID_STUDENT = '0000060') z
set z.data_zdania_egzaminu = sysdate
where upper(z.nazwa_przedmiot) = 'BAZY DANYCH';