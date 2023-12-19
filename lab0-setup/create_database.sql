CREATE TABLE egzaminatorzy
(Id_egzaminator		VARCHAR2(4),
 Nazwisko		VARCHAR2(25)
   CONSTRAINT egz_nazwisko_nn NOT NULL,
 Imie			VARCHAR2(15),
 Miasto			VARCHAR2(15),
      CONSTRAINT egzaminatorzy_pk PRIMARY KEY (Id_egzaminator)) ;

CREATE TABLE studenci
(Id_student		VARCHAR2(7),
 Nazwisko		VARCHAR2(25)
   CONSTRAINT stud_nazwisko_nn NOT NULL,
 Imie			VARCHAR2(15),
 E_mail			VARCHAR2(30),
 nr_ECDL		VARCHAR(7),
 data_ECDL		DATE,
   CONSTRAINT studenci_pk PRIMARY KEY (Id_student),
   CONSTRAINT stud_ECDL_uq UNIQUE (nr_ECDL)) ;

CREATE TABLE osrodki
(Id_osrodek		NUMBER(5),
 Nazwa_osrodek		VARCHAR2(50)
   CONSTRAINT osr_nazwa_nn NOT NULL,
 Miasto			VARCHAR2(50),
   CONSTRAINT osrodki_pk PRIMARY KEY (Id_osrodek)) ;

CREATE TABLE przedmioty
(Id_przedmiot		NUMBER(4),
 nazwa_przedmiot		VARCHAR2(100)
   CONSTRAINT prz_nazwa_p_nn NOT NULL,
 Opis_Przedmiot			VARCHAR2(200),
   CONSTRAINT przedmioty_pk PRIMARY KEY (Id_przedmiot));

CREATE TABLE egzaminy
(ID_Egzamin		NUMBER(12),
 Id_student		VARCHAR2(7)
   CONSTRAINT ex_stud_nn NOT NULL,
 Id_przedmiot		NUMBER(2)
   CONSTRAINT ex_prz_nn NOT NULL,
 Id_egzaminator			VARCHAR2(4)
   CONSTRAINT ex_egz_nn NOT NULL,
 Data_egzamin			DATE,
 Id_osrodek			NUMBER(5)
   CONSTRAINT ex_osr_nn NOT NULL,
 Zdal			VARCHAR2(1),
 Punkty		NUMBER(3,2),
   CONSTRAINT egzaminy_pk PRIMARY KEY (ID_Egzamin)) ;

ALTER TABLE egzaminy
   ADD CONSTRAINT ex_stud_fk
   FOREIGN KEY (Id_student) REFERENCES studenci (Id_student) ;

ALTER TABLE egzaminy
   ADD CONSTRAINT ex_przed_fk
   FOREIGN KEY (Id_przedmiot) REFERENCES przedmioty (Id_przedmiot) ;

ALTER TABLE egzaminy
   ADD CONSTRAINT ex_egzaminator_fk
   FOREIGN KEY (Id_egzaminator) REFERENCES egzaminatorzy (Id_egzaminator) ;

ALTER TABLE egzaminy
   ADD CONSTRAINT ex_osr_fk
   FOREIGN KEY (id_osrodek) REFERENCES osrodki (Id_osrodek) ;