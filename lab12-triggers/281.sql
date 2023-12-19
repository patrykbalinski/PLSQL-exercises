-- 281.
-- Zdefiniować we własnym schemacie wyzwalacz, który będzie monitorował proces
-- tworzenia nowych obiektów w tym schemacie. W tym celu należy utworzyć tabelę
-- Monitor_Create, która zawiera pola: Object_Type (rodzaj tworzonego obiektu) typu
-- VARCHAR2(20), Object_Name (nazwa tworzonego obiektu) typu VARCHAR2(30),
-- Create_Date (data utworzenia obiektu) typu DATE, Object_Creator (użytkownik, który
-- utworzył obiekt) typu VARCHAR2(30).

create table Monitor_User (
    User_Name VARCHAR2(30),
    Login_Date DATE,
    Login_IP VARCHAR2(30)
)

create or replace trigger BL_update_Monitor_User after logon on SCHEMA
begin
    insert into Monitor_User values (USER, SYSDATE, '');
end;

CONN SYS;

CREATE USER rafal IDENTIFIED BY rafal;

select * from MONITOR_USER;

SELECT * FROM all_users;