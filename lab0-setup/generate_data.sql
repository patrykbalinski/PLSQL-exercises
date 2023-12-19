DECLARE
	TYPE tab_p IS TABLE OF Przedmioty%ROWTYPE INDEX BY BINARY_INTEGER;
	TabPrz tab_p;

	TYPE tab_o IS TABLE OF Osrodki%ROWTYPE INDEX BY BINARY_INTEGER;
	TabOs tab_o;

	TYPE tab_s IS TABLE OF Studenci%ROWTYPE INDEX BY BINARY_INTEGER;
	TabSt tab_s;

	TYPE tab_e IS TABLE OF Egzaminatorzy%ROWTYPE INDEX BY BINARY_INTEGER;
	TabWyk tab_e;

	TYPE tab_eg IS TABLE OF Egzaminy%ROWTYPE INDEX BY BINARY_INTEGER;
	TabEgz tab_eg;

	vsp VARCHAR2(1);
	CURSOR S_Przedmioty IS SELECT 'x' FROM Przedmioty;

	ind NUMBER(5):=0;
	x NUMBER;
	maxidegz NUMBER(1):=4;
	videgz Egzaminatorzy.id_egzaminator%TYPE;
	y Osrodki.id_osrodek%TYPE; -- numer ośrodka
	z NUMBER(5);   -- numer przedmiotu
	eg NUMBER(5);
	data_e DATE;


BEGIN
	TabPrz(1).Id_Przedmiot:=1;
	TabPrz(1).Nazwa_Przedmiot:='Wytwarzanie aplikacji sterowane modelami';
	TabPrz(2).Id_Przedmiot:=2;
	TabPrz(2).Nazwa_Przedmiot:='Modelowanie systemów dyskretnych';
	TabPrz(3).Id_Przedmiot:=3;
	TabPrz(3).Nazwa_Przedmiot:='Architektura zorientowana na serwisy';
	TabPrz(4).Id_Przedmiot:=4;
	TabPrz(4).Nazwa_Przedmiot:='Analiza matematyczna';
	TabPrz(5).Id_Przedmiot:=5;
	TabPrz(5).Nazwa_Przedmiot:='Zarządzanie projektem informatycznym';
	TabPrz(6).Id_Przedmiot:=6;
	TabPrz(6).Nazwa_Przedmiot:='Języki baz danych';
	TabPrz(7).Id_Przedmiot:=7;
	TabPrz(7).Nazwa_Przedmiot:='Wielowymiarowa analiza danych';
	TabPrz(8).Id_Przedmiot:=8;
	TabPrz(8).Nazwa_Przedmiot:='Bazy danych';
	TabPrz(9).Id_Przedmiot:=9;
	TabPrz(9).Nazwa_Przedmiot:='Hurtownie danych';
	TabPrz(10).Id_Przedmiot:=10;
	TabPrz(10).Nazwa_Przedmiot:='Business Intelligence';
	TabPrz(11).Id_Przedmiot:=11;
	TabPrz(11).Nazwa_Przedmiot:='Programowanie systemów baz danych';
	TabPrz(12).Id_Przedmiot:=12;
	TabPrz(12).Nazwa_Przedmiot:='Data Mining i analizy OLAP';
	TabPrz(13).Id_Przedmiot:=13;
	TabPrz(13).Nazwa_Przedmiot:='Inżynieria oprogramowania';
	TabPrz(14).Id_Przedmiot:=14;
	TabPrz(14).Nazwa_Przedmiot:='Multimedialne bazy danych';
	TabPrz(15).Id_Przedmiot:=15;
	TabPrz(15).Nazwa_Przedmiot:='Administrowanie bazami danych';

	OPEN S_Przedmioty;
	IF S_Przedmioty%ISOPEN THEN
		FETCH S_Przedmioty INTO vsp;
		IF S_Przedmioty%FOUND THEN
			DELETE FROM Egzaminy;
			commit;
			DELETE FROM Przedmioty;
			commit;
		END IF;
	END IF;
	CLOSE S_Przedmioty;

	FOR i IN 1..TabPrz.LAST LOOP
		INSERT INTO Przedmioty(id_przedmiot, Nazwa_Przedmiot) VALUES(TabPrz(i).Id_Przedmiot,
					TabPrz(i).Nazwa_Przedmiot);
	END LOOP;
	commit;

	TabOs(1).id_osrodek:=1;
	TabOs(1).Nazwa_Osrodek:='CKMP';
	TabOs(1).miasto:='Lublin';
	TabOs(2).id_osrodek:=2;
	TabOs(2).Nazwa_Osrodek:='LBS';
	TabOs(2).miasto:='Lublin';
	TabOs(3).id_osrodek:=3;
	TabOs(3).Nazwa_Osrodek:='Politechnika Lubelska';
	TabOs(3).miasto:='Lubartów';
	TabOs(4).id_osrodek:=4;
	TabOs(4).Nazwa_Osrodek:='UMCS';
	TabOs(4).miasto:='Lublin';
	TabOs(5).id_osrodek:=5;
	TabOs(5).Nazwa_Osrodek:='CKMP';
	TabOs(5).miasto:='Nibylandia';
	TabOs(6).id_osrodek:=6;
	TabOs(6).Nazwa_Osrodek:='Sonet';
	TabOs(6).miasto:='Hel';
	TabOs(7).id_osrodek:=7;
	TabOs(7).Nazwa_Osrodek:='WSIZ';
	TabOs(7).miasto:='Rzeszów';
	TabOs(8).id_osrodek:=8;
	TabOs(8).Nazwa_Osrodek:='WSPA';
	TabOs(8).miasto:='Lublin';
	TabOs(9).id_osrodek:=9;
	TabOs(9).Nazwa_Osrodek:='WSEI';
	TabOs(9).miasto:='Lublin';
	TabOs(10).id_osrodek:=10;
	TabOs(10).Nazwa_Osrodek:='WSEI';
	TabOs(10).miasto:='Rzeszów';
	TabOs(11).id_osrodek:=11 ;
	TabOs(11).Nazwa_Osrodek:='AGH';
	TabOs(11).miasto:='Kraków';
	TabOs(12).id_osrodek:=12;
	TabOs(12).Nazwa_Osrodek:='Comarch';
	TabOs(12).miasto:='Kraków';
	TabOs(13).id_osrodek:=13;
	TabOs(13).Nazwa_Osrodek:='SGH';
	TabOs(13).miasto:='Warszawa';
	TabOs(14).id_osrodek:=14;
	TabOs(14).Nazwa_Osrodek:='UW';
	TabOs(14).miasto:='Warszawa';
	TabOs(15).id_osrodek:=15;
	TabOs(15).Nazwa_Osrodek:='WSPA';
	TabOs(15).miasto:='Warszawa';
	TabOs(16).id_osrodek:=16;
	TabOs(16).Nazwa_Osrodek:='WSHE';
	TabOs(16).miasto:='Zamość';
	TabOs(17).id_osrodek:=17;
	TabOs(17).Nazwa_Osrodek:='WSHE';
	TabOs(17).miasto:='Chełm';
	TabOs(18).id_osrodek:=18;
	TabOs(18).Nazwa_Osrodek:='CKMP';
	TabOs(18).miasto:='Kraków';

	DELETE FROM Osrodki;
	commit;
	FOR i IN 1..TabOs.LAST LOOP
		INSERT INTO Osrodki(id_osrodek, Nazwa_Osrodek, miasto) VALUES(TabOs(i).Id_Osrodek,
					TabOs(i).Nazwa_Osrodek,TabOs(i).Miasto);
	END LOOP;
	commit;

	TabSt(1).id_student :='0000001';
	TabSt(1).nazwisko := 'Nowak';
	TabSt(1).imie := 'Piotr';
	TabSt(2).id_student :='0000002';
	TabSt(2).nazwisko := 'Kowalski';
	TabSt(2).imie := 'Jan';
	TabSt(3).id_student :='0000003';
	TabSt(3).nazwisko := 'Piechura';
	TabSt(3).imie := 'Grzegorz';
	TabSt(4).id_student :='0000004';
	TabSt(4).nazwisko := 'Mrozek';
	TabSt(4).imie := 'Eugeniusz';
	TabSt(5).id_student :='0000005';
	TabSt(5).nazwisko := 'Wilczek';
	TabSt(5).imie := 'Ania';
	TabSt(6).id_student :='0000006';
	TabSt(6).nazwisko := 'Górka';
	TabSt(6).imie := 'Janina';
	TabSt(7).id_student :='0000007';
	TabSt(7).nazwisko := 'Nowak';
	TabSt(7).imie := 'Andrzej';
	TabSt(8).id_student :='0000008';
	TabSt(8).nazwisko := 'Nowak';
	TabSt(8).imie := 'Jarosław';
	TabSt(9).id_student :='0000009';
	TabSt(9).nazwisko := 'Ziarno';
	TabSt(9).imie := 'Agnieszka';
	TabSt(10).id_student :='0000010';
	TabSt(10).nazwisko := 'Muryjas';
	TabSt(10).imie := 'Mateusz';
	TabSt(11).id_student :='0000011';
	TabSt(11).nazwisko := 'Barć';
	TabSt(11).imie := 'Michał';
	TabSt(12).id_student :='0000012';
	TabSt(12).nazwisko := 'Barć';
	TabSt(12).imie := 'Piotr';
	TabSt(13).id_student :='0000013';
	TabSt(13).nazwisko := 'Kowal';
	TabSt(13).imie := 'Jarosław';
	TabSt(14).id_student :='0000014';
	TabSt(14).nazwisko := 'Kowal';
	TabSt(14).imie := 'Zbigniew';
	TabSt(15).id_student :='0000015';
	TabSt(15).nazwisko := 'Kowal';
	TabSt(15).imie := 'Stefan';
	TabSt(16).id_student :='0000016';
	TabSt(16).nazwisko := 'Mączka';
	TabSt(16).imie := 'Jan';
	TabSt(17).id_student :='0000017';
	TabSt(17).nazwisko := 'Mędrzak';
	TabSt(17).imie := 'Tomasz';
	TabSt(18).id_student :='0000018';
	TabSt(18).nazwisko := 'Filipiak';
	TabSt(18).imie := 'Karol';

	DELETE FROM Studenci;
	commit;
	FOR i IN 1..TabSt.LAST LOOP
		INSERT INTO Studenci(id_student, nazwisko, imie) VALUES(TabSt(i).Id_Student,
					TabSt(i).Nazwisko,TabSt(i).Imie);
	END LOOP;
	commit;

	TabWyk(1).id_egzaminator := '0001';
	TabWyk(1).nazwisko := 'Pietrucha';
	TabWyk(1).imie := 'Jan';
	TabWyk(2).id_egzaminator := '0002';
	TabWyk(2).nazwisko := 'Mucha';
	TabWyk(2).imie := 'Janina';
	TabWyk(3).id_egzaminator := '0003';
	TabWyk(3).nazwisko := 'Muryjas';
	TabWyk(3).imie := 'Czesław';
	TabWyk(4).id_egzaminator := '0004';
	TabWyk(4).nazwisko := 'Opał';
	TabWyk(4).imie := 'Katarzyna';
 	TabWyk(5).id_egzaminator := '0005';
	TabWyk(5).nazwisko := 'Muryjas';
	TabWyk(5).imie := 'Piotr';
 	TabWyk(6).id_egzaminator := '0006';
	TabWyk(6).nazwisko := 'Grzywacz';
	TabWyk(6).imie := 'Zbylut';
 	TabWyk(7).id_egzaminator := '0007';
	TabWyk(7).nazwisko := 'Pendragon';
	TabWyk(7).imie := 'Artur';
	TabWyk(8).id_egzaminator := '0008';
	TabWyk(8).nazwisko := 'Watra';
	TabWyk(8).imie := 'Andrzej';
	TabWyk(9).id_egzaminator := '0009';
	TabWyk(9).nazwisko := 'Mucha';
	TabWyk(9).imie := 'Artur';
	TabWyk(10).id_egzaminator := '0010';
	TabWyk(10).nazwisko := 'Peszek';
	TabWyk(10).imie := 'Magdalena';

	DELETE FROM Egzaminatorzy;
	commit;
	FOR i IN 1..TabWyk.LAST LOOP
		INSERT INTO Egzaminatorzy(id_egzaminator, nazwisko, imie) VALUES(TabWyk(i).Id_Egzaminator,
					TabWyk(i).Nazwisko,TabWyk(i).Imie);
	END LOOP;
	commit;
	FOR i IN 1..TabSt.LAST LOOP
		data_e:=TO_DATE('2010/01/01', 'yyyy/mm/dd');
		data_e:=data_e+round(dbms_random.value(1,1000),0);
		z:=round(dbms_random.value(1,20),0);
		FOR j IN 1..TabPrz.LAST LOOP
			eg:=round(dbms_random.value(7,15),0);

			FOR k IN 1..eg LOOP
				ind:=ind+1;
				x:=round(dbms_random.value(1,10),0);
				videgz:=lpad(to_char(x),maxidegz,'0');
				y:=round(dbms_random.value(1,18),0);
				TabEgz(ind).ID_Egzamin:=ind;
				TabEgz(ind).id_student:=TabSt(i).id_student;
				TabEgz(ind).id_przedmiot:=TabPrz(j).id_przedmiot;
				TabEgz(ind).id_egzaminator:=videgz;
				data_e:=data_e+round(dbms_random.value(2,10),0);
				IF TO_CHAR(data_e,'D')='7' THEN
					data_e:=data_e+1;
				END IF;
				TabEgz(ind).Data_Egzamin:=data_e;
				TabEgz(ind).id_osrodek:=TabOs(y).id_osrodek;

				IF k<eg THEN
					TabEgz(ind).zdal:='N';
					TabEgz(ind).punkty := round(dbms_random.value(2,2.99),2) ;
				ELSE
					IF z=j THEN
						TabEgz(ind).zdal:='N';
						TabEgz(ind).punkty := round(dbms_random.value(2,2.99),2) ;
					ELSE
						TabEgz(ind).zdal:='T';
						TabEgz(ind).punkty := round(dbms_random.value(3,5),2) ;
					END IF;
				END IF;
			END LOOP;
		END LOOP;
	END LOOP;

	FOR i IN 1..TabEgz.LAST LOOP
		INSERT INTO Egzaminy(ID_Egzamin, id_student, id_przedmiot, id_egzaminator, id_osrodek, Data_Egzamin, zdal, punkty)
			VALUES(TabEgz(i).ID_Egzamin,
				TabEgz(i).id_student,
				TabEgz(i).id_przedmiot,
				TabEgz(i).id_egzaminator,
				TabEgz(i).id_osrodek,
				TabEgz(i).Data_Egzamin,
				TabEgz(i).zdal,
				TabEgz(i).punkty);

	END LOOP;
	Commit;
END ;