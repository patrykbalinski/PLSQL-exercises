-- 199.
-- Dla tabeli Egzaminy zdefiniować wyzwalacz, który będzie wstawiał wartość w polu
-- Punkty w momencie wstawienia nowego rekordu lub aktualizacji rekordu istniejącego.
-- Kolumna będzie przechowywać informację o liczbie punktów zdobytych na egzaminie
-- przez studenta. Każdemu studentowi, który zdał egzamin, należy przyznać liczbę punktów
-- z przedziału 3 do 5 (z dokładnością do dwóch miejsc po przecinku), a studentowi, który
-- nie zdał egzaminu – liczbę punktów z przedziału 2 do 2.99 (również z dokładnością do
-- dwóch miejsc po przecinku).

insert into studenci values ('007007', 'Bond', 'James', null, null, null);

select * from STUDENCI s order by s.ID_STUDENT desc;

begin
	dbms_output.put_line(round(dbms_random.value(2,3),2)) ; --[2,3)
end ;

create or replace trigger BI_BU_EGZAMINY_RANDOM_POINTS
	before insert or update
	on EGZAMINY
	for each row
begin
	if :NEW.ZDAL = 'N' then
		:NEW.PUNKTY := round(dbms_random.value(2, 3), 2); --[2,3)
	elsif :NEW.ZDAL = 'T' then
		:NEW.PUNKTY := round(dbms_random.value(3, 5.001), 2); --[3,5]
	end if;
end;

insert into egzaminy (id_egzamin, id_student, id_przedmiot, id_osrodek, id_egzaminator, data_egzamin, zdal)
	values (4444, '007007', 1, 1, '0004', to_date('17-11-2023', 'dd-mm-yyyy'), 'N') ;

update EGZAMINY e set e.ZDAL = 'T' where e.ID_EGZAMIN = 4444;

select * from EGZAMINY e order by e.ID_EGZAMIN desc;