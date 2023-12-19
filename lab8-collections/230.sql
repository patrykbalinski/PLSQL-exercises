/* 230.
Utworzyć tabelę zagnieżdżoną o nazwie NT_Osrodki, której elementy będą rekordami.
Każdy rekord zawiera dwa pola: Id oraz Nazwa, odnoszące się odpowiednio do
identyfikatora i nazwy ośrodka. Następnie zainicjować tabelę, wprowadzając do jej
elementów kolejne ośrodki z tabeli Osrodki. Po zainicjowaniu wartości elementów należy
wyświetlić ich wartości. Dodatkowo określić i wyświetlić liczbę elementów powstałej
tabeli zagnieżdżonej.
*/

declare
    TYPE Typ_Rec_Osr IS RECORD(
        Id OSRODKI.ID_Osrodek%TYPE,
        Nazwa OSRODKI.Nazwa_Osrodek%TYPE
    );
    TYPE NT_Osrodki is table of Typ_Rec_Osr;
    v_osrodki_tab NT_Osrodki := NT_Osrodki();
    v_i number := 1;
begin
    for osrodek in (select * from OSRODKI o) loop
        v_osrodki_tab.extend();
        v_osrodki_tab(v_i) := Typ_Rec_Osr(osrodek.ID_OSRODEK, osrodek.NAZWA_OSRODEK);
        v_i := v_i + 1;
    end loop;

    for i in 1 .. v_osrodki_tab.COUNT() loop
        dbms_output.put_line(v_osrodki_tab(i).Id || ', ' || v_osrodki_tab(i).Nazwa);
    end loop;

    dbms_output.put_line('wielkosc tabeli = ' || v_osrodki_tab.count());
end;

declare
	TYPE tRec_Osrodki IS RECORD (Id 	osrodki.id_osrodek%type,
                              Nazwa	osrodki.nazwa_osrodek%type
  														) ;
	TYPE tCol_Osrodki IS TABLE OF tRec_Osrodki ;
  Col_Osrodki tCol_Osrodki := tCol_Osrodki();
  cursor c_Osrodki is select id_osrodek, nazwa_osrodek from osrodki order by 2 ;
  i number := 0 ;
begin
	for vc_Osrodki in c_Osrodki loop
  		Col_Osrodki.EXTEND ;
      i := i+1 ;
      Col_Osrodki(i).id := vc_Osrodki.id_osrodek ;
      Col_Osrodki(i).nazwa := vc_Osrodki.Nazwa_osrodek ;
  end loop ;
	for k in Col_Osrodki.FIRST..Col_Osrodki.LAST loop
  			dbms_output.put_line(Col_Osrodki(k).id || ' - ' || Col_Osrodki(k).nazwa) ;
  	end loop ;
	dbms_output.put_line('Collection contains ' || Col_Osrodki.COUNT || ' items') ;
end ;

declare
	TYPE tRec_Osrodki IS RECORD (Id 	osrodki.id_osrodek%type,
                              Nazwa	osrodki.nazwa_osrodek%type
  														) ;
	TYPE tCol_Osrodki IS TABLE OF tRec_Osrodki ;
  Col_Osrodki tCol_Osrodki := tCol_Osrodki();
  cursor c_Osrodki is select id_osrodek, nazwa_osrodek from osrodki order by 2 ;
  i number := 0 ;
begin
	for vc_Osrodki in (select * from OSRODKI o where 1=0) loop
  		Col_Osrodki.EXTEND ;
      i := i+1 ;
      Col_Osrodki(i).id := vc_Osrodki.id_osrodek ;
      Col_Osrodki(i).nazwa := vc_Osrodki.Nazwa_osrodek ;
  end loop ;
	for k in Col_Osrodki.FIRST..Col_Osrodki.LAST loop
  			dbms_output.put_line(Col_Osrodki(k).id || ' - ' || Col_Osrodki(k).nazwa) ;
  	end loop ;
	dbms_output.put_line('Collection contains ' || Col_Osrodki.COUNT || ' items') ;
end ;