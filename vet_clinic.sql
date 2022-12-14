PGDMP     #                    z         	   VetClinic    14.5    14.5 ?    v           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            w           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            x           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            y           1262    33760 	   VetClinic    DATABASE     h   CREATE DATABASE "VetClinic" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE "VetClinic";
                postgres    false            z           0    0    SCHEMA public    ACL     $   GRANT ALL ON SCHEMA public TO admi;
                   postgres    false    3            ?            1255    33761    check_role(character varying)    FUNCTION     ?   CREATE FUNCTION public.check_role(login character varying) RETURNS text
    LANGUAGE sql
    AS $$
  SELECT title FROM public."Employee" WHERE login_employee = login;
$$;
 :   DROP FUNCTION public.check_role(login character varying);
       public          postgres    false            {           0    0 ,   FUNCTION check_role(login character varying)    ACL     ?   GRANT ALL ON FUNCTION public.check_role(login character varying) TO doctor;
GRANT ALL ON FUNCTION public.check_role(login character varying) TO manager;
GRANT ALL ON FUNCTION public.check_role(login character varying) TO admi;
          public          postgres    false    245            ?            1255    33762    create_report_employee() 	   PROCEDURE       CREATE PROCEDURE public.create_report_employee()
    LANGUAGE sql
    AS $$
	COPY "Employee" (name_employee, phone_number_employee, email_employee, title, login_employee)
                TO 'D:\\Git\\DataBase\\saveEmployee.json'
                DELIMITER ',' CSV HEADER;
$$;
 0   DROP PROCEDURE public.create_report_employee();
       public          postgres    false            |           0    0 "   PROCEDURE create_report_employee()    ACL     ?   GRANT ALL ON PROCEDURE public.create_report_employee() TO manager;
GRANT ALL ON PROCEDURE public.create_report_employee() TO admi;
          public          postgres    false    246            ?            1255    33763    create_report_task() 	   PROCEDURE       CREATE PROCEDURE public.create_report_task()
    LANGUAGE sql
    AS $$
	COPY "Task"(name_task, description_task, date_create, date_deadline, priority, date_end, status)
                TO 'D:\\Git\\DataBase\\saveTask.json\'
                DELIMITER ',' CSV HEADER;
$$;
 ,   DROP PROCEDURE public.create_report_task();
       public          postgres    false            }           0    0    PROCEDURE create_report_task()    ACL     {   GRANT ALL ON PROCEDURE public.create_report_task() TO manager;
GRANT ALL ON PROCEDURE public.create_report_task() TO admi;
          public          postgres    false    247            ?            1255    33764 D   create_user(character varying, character varying, character varying) 	   PROCEDURE     ?  CREATE PROCEDURE public.create_user(IN login character varying, IN pass character varying, IN roleu character varying)
    LANGUAGE sql
    AS $$
    CREATE ROLE login WITH
                LOGIN
                NOSUPERUSER
                INHERIT
                NOCREATEDB
                NOCREATEROLE
                NOREPLICATION
                PASSWORD 'pass';
                GRANT roleU TO login
$$;
 v   DROP PROCEDURE public.create_user(IN login character varying, IN pass character varying, IN roleu character varying);
       public          postgres    false            ~           0    0 h   PROCEDURE create_user(IN login character varying, IN pass character varying, IN roleu character varying)    ACL     ?  GRANT ALL ON PROCEDURE public.create_user(IN login character varying, IN pass character varying, IN roleu character varying) TO doctor;
GRANT ALL ON PROCEDURE public.create_user(IN login character varying, IN pass character varying, IN roleu character varying) TO manager;
GRANT ALL ON PROCEDURE public.create_user(IN login character varying, IN pass character varying, IN roleu character varying) TO admi;
          public          postgres    false    248            ?            1255    33765    delete_client(integer) 	   PROCEDURE     ?   CREATE PROCEDURE public.delete_client(IN idclient integer)
    LANGUAGE sql
    AS $$
	DELETE FROM public."Client" WHERE id_client = idClient
$$;
 :   DROP PROCEDURE public.delete_client(IN idclient integer);
       public          postgres    false                       0    0 ,   PROCEDURE delete_client(IN idclient integer)    ACL     ?   GRANT ALL ON PROCEDURE public.delete_client(IN idclient integer) TO manager;
GRANT ALL ON PROCEDURE public.delete_client(IN idclient integer) TO admi;
          public          postgres    false    244            ?            1255    33766    delete_contract(integer) 	   PROCEDURE     ?   CREATE PROCEDURE public.delete_contract(IN idc integer)
    LANGUAGE sql
    AS $$
    DELETE FROM public."Contract" WHERE id_contract = idC
$$;
 7   DROP PROCEDURE public.delete_contract(IN idc integer);
       public          postgres    false            ?           0    0 )   PROCEDURE delete_contract(IN idc integer)    ACL     ?   GRANT ALL ON PROCEDURE public.delete_contract(IN idc integer) TO manager;
GRANT ALL ON PROCEDURE public.delete_contract(IN idc integer) TO admi;
          public          postgres    false    249            ?            1255    33767    delete_data()    FUNCTION     ?   CREATE FUNCTION public.delete_data() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM "Task" WHERE (CURRENT_DATE - date_end) >= 365;
    RETURN NULL;
END;
$$;
 $   DROP FUNCTION public.delete_data();
       public          postgres    false            ?           0    0    FUNCTION delete_data()    ACL     ?   GRANT ALL ON FUNCTION public.delete_data() TO manager;
GRANT ALL ON FUNCTION public.delete_data() TO tech_spec;
GRANT ALL ON FUNCTION public.delete_data() TO doctor;
GRANT ALL ON FUNCTION public.delete_data() TO admi;
          public          postgres    false    252            ?            1255    33768    delete_employee(integer) 	   PROCEDURE     ?   CREATE PROCEDURE public.delete_employee(IN id_e integer)
    LANGUAGE sql
    AS $$
	DELETE FROM public."Employee" WHERE id_employee = id_e
$$;
 8   DROP PROCEDURE public.delete_employee(IN id_e integer);
       public          postgres    false            ?           0    0 *   PROCEDURE delete_employee(IN id_e integer)    ACL     H   GRANT ALL ON PROCEDURE public.delete_employee(IN id_e integer) TO admi;
          public          postgres    false    253                       1255    33769 &   delete_employee_task(integer, integer) 	   PROCEDURE     ?   CREATE PROCEDURE public.delete_employee_task(IN id_emp integer, IN id_task integer)
    LANGUAGE sql
    AS $$
	DELETE FROM public."Employee_Task" WHERE "Employee_id_employee" = id_emp AND "Task_id_task" = id_task
$$;
 S   DROP PROCEDURE public.delete_employee_task(IN id_emp integer, IN id_task integer);
       public          postgres    false            ?           0    0 E   PROCEDURE delete_employee_task(IN id_emp integer, IN id_task integer)    ACL     ?   GRANT ALL ON PROCEDURE public.delete_employee_task(IN id_emp integer, IN id_task integer) TO manager;
GRANT ALL ON PROCEDURE public.delete_employee_task(IN id_emp integer, IN id_task integer) TO admi;
          public          postgres    false    258                       1255    33770    delete_equipment(integer) 	   PROCEDURE     ?   CREATE PROCEDURE public.delete_equipment(IN id_e integer)
    LANGUAGE sql
    AS $$
    DELETE FROM public."Equipment" WHERE id_equipment = id_e
$$;
 9   DROP PROCEDURE public.delete_equipment(IN id_e integer);
       public          postgres    false            ?           0    0 +   PROCEDURE delete_equipment(IN id_e integer)    ACL     ?   GRANT ALL ON PROCEDURE public.delete_equipment(IN id_e integer) TO doctor;
GRANT ALL ON PROCEDURE public.delete_equipment(IN id_e integer) TO admi;
GRANT ALL ON PROCEDURE public.delete_equipment(IN id_e integer) TO manager;
          public          postgres    false    259                       1255    33771 *   delete_equipmentfromtask(integer, integer) 	   PROCEDURE     ?   CREATE PROCEDURE public.delete_equipmentfromtask(IN idtask integer, IN idequipment integer)
    LANGUAGE sql
    AS $$
    DELETE FROM public."Task_Equipment" WHERE "Task_id_task" = idTask AND 
                "Equipment_id_equipment" = idEquipment
$$;
 [   DROP PROCEDURE public.delete_equipmentfromtask(IN idtask integer, IN idequipment integer);
       public          postgres    false            ?           0    0 M   PROCEDURE delete_equipmentfromtask(IN idtask integer, IN idequipment integer)    ACL     ?   GRANT ALL ON PROCEDURE public.delete_equipmentfromtask(IN idtask integer, IN idequipment integer) TO manager;
GRANT ALL ON PROCEDURE public.delete_equipmentfromtask(IN idtask integer, IN idequipment integer) TO admi;
          public          postgres    false    260                       1255    33772    delete_pet(integer) 	   PROCEDURE     ?   CREATE PROCEDURE public.delete_pet(IN idp integer)
    LANGUAGE sql
    AS $$
    DELETE FROM public."Pet" WHERE id_pet = idP
$$;
 2   DROP PROCEDURE public.delete_pet(IN idp integer);
       public          postgres    false            ?           0    0 $   PROCEDURE delete_pet(IN idp integer)    ACL     ?   GRANT ALL ON PROCEDURE public.delete_pet(IN idp integer) TO manager;
GRANT ALL ON PROCEDURE public.delete_pet(IN idp integer) TO admi;
          public          postgres    false    261                       1255    33773    delete_task(integer) 	   PROCEDURE     ?   CREATE PROCEDURE public.delete_task(IN idt integer)
    LANGUAGE sql
    AS $$
    DELETE FROM public."Task" WHERE id_task = idT
$$;
 3   DROP PROCEDURE public.delete_task(IN idt integer);
       public          postgres    false            ?           0    0 %   PROCEDURE delete_task(IN idt integer)    ACL     ?   GRANT ALL ON PROCEDURE public.delete_task(IN idt integer) TO manager;
GRANT ALL ON PROCEDURE public.delete_task(IN idt integer) TO admi;
          public          postgres    false    262                       1255    33774 Y   insert_client(character varying, character varying, character varying, character varying) 	   PROCEDURE     ]  CREATE PROCEDURE public.insert_client(IN nameclient character varying, IN phonenumber character varying, IN email character varying, IN address_c character varying)
    LANGUAGE sql
    AS $$
INSERT INTO public."Client" (name_client, phone_number_client, email_client, address)
                VALUES (nameClient, phoneNumber, email, address_c)
$$;
 ?   DROP PROCEDURE public.insert_client(IN nameclient character varying, IN phonenumber character varying, IN email character varying, IN address_c character varying);
       public          postgres    false            ?           0    0 ?   PROCEDURE insert_client(IN nameclient character varying, IN phonenumber character varying, IN email character varying, IN address_c character varying)    ACL     k  GRANT ALL ON PROCEDURE public.insert_client(IN nameclient character varying, IN phonenumber character varying, IN email character varying, IN address_c character varying) TO manager;
GRANT ALL ON PROCEDURE public.insert_client(IN nameclient character varying, IN phonenumber character varying, IN email character varying, IN address_c character varying) TO admi;
          public          postgres    false    263                       1255    33775 :   insert_contract(character varying, date, integer, integer) 	   PROCEDURE     7  CREATE PROCEDURE public.insert_contract(IN description character varying, IN datec date, IN idclient integer, IN idpet integer)
    LANGUAGE sql
    AS $$
    INSERT INTO public."Contract" (description_contract, date_contract, id_client, id_pet)
                VALUES (description, dateC, idClient, idPet)
$$;
    DROP PROCEDURE public.insert_contract(IN description character varying, IN datec date, IN idclient integer, IN idpet integer);
       public          postgres    false            ?           0    0 q   PROCEDURE insert_contract(IN description character varying, IN datec date, IN idclient integer, IN idpet integer)    ACL     !  GRANT ALL ON PROCEDURE public.insert_contract(IN description character varying, IN datec date, IN idclient integer, IN idpet integer) TO manager;
GRANT ALL ON PROCEDURE public.insert_contract(IN description character varying, IN datec date, IN idclient integer, IN idpet integer) TO admi;
          public          postgres    false    264                       1255    33913 n   insert_employee(character varying, character varying, character varying, character varying, character varying) 	   PROCEDURE     ?  CREATE PROCEDURE public.insert_employee(IN namee character varying, IN phone character varying, IN email character varying, IN title_e character varying, IN login_e character varying)
    LANGUAGE sql
    AS $$
    INSERT INTO public."Employee" (name_employee, phone_number_employee, email_employee,
                title, login_employee)
                VALUES (namee, phone, email, title_e, login_e)
$$;
 ?   DROP PROCEDURE public.insert_employee(IN namee character varying, IN phone character varying, IN email character varying, IN title_e character varying, IN login_e character varying);
       public          postgres    false            	           1255    33777 +   insert_employeetask(integer, integer, text) 	   PROCEDURE     ?   CREATE PROCEDURE public.insert_employeetask(IN ide integer, IN idt integer, IN pos text)
    LANGUAGE sql
    AS $$
    INSERT INTO public."Employee_Task" ("Employee_id_employee", "Task_id_task", position)
                VALUES (idE, idT, pos)
	
$$;
 X   DROP PROCEDURE public.insert_employeetask(IN ide integer, IN idt integer, IN pos text);
       public          postgres    false            ?           0    0 J   PROCEDURE insert_employeetask(IN ide integer, IN idt integer, IN pos text)    ACL     ?   GRANT ALL ON PROCEDURE public.insert_employeetask(IN ide integer, IN idt integer, IN pos text) TO manager;
GRANT ALL ON PROCEDURE public.insert_employeetask(IN ide integer, IN idt integer, IN pos text) TO admi;
          public          postgres    false    265            
           1255    33778 ?   insert_equipment(character varying, integer, character varying) 	   PROCEDURE       CREATE PROCEDURE public.insert_equipment(IN name_e character varying, IN vendor_c integer, IN type_e character varying)
    LANGUAGE sql
    AS $$
    INSERT INTO public."Equipment" (name_equipment, vendor_code, type_equipment)
                VALUES (name_e, vendor_c, type_e)
$$;
 w   DROP PROCEDURE public.insert_equipment(IN name_e character varying, IN vendor_c integer, IN type_e character varying);
       public          postgres    false            ?           0    0 i   PROCEDURE insert_equipment(IN name_e character varying, IN vendor_c integer, IN type_e character varying)    ACL     ?  GRANT ALL ON PROCEDURE public.insert_equipment(IN name_e character varying, IN vendor_c integer, IN type_e character varying) TO doctor;
GRANT ALL ON PROCEDURE public.insert_equipment(IN name_e character varying, IN vendor_c integer, IN type_e character varying) TO admi;
GRANT ALL ON PROCEDURE public.insert_equipment(IN name_e character varying, IN vendor_c integer, IN type_e character varying) TO manager;
          public          postgres    false    266                       1255    33779 N   insert_pet(character varying, character varying, character varying, character) 	   PROCEDURE       CREATE PROCEDURE public.insert_pet(IN namep character varying, IN kind character varying, IN age character varying, IN sex character)
    LANGUAGE sql
    AS $$
    INSERT INTO public."Pet" (animal_name, kind_of_animal, age, sex)
                VALUES (namep, kind, age, sex)
$$;
 ?   DROP PROCEDURE public.insert_pet(IN namep character varying, IN kind character varying, IN age character varying, IN sex character);
       public          postgres    false            ?           0    0 w   PROCEDURE insert_pet(IN namep character varying, IN kind character varying, IN age character varying, IN sex character)    ACL     -  GRANT ALL ON PROCEDURE public.insert_pet(IN namep character varying, IN kind character varying, IN age character varying, IN sex character) TO manager;
GRANT ALL ON PROCEDURE public.insert_pet(IN namep character varying, IN kind character varying, IN age character varying, IN sex character) TO admi;
          public          postgres    false    267                       1255    33780 ?   insert_task(character varying, character varying, date, date, character varying, boolean, integer, character varying, character varying, date) 	   PROCEDURE     s  CREATE PROCEDURE public.insert_task(IN namet character varying, IN description character varying, IN datecreate date, IN deadline date, IN priority character varying, IN status boolean, IN idcontract integer, IN employeename character varying, IN managername character varying, IN dateend date)
    LANGUAGE sql
    AS $$
    INSERT INTO public."Task" (name_task, description_task, date_create, date_deadline,
                priority, status, contract_id, emp_name, manager_name, date_end) 
                VALUES (nameT,description,dateCreate,deadline,priority,status,idContract,
						employeeName,managerName,dateEnd);
$$;
 &  DROP PROCEDURE public.insert_task(IN namet character varying, IN description character varying, IN datecreate date, IN deadline date, IN priority character varying, IN status boolean, IN idcontract integer, IN employeename character varying, IN managername character varying, IN dateend date);
       public          postgres    false            ?           0    0   PROCEDURE insert_task(IN namet character varying, IN description character varying, IN datecreate date, IN deadline date, IN priority character varying, IN status boolean, IN idcontract integer, IN employeename character varying, IN managername character varying, IN dateend date)    ACL     o  GRANT ALL ON PROCEDURE public.insert_task(IN namet character varying, IN description character varying, IN datecreate date, IN deadline date, IN priority character varying, IN status boolean, IN idcontract integer, IN employeename character varying, IN managername character varying, IN dateend date) TO manager;
GRANT ALL ON PROCEDURE public.insert_task(IN namet character varying, IN description character varying, IN datecreate date, IN deadline date, IN priority character varying, IN status boolean, IN idcontract integer, IN employeename character varying, IN managername character varying, IN dateend date) TO admi;
          public          postgres    false    268                       1255    33781 &   insert_taskequipment(integer, integer) 	   PROCEDURE     ?   CREATE PROCEDURE public.insert_taskequipment(IN idtask integer, IN idequipment integer)
    LANGUAGE sql
    AS $$
    INSERT INTO public."Task_Equipment" ("Task_id_task", "Equipment_id_equipment")
                VALUES (idTask, idEquipment)
$$;
 W   DROP PROCEDURE public.insert_taskequipment(IN idtask integer, IN idequipment integer);
       public          postgres    false            ?           0    0 I   PROCEDURE insert_taskequipment(IN idtask integer, IN idequipment integer)    ACL     :  GRANT ALL ON PROCEDURE public.insert_taskequipment(IN idtask integer, IN idequipment integer) TO doctor;
GRANT ALL ON PROCEDURE public.insert_taskequipment(IN idtask integer, IN idequipment integer) TO manager;
GRANT ALL ON PROCEDURE public.insert_taskequipment(IN idtask integer, IN idequipment integer) TO admi;
          public          postgres    false    269                       1255    33782    save_to_json() 	   PROCEDURE     ?   CREATE PROCEDURE public.save_to_json()
    LANGUAGE sql
    AS $$COPY ( SELECT array_to_json(array_agg(row_to_json(t)))
from "Task" 
t
) TO 'D:\GitHub\DataBase\save.json';$$;
 &   DROP PROCEDURE public.save_to_json();
       public          postgres    false            ?           0    0    PROCEDURE save_to_json()    ACL     ?   GRANT ALL ON PROCEDURE public.save_to_json() TO doctor;
GRANT ALL ON PROCEDURE public.save_to_json() TO admi;
GRANT ALL ON PROCEDURE public.save_to_json() TO manager;
          public          postgres    false    270                       1255    33783    search_clients(text)    FUNCTION     ?  CREATE FUNCTION public.search_clients(search_c text) RETURNS TABLE(id_client integer, name_client text, phone_number_client text, email_client text, address text)
    LANGUAGE sql
    AS $$
	SELECT id_client, name_client, phone_number_client, email_client, address FROM public."Client" WHERE name_client LIKE search_c
                OR address LIKE search_c 
                OR email_client LIKE search_c 
                OR phone_number_client LIKE search_c
$$;
 4   DROP FUNCTION public.search_clients(search_c text);
       public          postgres    false            ?           0    0 &   FUNCTION search_clients(search_c text)    ACL     ?   GRANT ALL ON FUNCTION public.search_clients(search_c text) TO manager;
GRANT ALL ON FUNCTION public.search_clients(search_c text) TO admi;
          public          postgres    false    271            ?            1255    33784    select_all_clients()    FUNCTION       CREATE FUNCTION public.select_all_clients() RETURNS TABLE(id_client integer, name_client text, phone_number_client text, email_client text, address text)
    LANGUAGE sql
    AS $$
	SELECT id_client, name_client, phone_number_client, email_client, address FROM public."Client"
$$;
 +   DROP FUNCTION public.select_all_clients();
       public          postgres    false            ?           0    0    FUNCTION select_all_clients()    ACL     y   GRANT ALL ON FUNCTION public.select_all_clients() TO admi;
GRANT ALL ON FUNCTION public.select_all_clients() TO manager;
          public          postgres    false    229                       1255    33785    select_all_contracts()    FUNCTION     %  CREATE FUNCTION public.select_all_contracts() RETURNS TABLE(id_contract integer, description_contract text, date_contract date, id_client integer, id_pet integer)
    LANGUAGE sql
    AS $$
	SELECT id_contract, description_contract, date_contract, id_client, id_pet FROM public."Contract"
$$;
 -   DROP FUNCTION public.select_all_contracts();
       public          postgres    false            ?           0    0    FUNCTION select_all_contracts()    ACL     }   GRANT ALL ON FUNCTION public.select_all_contracts() TO manager;
GRANT ALL ON FUNCTION public.select_all_contracts() TO admi;
          public          postgres    false    272                       1255    33786    select_all_employees()    FUNCTION     N  CREATE FUNCTION public.select_all_employees() RETURNS TABLE(id_employee integer, name_employee text, phone_number_employee text, email_employee text, title text, login_employee text)
    LANGUAGE sql
    AS $$
	SELECT id_employee, name_employee, phone_number_employee, email_employee, title, login_employee FROM public."Employee"
$$;
 -   DROP FUNCTION public.select_all_employees();
       public          postgres    false            ?           0    0    FUNCTION select_all_employees()    ACL     =   GRANT ALL ON FUNCTION public.select_all_employees() TO admi;
          public          postgres    false    273                       1255    33787    select_all_equipments()    FUNCTION       CREATE FUNCTION public.select_all_equipments() RETURNS TABLE(id_equipment integer, name_equipment text, vendor_code text, type_equipment text)
    LANGUAGE sql
    AS $$
	SELECT id_equipment, name_equipment, vendor_code, type_equipment FROM public."Equipment"
$$;
 .   DROP FUNCTION public.select_all_equipments();
       public          postgres    false            ?           0    0     FUNCTION select_all_equipments()    ACL     ?   GRANT ALL ON FUNCTION public.select_all_equipments() TO doctor;
GRANT ALL ON FUNCTION public.select_all_equipments() TO manager;
GRANT ALL ON FUNCTION public.select_all_equipments() TO admi;
          public          postgres    false    274                       1255    33788 (   select_all_equipments_from_task(integer)    FUNCTION     ?   CREATE FUNCTION public.select_all_equipments_from_task(id_t integer) RETURNS TABLE(equipment_id_equipment integer)
    LANGUAGE sql
    AS $$
	SELECT "Equipment_id_equipment" FROM public."Task_Equipment" WHERE "Task_id_task" = id_t
$$;
 D   DROP FUNCTION public.select_all_equipments_from_task(id_t integer);
       public          postgres    false            ?           0    0 6   FUNCTION select_all_equipments_from_task(id_t integer)    ACL       GRANT ALL ON FUNCTION public.select_all_equipments_from_task(id_t integer) TO doctor;
GRANT ALL ON FUNCTION public.select_all_equipments_from_task(id_t integer) TO manager;
GRANT ALL ON FUNCTION public.select_all_equipments_from_task(id_t integer) TO admi;
          public          postgres    false    275            ?            1255    33789    select_all_equipments_id()    FUNCTION     ?   CREATE FUNCTION public.select_all_equipments_id() RETURNS TABLE(id_equipment integer)
    LANGUAGE sql
    AS $$
	SELECT id_equipment FROM public."Equipment" 
$$;
 1   DROP FUNCTION public.select_all_equipments_id();
       public          postgres    false            ?           0    0 #   FUNCTION select_all_equipments_id()    ACL     ?   GRANT ALL ON FUNCTION public.select_all_equipments_id() TO doctor;
GRANT ALL ON FUNCTION public.select_all_equipments_id() TO manager;
GRANT ALL ON FUNCTION public.select_all_equipments_id() TO admi;
          public          postgres    false    239            ?            1255    33790    select_all_pets()    FUNCTION     ?   CREATE FUNCTION public.select_all_pets() RETURNS TABLE(id_pet integer, kind_of_animal text, sex character, age text, animal_name text)
    LANGUAGE sql
    AS $$
	SELECT id_pet, kind_of_animal, sex, age, animal_name FROM public."Pet"
$$;
 (   DROP FUNCTION public.select_all_pets();
       public          postgres    false            ?           0    0    FUNCTION select_all_pets()    ACL     s   GRANT ALL ON FUNCTION public.select_all_pets() TO manager;
GRANT ALL ON FUNCTION public.select_all_pets() TO admi;
          public          postgres    false    238                       1255    33791    select_all_tasks()    FUNCTION     ?  CREATE FUNCTION public.select_all_tasks() RETURNS TABLE(id_task integer, name_task text, description_task text, date_create date, date_deadline date, priority text, status boolean, date_end date, contract_id integer, emp_name text, manager_name text)
    LANGUAGE sql
    AS $$

	SELECT id_task, name_task, description_task, date_create, date_deadline, 
    priority, status, date_end, contract_id, emp_name, manager_name FROM public."Task"

$$;
 )   DROP FUNCTION public.select_all_tasks();
       public          postgres    false            ?           0    0    FUNCTION select_all_tasks()    ACL     ?   GRANT ALL ON FUNCTION public.select_all_tasks() TO doctor;
GRANT ALL ON FUNCTION public.select_all_tasks() TO manager;
GRANT ALL ON FUNCTION public.select_all_tasks() TO admi;
          public          postgres    false    276            ?            1255    33792 *   select_clients_name_from_contract(integer)    FUNCTION     ?   CREATE FUNCTION public.select_clients_name_from_contract(id_cl integer) RETURNS TABLE(name_client text)
    LANGUAGE sql
    AS $$
	SELECT name_client FROM public."Client" WHERE id_client = id_cl
$$;
 G   DROP FUNCTION public.select_clients_name_from_contract(id_cl integer);
       public          postgres    false            ?           0    0 9   FUNCTION select_clients_name_from_contract(id_cl integer)    ACL     ?   GRANT ALL ON FUNCTION public.select_clients_name_from_contract(id_cl integer) TO manager;
GRANT ALL ON FUNCTION public.select_clients_name_from_contract(id_cl integer) TO admi;
          public          postgres    false    240            ?            1255    33793     select_current_employee_id(text)    FUNCTION     ?   CREATE FUNCTION public.select_current_employee_id(login text) RETURNS integer
    LANGUAGE sql
    AS $$
	SELECT id_employee FROM public."Employee" WHERE login_employee = login
$$;
 =   DROP FUNCTION public.select_current_employee_id(login text);
       public          postgres    false            ?           0    0 /   FUNCTION select_current_employee_id(login text)    ACL     ?   GRANT ALL ON FUNCTION public.select_current_employee_id(login text) TO manager;
GRANT ALL ON FUNCTION public.select_current_employee_id(login text) TO admi;
          public          postgres    false    242            ?            1255    33794 W   select_current_task_id(text, text, date, date, character, boolean, integer, text, text)    FUNCTION     =  CREATE FUNCTION public.select_current_task_id(namet text, description text, datecreate date, deadline date, priorityt character, statust boolean, idcontract integer, employeename text, managername text) RETURNS integer
    LANGUAGE sql
    AS $$
	SELECT id_task FROM public."Task" WHERE name_task = nameT AND description_task = description
                AND date_create = dateCreate AND date_deadline = deadline AND priority = priorityT 
				AND status = statusT AND contract_id = idContract
                AND emp_name = employeeName AND manager_name = managerName
$$;
 ?   DROP FUNCTION public.select_current_task_id(namet text, description text, datecreate date, deadline date, priorityt character, statust boolean, idcontract integer, employeename text, managername text);
       public          postgres    false            ?           0    0 ?   FUNCTION select_current_task_id(namet text, description text, datecreate date, deadline date, priorityt character, statust boolean, idcontract integer, employeename text, managername text)    ACL     ?  GRANT ALL ON FUNCTION public.select_current_task_id(namet text, description text, datecreate date, deadline date, priorityt character, statust boolean, idcontract integer, employeename text, managername text) TO manager;
GRANT ALL ON FUNCTION public.select_current_task_id(namet text, description text, datecreate date, deadline date, priorityt character, statust boolean, idcontract integer, employeename text, managername text) TO admi;
          public          postgres    false    241            ?            1255    33795    select_emp_logins()    FUNCTION     ?   CREATE FUNCTION public.select_emp_logins() RETURNS TABLE(login text)
    LANGUAGE sql
    AS $$
	SELECT login_employee FROM public."Employee"
$$;
 *   DROP FUNCTION public.select_emp_logins();
       public          postgres    false            ?           0    0    FUNCTION select_emp_logins()    ACL     w   GRANT ALL ON FUNCTION public.select_emp_logins() TO manager;
GRANT ALL ON FUNCTION public.select_emp_logins() TO admi;
          public          postgres    false    243                       1255    33796    select_equipment(integer)    FUNCTION     )  CREATE FUNCTION public.select_equipment(id_e integer) RETURNS TABLE(id_equipment integer, name_equipment text, vendor_code text, type_equipment text)
    LANGUAGE sql
    AS $$
	SELECT id_equipment, name_equipment, vendor_code, type_equipment FROM public."Equipment" WHERE id_equipment = id_e
$$;
 5   DROP FUNCTION public.select_equipment(id_e integer);
       public          postgres    false            ?           0    0 '   FUNCTION select_equipment(id_e integer)    ACL     ?   GRANT ALL ON FUNCTION public.select_equipment(id_e integer) TO admi;
GRANT ALL ON FUNCTION public.select_equipment(id_e integer) TO doctor;
GRANT ALL ON FUNCTION public.select_equipment(id_e integer) TO manager;
          public          postgres    false    278                       1255    33797    select_id_clients()    FUNCTION     ?   CREATE FUNCTION public.select_id_clients() RETURNS TABLE(a integer)
    LANGUAGE sql
    AS $$
  SELECT id_client FROM public."Client";
$$;
 *   DROP FUNCTION public.select_id_clients();
       public          postgres    false            ?           0    0    FUNCTION select_id_clients()    ACL     w   GRANT ALL ON FUNCTION public.select_id_clients() TO manager;
GRANT ALL ON FUNCTION public.select_id_clients() TO admi;
          public          postgres    false    279                       1255    33798    select_id_contracts()    FUNCTION     ?   CREATE FUNCTION public.select_id_contracts() RETURNS TABLE(a integer)
    LANGUAGE sql
    AS $$
  SELECT id_contract FROM public."Contract"
$$;
 ,   DROP FUNCTION public.select_id_contracts();
       public          postgres    false            ?           0    0    FUNCTION select_id_contracts()    ACL     {   GRANT ALL ON FUNCTION public.select_id_contracts() TO manager;
GRANT ALL ON FUNCTION public.select_id_contracts() TO admi;
          public          postgres    false    280                       1255    33799    select_id_pets()    FUNCTION     ?   CREATE FUNCTION public.select_id_pets() RETURNS TABLE(a integer)
    LANGUAGE sql
    AS $$
  SELECT id_pet FROM public."Pet"
$$;
 '   DROP FUNCTION public.select_id_pets();
       public          postgres    false            ?           0    0    FUNCTION select_id_pets()    ACL     q   GRANT ALL ON FUNCTION public.select_id_pets() TO manager;
GRANT ALL ON FUNCTION public.select_id_pets() TO admi;
          public          postgres    false    277                       1255    33800 ,   select_kind_of_animal_from_contract(integer)    FUNCTION     ?   CREATE FUNCTION public.select_kind_of_animal_from_contract(id_p integer) RETURNS TABLE(animal_name text)
    LANGUAGE sql
    AS $$
	SELECT kind_of_animal FROM public."Pet" WHERE id_pet = id_p
$$;
 H   DROP FUNCTION public.select_kind_of_animal_from_contract(id_p integer);
       public          postgres    false            ?           0    0 :   FUNCTION select_kind_of_animal_from_contract(id_p integer)    ACL     ?   GRANT ALL ON FUNCTION public.select_kind_of_animal_from_contract(id_p integer) TO manager;
GRANT ALL ON FUNCTION public.select_kind_of_animal_from_contract(id_p integer) TO admi;
          public          postgres    false    281                       1255    33801 $   select_name_client_contract(integer)    FUNCTION     ?   CREATE FUNCTION public.select_name_client_contract(id_c integer) RETURNS TABLE(name_c text)
    LANGUAGE sql
    AS $$
	SELECT name_client FROM public."Client" WHERE id_client in (SELECT id_client FROM public."Contract" WHERE id_contract = id_c)
$$;
 @   DROP FUNCTION public.select_name_client_contract(id_c integer);
       public          postgres    false            ?           0    0 2   FUNCTION select_name_client_contract(id_c integer)    ACL     ?   GRANT ALL ON FUNCTION public.select_name_client_contract(id_c integer) TO manager;
GRANT ALL ON FUNCTION public.select_name_client_contract(id_c integer) TO admi;
          public          postgres    false    282                       1255    33802 !   select_name_pet_contract(integer)    FUNCTION     ?   CREATE FUNCTION public.select_name_pet_contract(id_c integer) RETURNS TABLE(name_c text)
    LANGUAGE sql
    AS $$
	SELECT animal_name FROM public."Pet" WHERE id_pet in (SELECT id_pet FROM public."Contract" WHERE id_contract = id_c)
$$;
 =   DROP FUNCTION public.select_name_pet_contract(id_c integer);
       public          postgres    false            ?           0    0 /   FUNCTION select_name_pet_contract(id_c integer)    ACL     ?   GRANT ALL ON FUNCTION public.select_name_pet_contract(id_c integer) TO manager;
GRANT ALL ON FUNCTION public.select_name_pet_contract(id_c integer) TO admi;
          public          postgres    false    283                       1255    33803 '   select_pets_name_from_contract(integer)    FUNCTION     ?   CREATE FUNCTION public.select_pets_name_from_contract(id_p integer) RETURNS TABLE(animal_name text)
    LANGUAGE sql
    AS $$
	SELECT animal_name FROM public."Pet" WHERE id_pet = id_p
$$;
 C   DROP FUNCTION public.select_pets_name_from_contract(id_p integer);
       public          postgres    false            ?           0    0 5   FUNCTION select_pets_name_from_contract(id_p integer)    ACL     ?   GRANT ALL ON FUNCTION public.select_pets_name_from_contract(id_p integer) TO manager;
GRANT ALL ON FUNCTION public.select_pets_name_from_contract(id_p integer) TO admi;
          public          postgres    false    284            ?            1255    33804 b   update_client(character varying, character varying, character varying, character varying, integer) 	   PROCEDURE     ?  CREATE PROCEDURE public.update_client(IN nameclient character varying, IN phonenumber character varying, IN email character varying, IN address character varying, IN idclient integer)
    LANGUAGE sql
    AS $$
UPDATE public."Client" SET name_client = nameClient, phone_number_client = phoneNumber,
                 email_client = email, address = address WHERE id_client = idClient
$$;
 ?   DROP PROCEDURE public.update_client(IN nameclient character varying, IN phonenumber character varying, IN email character varying, IN address character varying, IN idclient integer);
       public          postgres    false            ?           0    0 ?   PROCEDURE update_client(IN nameclient character varying, IN phonenumber character varying, IN email character varying, IN address character varying, IN idclient integer)    ACL     ?  GRANT ALL ON PROCEDURE public.update_client(IN nameclient character varying, IN phonenumber character varying, IN email character varying, IN address character varying, IN idclient integer) TO manager;
GRANT ALL ON PROCEDURE public.update_client(IN nameclient character varying, IN phonenumber character varying, IN email character varying, IN address character varying, IN idclient integer) TO admi;
          public          postgres    false    251            ?            1255    33805 =   update_contract(character varying, integer, integer, integer) 	   PROCEDURE       CREATE PROCEDURE public.update_contract(IN descript character varying, IN clientid integer, IN petid integer, IN idc integer)
    LANGUAGE sql
    AS $$
    UPDATE public."Contract" SET description_contract = descript, id_client = clientId, 
	id_pet = petId WHERE id_contract = idC
$$;
 }   DROP PROCEDURE public.update_contract(IN descript character varying, IN clientid integer, IN petid integer, IN idc integer);
       public          postgres    false            ?           0    0 o   PROCEDURE update_contract(IN descript character varying, IN clientid integer, IN petid integer, IN idc integer)    ACL       GRANT ALL ON PROCEDURE public.update_contract(IN descript character varying, IN clientid integer, IN petid integer, IN idc integer) TO manager;
GRANT ALL ON PROCEDURE public.update_contract(IN descript character varying, IN clientid integer, IN petid integer, IN idc integer) TO admi;
          public          postgres    false    254            ?            1255    33806 0   update_employee(text, text, text, text, integer) 	   PROCEDURE     7  CREATE PROCEDURE public.update_employee(IN name_e text, IN email_e text, IN title_e text, IN phone_e text, IN id_e integer)
    LANGUAGE sql
    AS $$
	UPDATE public."Employee" SET name_employee = name_e, email_employee = email_e, title = title_e, 
	phone_number_employee = phone_e WHERE id_employee = id_e
$$;
 {   DROP PROCEDURE public.update_employee(IN name_e text, IN email_e text, IN title_e text, IN phone_e text, IN id_e integer);
       public          postgres    false            ?           0    0 m   PROCEDURE update_employee(IN name_e text, IN email_e text, IN title_e text, IN phone_e text, IN id_e integer)    ACL     ?   GRANT ALL ON PROCEDURE public.update_employee(IN name_e text, IN email_e text, IN title_e text, IN phone_e text, IN id_e integer) TO admi;
          public          postgres    false    250            ?            1255    33807 /   update_employee_task(integer, integer, integer) 	   PROCEDURE     8  CREATE PROCEDURE public.update_employee_task(IN id_emp integer, IN id_task integer, IN new_id_emp integer)
    LANGUAGE sql
    AS $$
	UPDATE public."Employee_Task" SET "Employee_id_employee" = new_id_emp
                WHERE "Employee_id_employee" = id_emp AND "Task_id_task" = id_task AND position = 'И'
$$;
 j   DROP PROCEDURE public.update_employee_task(IN id_emp integer, IN id_task integer, IN new_id_emp integer);
       public          postgres    false            ?           0    0 \   PROCEDURE update_employee_task(IN id_emp integer, IN id_task integer, IN new_id_emp integer)    ACL     ?   GRANT ALL ON PROCEDURE public.update_employee_task(IN id_emp integer, IN id_task integer, IN new_id_emp integer) TO manager;
GRANT ALL ON PROCEDURE public.update_employee_task(IN id_emp integer, IN id_task integer, IN new_id_emp integer) TO admi;
          public          postgres    false    255                       1255    33808 H   update_equipment(character varying, integer, character varying, integer) 	   PROCEDURE     C  CREATE PROCEDURE public.update_equipment(IN name_e character varying, IN vendor_code integer, IN type_e character varying, IN id_e integer)
    LANGUAGE sql
    AS $$
    UPDATE public."Equipment" SET name_equipment = name_e, vendor_code = vendor_code, type_equipment = type_e
                WHERE id_equipment = id_e
$$;
 ?   DROP PROCEDURE public.update_equipment(IN name_e character varying, IN vendor_code integer, IN type_e character varying, IN id_e integer);
       public          postgres    false            ?           0    0 }   PROCEDURE update_equipment(IN name_e character varying, IN vendor_code integer, IN type_e character varying, IN id_e integer)    ACL     ?  GRANT ALL ON PROCEDURE public.update_equipment(IN name_e character varying, IN vendor_code integer, IN type_e character varying, IN id_e integer) TO doctor;
GRANT ALL ON PROCEDURE public.update_equipment(IN name_e character varying, IN vendor_code integer, IN type_e character varying, IN id_e integer) TO admi;
GRANT ALL ON PROCEDURE public.update_equipment(IN name_e character varying, IN vendor_code integer, IN type_e character varying, IN id_e integer) TO manager;
          public          postgres    false    257                        1255    33809 W   update_pet(character varying, character varying, character varying, character, integer) 	   PROCEDURE     5  CREATE PROCEDURE public.update_pet(IN namep character varying, IN kind character varying, IN age character varying, IN sex character, IN idp integer)
    LANGUAGE sql
    AS $$
    UPDATE public."Pet" SET animal_name = nameP, kind_of_animal = kind,
                age = age, sex = sex WHERE id_pet = idP
$$;
 ?   DROP PROCEDURE public.update_pet(IN namep character varying, IN kind character varying, IN age character varying, IN sex character, IN idp integer);
       public          postgres    false            ?           0    0 ?   PROCEDURE update_pet(IN namep character varying, IN kind character varying, IN age character varying, IN sex character, IN idp integer)    ACL     M  GRANT ALL ON PROCEDURE public.update_pet(IN namep character varying, IN kind character varying, IN age character varying, IN sex character, IN idp integer) TO manager;
GRANT ALL ON PROCEDURE public.update_pet(IN namep character varying, IN kind character varying, IN age character varying, IN sex character, IN idp integer) TO admi;
          public          postgres    false    256                       1255    33810 ~   update_task(character varying, character varying, date, character varying, boolean, integer, character varying, date, integer) 	   PROCEDURE       CREATE PROCEDURE public.update_task(IN namet character varying, IN description character varying, IN deadline date, IN priority character varying, IN status boolean, IN idcontract integer, IN employeename character varying, IN dateend date, IN idt integer)
    LANGUAGE sql
    AS $$
    UPDATE public."Task" SET name_task = nameT, description_task = description, 
	date_deadline = deadline, priority = priority, status = status, contract_id = idContract, 
	emp_name = employeeName, date_end = dateEnd WHERE id_task = idT
$$;
    DROP PROCEDURE public.update_task(IN namet character varying, IN description character varying, IN deadline date, IN priority character varying, IN status boolean, IN idcontract integer, IN employeename character varying, IN dateend date, IN idt integer);
       public          postgres    false            ?           0    0 ?   PROCEDURE update_task(IN namet character varying, IN description character varying, IN deadline date, IN priority character varying, IN status boolean, IN idcontract integer, IN employeename character varying, IN dateend date, IN idt integer)    ACL     5  GRANT ALL ON PROCEDURE public.update_task(IN namet character varying, IN description character varying, IN deadline date, IN priority character varying, IN status boolean, IN idcontract integer, IN employeename character varying, IN dateend date, IN idt integer) TO manager;
GRANT ALL ON PROCEDURE public.update_task(IN namet character varying, IN description character varying, IN deadline date, IN priority character varying, IN status boolean, IN idcontract integer, IN employeename character varying, IN dateend date, IN idt integer) TO doctor;
GRANT ALL ON PROCEDURE public.update_task(IN namet character varying, IN description character varying, IN deadline date, IN priority character varying, IN status boolean, IN idcontract integer, IN employeename character varying, IN dateend date, IN idt integer) TO admi;
          public          postgres    false    285            ?            1259    33811    Client    TABLE     ?   CREATE TABLE public."Client" (
    id_client integer NOT NULL,
    phone_number_client character(11) NOT NULL,
    email_client character varying(30),
    address character varying(50),
    name_client character varying(30) NOT NULL
);
    DROP TABLE public."Client";
       public         heap    postgres    false            ?           0    0    TABLE "Client"    COMMENT     k   COMMENT ON TABLE public."Client" IS 'Таблица для хранения данных клиента.';
          public          postgres    false    209            ?           0    0    COLUMN "Client".id_client    COMMENT     ?   COMMENT ON COLUMN public."Client".id_client IS 'Первичный ключ для идентификации клиента.';
          public          postgres    false    209            ?           0    0 #   COLUMN "Client".phone_number_client    COMMENT     ?   COMMENT ON COLUMN public."Client".phone_number_client IS 'Хранение информации о номере телефона клиента.';
          public          postgres    false    209            ?           0    0    COLUMN "Client".email_client    COMMENT     y   COMMENT ON COLUMN public."Client".email_client IS 'Хранение информации о почте клиента.';
          public          postgres    false    209            ?           0    0    COLUMN "Client".address    COMMENT     x   COMMENT ON COLUMN public."Client".address IS 'Хранение информации об адресе клиента.';
          public          postgres    false    209            ?           0    0    COLUMN "Client".name_client    COMMENT     ?   COMMENT ON COLUMN public."Client".name_client IS 'Хранение информации об имени клиента / названии организации.';
          public          postgres    false    209            ?           0    0    TABLE "Client"    ACL     [   GRANT ALL ON TABLE public."Client" TO manager;
GRANT ALL ON TABLE public."Client" TO admi;
          public          postgres    false    209            ?            1259    33814    Client_id_client_seq    SEQUENCE     ?   ALTER TABLE public."Client" ALTER COLUMN id_client ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Client_id_client_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    209            ?            1259    33815    Contract    TABLE     ?   CREATE TABLE public."Contract" (
    id_contract integer NOT NULL,
    description_contract text NOT NULL,
    date_contract date NOT NULL,
    id_client integer NOT NULL,
    id_pet integer NOT NULL
);
    DROP TABLE public."Contract";
       public         heap    postgres    false            ?           0    0    TABLE "Contract"    COMMENT     t   COMMENT ON TABLE public."Contract" IS 'Таблица для хранения данных о контракте.';
          public          postgres    false    211            ?           0    0    COLUMN "Contract".id_contract    COMMENT     ?   COMMENT ON COLUMN public."Contract".id_contract IS 'Первичный ключ для идентификации контракта.';
          public          postgres    false    211            ?           0    0 &   COLUMN "Contract".description_contract    COMMENT     ?   COMMENT ON COLUMN public."Contract".description_contract IS 'Хранение информации об описании котракта.';
          public          postgres    false    211            ?           0    0    COLUMN "Contract".date_contract    COMMENT     ?   COMMENT ON COLUMN public."Contract".date_contract IS 'Хранение информации о дате заключения контракта.';
          public          postgres    false    211            ?           0    0    COLUMN "Contract".id_client    COMMENT     ?   COMMENT ON COLUMN public."Contract".id_client IS 'Хранение информации о первичном ключе клиента.';
          public          postgres    false    211            ?           0    0    COLUMN "Contract".id_pet    COMMENT     ?   COMMENT ON COLUMN public."Contract".id_pet IS 'Хранение информации о первичном ключе питомца.';
          public          postgres    false    211            ?           0    0    TABLE "Contract"    ACL     ?   GRANT ALL ON TABLE public."Contract" TO manager;
GRANT SELECT ON TABLE public."Contract" TO doctor;
GRANT ALL ON TABLE public."Contract" TO admi;
          public          postgres    false    211            ?            1259    33820    Contract_id_contract_seq    SEQUENCE     ?   ALTER TABLE public."Contract" ALTER COLUMN id_contract ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Contract_id_contract_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    211            ?            1259    33821 	   Equipment    TABLE     ?   CREATE TABLE public."Equipment" (
    id_equipment integer NOT NULL,
    name_equipment character varying(20) NOT NULL,
    vendor_code integer NOT NULL,
    type_equipment character varying(20) NOT NULL
);
    DROP TABLE public."Equipment";
       public         heap    postgres    false            ?           0    0    TABLE "Equipment"    COMMENT     ?   COMMENT ON TABLE public."Equipment" IS 'Таблица для хранения данных о нужных комплектующих для определенной услуги.';
          public          postgres    false    213            ?           0    0    COLUMN "Equipment".id_equipment    COMMENT     ?   COMMENT ON COLUMN public."Equipment".id_equipment IS 'Первичный ключ для идентификации инструмента.';
          public          postgres    false    213            ?           0    0 !   COLUMN "Equipment".name_equipment    COMMENT     ?   COMMENT ON COLUMN public."Equipment".name_equipment IS 'Хранение информации о названии инструмента.';
          public          postgres    false    213            ?           0    0    COLUMN "Equipment".vendor_code    COMMENT     ?   COMMENT ON COLUMN public."Equipment".vendor_code IS 'Хранение информации об артикуле инструмента.';
          public          postgres    false    213            ?           0    0    TABLE "Equipment"    ACL     ?   GRANT ALL ON TABLE public."Equipment" TO manager;
GRANT SELECT,INSERT,UPDATE ON TABLE public."Equipment" TO doctor;
GRANT ALL ON TABLE public."Equipment" TO admi;
          public          postgres    false    213            ?            1259    33824    Detail_id_detail_seq    SEQUENCE     ?   ALTER TABLE public."Equipment" ALTER COLUMN id_equipment ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Detail_id_detail_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    213            ?            1259    33825    Employee    TABLE     9  CREATE TABLE public."Employee" (
    id_employee integer NOT NULL,
    name_employee character varying(30) NOT NULL,
    phone_number_employee character(11) NOT NULL,
    email_employee character varying(30) NOT NULL,
    title character varying(20) NOT NULL,
    login_employee character varying(10) NOT NULL
);
    DROP TABLE public."Employee";
       public         heap    postgres    false            ?           0    0    TABLE "Employee"    COMMENT     t   COMMENT ON TABLE public."Employee" IS 'Таблица для хранения данных сотрудника.
';
          public          postgres    false    215            ?           0    0    COLUMN "Employee".id_employee    COMMENT     ?   COMMENT ON COLUMN public."Employee".id_employee IS 'Первичный ключ для идентификации сотрудника.';
          public          postgres    false    215            ?           0    0    COLUMN "Employee".name_employee    COMMENT     ?   COMMENT ON COLUMN public."Employee".name_employee IS 'Хранение информации об имени сотрудника.';
          public          postgres    false    215            ?           0    0 '   COLUMN "Employee".phone_number_employee    COMMENT     ?   COMMENT ON COLUMN public."Employee".phone_number_employee IS 'Хранение информации о номере телефона сотрудника.';
          public          postgres    false    215            ?           0    0     COLUMN "Employee".email_employee    COMMENT     ?   COMMENT ON COLUMN public."Employee".email_employee IS 'Хранение информации о почте сотрудника.';
          public          postgres    false    215            ?           0    0    COLUMN "Employee".title    COMMENT     ?   COMMENT ON COLUMN public."Employee".title IS 'Хранение информации о должности сотрудника.';
          public          postgres    false    215            ?           0    0    TABLE "Employee"    ACL     ?   GRANT ALL ON TABLE public."Employee" TO manager;
GRANT SELECT,UPDATE ON TABLE public."Employee" TO doctor;
GRANT ALL ON TABLE public."Employee" TO admi;
          public          postgres    false    215            ?            1259    33828    Employee_Task    TABLE     ?   CREATE TABLE public."Employee_Task" (
    "Employee_id_employee" integer NOT NULL,
    "Task_id_task" integer NOT NULL,
    "position" character(1) NOT NULL
);
 #   DROP TABLE public."Employee_Task";
       public         heap    postgres    false            ?           0    0 -   COLUMN "Employee_Task"."Employee_id_employee"    COMMENT     ?   COMMENT ON COLUMN public."Employee_Task"."Employee_id_employee" IS 'Первичный ключ для идентификации сотрудника.';
          public          postgres    false    216            ?           0    0 %   COLUMN "Employee_Task"."Task_id_task"    COMMENT     ?   COMMENT ON COLUMN public."Employee_Task"."Task_id_task" IS 'Первичный ключ для идентификации задания.';
          public          postgres    false    216            ?           0    0 !   COLUMN "Employee_Task"."position"    COMMENT     ?   COMMENT ON COLUMN public."Employee_Task"."position" IS 'Позиция сотрудника (А - автор, И - исполнитель)';
          public          postgres    false    216            ?           0    0    TABLE "Employee_Task"    ACL     ?   GRANT ALL ON TABLE public."Employee_Task" TO manager;
GRANT INSERT ON TABLE public."Employee_Task" TO doctor;
GRANT ALL ON TABLE public."Employee_Task" TO admi;
          public          postgres    false    216            ?            1259    33831    Employee_id_employee_seq    SEQUENCE     ?   ALTER TABLE public."Employee" ALTER COLUMN id_employee ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Employee_id_employee_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    215            ?            1259    33832    Pet    TABLE     ?   CREATE TABLE public."Pet" (
    id_pet integer NOT NULL,
    kind_of_animal character varying(20) NOT NULL,
    sex character(1) NOT NULL,
    age character(2) NOT NULL,
    animal_name character(20) NOT NULL
);
    DROP TABLE public."Pet";
       public         heap    postgres    false            ?           0    0    TABLE "Pet"    COMMENT     s   COMMENT ON TABLE public."Pet" IS 'Таблица для хранения информации о питомце.';
          public          postgres    false    218            ?           0    0    COLUMN "Pet".id_pet    COMMENT     ?   COMMENT ON COLUMN public."Pet".id_pet IS 'Хранение информации о первичном ключе питомца.';
          public          postgres    false    218            ?           0    0    COLUMN "Pet".kind_of_animal    COMMENT     z   COMMENT ON COLUMN public."Pet".kind_of_animal IS 'Хранение информации о виде животного.';
          public          postgres    false    218            ?           0    0    COLUMN "Pet".sex    COMMENT     ?   COMMENT ON COLUMN public."Pet".sex IS 'Хранение информации о поле животного (М - мальчик, Д - девочка).';
          public          postgres    false    218            ?           0    0    COLUMN "Pet".age    COMMENT     s   COMMENT ON COLUMN public."Pet".age IS 'Хранение информации о возрасте питомца.';
          public          postgres    false    218            ?           0    0    COLUMN "Pet".animal_name    COMMENT     w   COMMENT ON COLUMN public."Pet".animal_name IS 'Хранение информации об имени питомца.';
          public          postgres    false    218            ?           0    0    TABLE "Pet"    ACL     ?   GRANT ALL ON TABLE public."Pet" TO manager;
GRANT SELECT ON TABLE public."Pet" TO doctor;
GRANT ALL ON TABLE public."Pet" TO admi;
          public          postgres    false    218            ?            1259    33835    Pet_id_pet_seq    SEQUENCE     ?   ALTER TABLE public."Pet" ALTER COLUMN id_pet ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Pet_id_pet_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
    CYCLE
);
            public          postgres    false    218            ?            1259    33836    Task    TABLE     ?  CREATE TABLE public."Task" (
    id_task integer NOT NULL,
    name_task character varying(30) NOT NULL,
    description_task text,
    date_create date NOT NULL,
    date_deadline date NOT NULL,
    date_end date,
    status boolean NOT NULL,
    contract_id integer,
    emp_name character varying(10),
    manager_name character varying(10) NOT NULL,
    priority character varying(1) NOT NULL
);
    DROP TABLE public."Task";
       public         heap    postgres    false            ?           0    0    TABLE "Task"    COMMENT        COMMENT ON TABLE public."Task" IS 'Таблица для хранения данных о конкретной услуге.';
          public          postgres    false    220            ?           0    0    COLUMN "Task".id_task    COMMENT     |   COMMENT ON COLUMN public."Task".id_task IS 'Первичный ключ для идентификации задания.';
          public          postgres    false    220            ?           0    0    COLUMN "Task".name_task    COMMENT     z   COMMENT ON COLUMN public."Task".name_task IS 'Хранение информации о названии задания.';
          public          postgres    false    220            ?           0    0    COLUMN "Task".description_task    COMMENT     ?   COMMENT ON COLUMN public."Task".description_task IS 'Хранение информации об описании задания.';
          public          postgres    false    220            ?           0    0    COLUMN "Task".date_create    COMMENT     ?   COMMENT ON COLUMN public."Task".date_create IS 'Хранение информации о дате создания задания.';
          public          postgres    false    220            ?           0    0    COLUMN "Task".date_deadline    COMMENT     ~   COMMENT ON COLUMN public."Task".date_deadline IS 'Хранение информации о дедлайне задания.';
          public          postgres    false    220            ?           0    0    COLUMN "Task".date_end    COMMENT     ?   COMMENT ON COLUMN public."Task".date_end IS 'Хранение информации о дате завершения задания.';
          public          postgres    false    220            ?           0    0    COLUMN "Task".status    COMMENT     ?   COMMENT ON COLUMN public."Task".status IS 'Хранение информации о статусе задания. (0 - в работе, 1 - завершено)';
          public          postgres    false    220            ?           0    0    COLUMN "Task".contract_id    COMMENT     |   COMMENT ON COLUMN public."Task".contract_id IS 'Хранение информации о номере контракта.';
          public          postgres    false    220            ?           0    0    COLUMN "Task".priority    COMMENT     ?   COMMENT ON COLUMN public."Task".priority IS 'Хранение информации о приоритете задания. 1 - высокий, 2 - средний, 3 - низкий.';
          public          postgres    false    220            ?           0    0    TABLE "Task"    ACL     ?   GRANT ALL ON TABLE public."Task" TO manager;
GRANT SELECT,TRIGGER,UPDATE ON TABLE public."Task" TO doctor;
GRANT ALL ON TABLE public."Task" TO admi;
          public          postgres    false    220            ?            1259    33841    Task_Equipment    TABLE     }   CREATE TABLE public."Task_Equipment" (
    "Task_id_task" integer NOT NULL,
    "Equipment_id_equipment" integer NOT NULL
);
 $   DROP TABLE public."Task_Equipment";
       public         heap    postgres    false            ?           0    0 &   COLUMN "Task_Equipment"."Task_id_task"    COMMENT     ?   COMMENT ON COLUMN public."Task_Equipment"."Task_id_task" IS 'Первичный ключ для идентификации задания.';
          public          postgres    false    221            ?           0    0 0   COLUMN "Task_Equipment"."Equipment_id_equipment"    COMMENT     ?   COMMENT ON COLUMN public."Task_Equipment"."Equipment_id_equipment" IS 'Первичный ключ для идентификации инструмента.';
          public          postgres    false    221            ?           0    0    TABLE "Task_Equipment"    ACL     ?   GRANT ALL ON TABLE public."Task_Equipment" TO manager;
GRANT SELECT,INSERT,UPDATE ON TABLE public."Task_Equipment" TO doctor;
GRANT ALL ON TABLE public."Task_Equipment" TO admi;
          public          postgres    false    221            ?            1259    33844    Task_id_task_seq    SEQUENCE     ?   ALTER TABLE public."Task" ALTER COLUMN id_task ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Task_id_task_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    220            ?            1259    33845 
   allClients    VIEW     Y  CREATE VIEW public."allClients" AS
 SELECT select_all_clients.id_client,
    select_all_clients.name_client,
    select_all_clients.phone_number_client,
    select_all_clients.email_client,
    select_all_clients.address
   FROM public.select_all_clients() select_all_clients(id_client, name_client, phone_number_client, email_client, address);
    DROP VIEW public."allClients";
       public          postgres    false    229            ?           0    0    TABLE "allClients"    ACL     c   GRANT ALL ON TABLE public."allClients" TO manager;
GRANT ALL ON TABLE public."allClients" TO admi;
          public          postgres    false    223            ?            1259    33849    allEmployees    VIEW     ?   CREATE VIEW public."allEmployees" AS
 SELECT "Employee".id_employee,
    "Employee".name_employee,
    "Employee".phone_number_employee,
    "Employee".email_employee,
    "Employee".title,
    "Employee".login_employee
   FROM public."Employee";
 !   DROP VIEW public."allEmployees";
       public          postgres    false    215    215    215    215    215    215            ?           0    0    TABLE "allEmployees"    ACL     2   GRANT ALL ON TABLE public."allEmployees" TO admi;
          public          postgres    false    224            ?            1259    33853    allPets    VIEW       CREATE VIEW public."allPets" AS
 SELECT select_all_pets.id_pet,
    select_all_pets.kind_of_animal,
    select_all_pets.sex,
    select_all_pets.age,
    select_all_pets.animal_name
   FROM public.select_all_pets() select_all_pets(id_pet, kind_of_animal, sex, age, animal_name);
    DROP VIEW public."allPets";
       public          postgres    false    238            ?           0    0    TABLE "allPets"    ACL     ]   GRANT ALL ON TABLE public."allPets" TO manager;
GRANT ALL ON TABLE public."allPets" TO admi;
          public          postgres    false    225            f          0    33811    Client 
   TABLE DATA           f   COPY public."Client" (id_client, phone_number_client, email_client, address, name_client) FROM stdin;
    public          postgres    false    209   
>      h          0    33815    Contract 
   TABLE DATA           i   COPY public."Contract" (id_contract, description_contract, date_contract, id_client, id_pet) FROM stdin;
    public          postgres    false    211   ?>      l          0    33825    Employee 
   TABLE DATA           ~   COPY public."Employee" (id_employee, name_employee, phone_number_employee, email_employee, title, login_employee) FROM stdin;
    public          postgres    false    215   @?      m          0    33828    Employee_Task 
   TABLE DATA           ]   COPY public."Employee_Task" ("Employee_id_employee", "Task_id_task", "position") FROM stdin;
    public          postgres    false    216   ??      j          0    33821 	   Equipment 
   TABLE DATA           `   COPY public."Equipment" (id_equipment, name_equipment, vendor_code, type_equipment) FROM stdin;
    public          postgres    false    213    @      o          0    33832    Pet 
   TABLE DATA           N   COPY public."Pet" (id_pet, kind_of_animal, sex, age, animal_name) FROM stdin;
    public          postgres    false    218   ?@      q          0    33836    Task 
   TABLE DATA           ?   COPY public."Task" (id_task, name_task, description_task, date_create, date_deadline, date_end, status, contract_id, emp_name, manager_name, priority) FROM stdin;
    public          postgres    false    220   zV      r          0    33841    Task_Equipment 
   TABLE DATA           T   COPY public."Task_Equipment" ("Task_id_task", "Equipment_id_equipment") FROM stdin;
    public          postgres    false    221   TW      ?           0    0    Client_id_client_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."Client_id_client_seq"', 10, true);
          public          postgres    false    210            ?           0    0    Contract_id_contract_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public."Contract_id_contract_seq"', 13, true);
          public          postgres    false    212            ?           0    0    Detail_id_detail_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."Detail_id_detail_seq"', 21, true);
          public          postgres    false    214            ?           0    0    Employee_id_employee_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public."Employee_id_employee_seq"', 13, true);
          public          postgres    false    217            ?           0    0    Pet_id_pet_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public."Pet_id_pet_seq"', 996, true);
          public          postgres    false    219            ?           0    0    Task_id_task_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."Task_id_task_seq"', 41, true);
          public          postgres    false    222            ?           2606    33858    Client Client_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public."Client"
    ADD CONSTRAINT "Client_pkey" PRIMARY KEY (id_client);
 @   ALTER TABLE ONLY public."Client" DROP CONSTRAINT "Client_pkey";
       public            postgres    false    209            ?           2606    33860    Contract Contract_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public."Contract"
    ADD CONSTRAINT "Contract_pkey" PRIMARY KEY (id_contract);
 D   ALTER TABLE ONLY public."Contract" DROP CONSTRAINT "Contract_pkey";
       public            postgres    false    211            ?           2606    33862    Equipment Detail_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public."Equipment"
    ADD CONSTRAINT "Detail_pkey" PRIMARY KEY (id_equipment);
 C   ALTER TABLE ONLY public."Equipment" DROP CONSTRAINT "Detail_pkey";
       public            postgres    false    213            ?           2606    33864    Employee Employee_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public."Employee"
    ADD CONSTRAINT "Employee_pkey" PRIMARY KEY (id_employee);
 D   ALTER TABLE ONLY public."Employee" DROP CONSTRAINT "Employee_pkey";
       public            postgres    false    215            ?           2606    33866    Pet Pet_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public."Pet"
    ADD CONSTRAINT "Pet_pkey" PRIMARY KEY (id_pet);
 :   ALTER TABLE ONLY public."Pet" DROP CONSTRAINT "Pet_pkey";
       public            postgres    false    218            ?           2606    33868    Task Task_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public."Task"
    ADD CONSTRAINT "Task_pkey" PRIMARY KEY (id_task);
 <   ALTER TABLE ONLY public."Task" DROP CONSTRAINT "Task_pkey";
       public            postgres    false    220            ?           1259    33869    detail_index    INDEX     l   CREATE UNIQUE INDEX detail_index ON public."Equipment" USING btree (id_equipment) INCLUDE (name_equipment);
     DROP INDEX public.detail_index;
       public            postgres    false    213    213            ?           1259    33870    employee_index    INDEX     l   CREATE UNIQUE INDEX employee_index ON public."Employee" USING btree (id_employee) INCLUDE (email_employee);
 "   DROP INDEX public.employee_index;
       public            postgres    false    215    215            ?           1259    33871 	   index_pet    INDEX     Q   CREATE UNIQUE INDEX index_pet ON public."Pet" USING btree (id_pet, animal_name);
    DROP INDEX public.index_pet;
       public            postgres    false    218    218            ?           1259    33872 
   task_index    INDEX     [   CREATE UNIQUE INDEX task_index ON public."Task" USING btree (id_task) INCLUDE (name_task);
    DROP INDEX public.task_index;
       public            postgres    false    220    220            ?           2620    33873    Task emp_stamp    TRIGGER     u   CREATE TRIGGER emp_stamp AFTER INSERT OR UPDATE ON public."Task" FOR EACH ROW EXECUTE FUNCTION public.delete_data();
 )   DROP TRIGGER emp_stamp ON public."Task";
       public          postgres    false    220    252            ?           2606    33874 5   Employee_Task Employee_Task_Employee_id_employee_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Employee_Task"
    ADD CONSTRAINT "Employee_Task_Employee_id_employee_fkey" FOREIGN KEY ("Employee_id_employee") REFERENCES public."Employee"(id_employee) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 c   ALTER TABLE ONLY public."Employee_Task" DROP CONSTRAINT "Employee_Task_Employee_id_employee_fkey";
       public          postgres    false    3267    216    215            ?           2606    33879 -   Employee_Task Employee_Task_Task_id_task_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Employee_Task"
    ADD CONSTRAINT "Employee_Task_Task_id_task_fkey" FOREIGN KEY ("Task_id_task") REFERENCES public."Task"(id_task) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 [   ALTER TABLE ONLY public."Employee_Task" DROP CONSTRAINT "Employee_Task_Task_id_task_fkey";
       public          postgres    false    3273    220    216            ?           2606    33884 9   Task_Equipment Task_Equipment_Equipment_id_Equipment_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Task_Equipment"
    ADD CONSTRAINT "Task_Equipment_Equipment_id_Equipment_fkey" FOREIGN KEY ("Equipment_id_equipment") REFERENCES public."Equipment"(id_equipment) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 g   ALTER TABLE ONLY public."Task_Equipment" DROP CONSTRAINT "Task_Equipment_Equipment_id_Equipment_fkey";
       public          postgres    false    3264    221    213            ?           2606    33889 /   Task_Equipment Task_Equipment_Task_id_task_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Task_Equipment"
    ADD CONSTRAINT "Task_Equipment_Task_id_task_fkey" FOREIGN KEY ("Task_id_task") REFERENCES public."Task"(id_task) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 ]   ALTER TABLE ONLY public."Task_Equipment" DROP CONSTRAINT "Task_Equipment_Task_id_task_fkey";
       public          postgres    false    221    3273    220            ?           2606    33894    Contract client_id    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Contract"
    ADD CONSTRAINT client_id FOREIGN KEY (id_client) REFERENCES public."Client"(id_client) NOT VALID;
 >   ALTER TABLE ONLY public."Contract" DROP CONSTRAINT client_id;
       public          postgres    false    209    3260    211            ?           2606    33899    Task contract_id    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Task"
    ADD CONSTRAINT contract_id FOREIGN KEY (contract_id) REFERENCES public."Contract"(id_contract) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 <   ALTER TABLE ONLY public."Task" DROP CONSTRAINT contract_id;
       public          postgres    false    211    3262    220            ?           2606    33904    Contract pet_id    FK CONSTRAINT     }   ALTER TABLE ONLY public."Contract"
    ADD CONSTRAINT pet_id FOREIGN KEY (id_pet) REFERENCES public."Pet"(id_pet) NOT VALID;
 ;   ALTER TABLE ONLY public."Contract" DROP CONSTRAINT pet_id;
       public          postgres    false    218    211    3270            a           0    33836    Task    ROW SECURITY     4   ALTER TABLE public."Task" ENABLE ROW LEVEL SECURITY;          public          postgres    false    220            b           3256    33909    Task info_admi    POLICY     ?   CREATE POLICY info_admi ON public."Task" USING (('admin'::text = (( SELECT "Employee".title
   FROM public."Employee"
  WHERE (("Employee".login_employee)::text = CURRENT_USER)))::text));
 (   DROP POLICY info_admi ON public."Task";
       public          postgres    false    215    215    220            c           3256    33910    Task info_manager    POLICY     ?   CREATE POLICY info_manager ON public."Task" USING (('manager'::text = (( SELECT "Employee".title
   FROM public."Employee"
  WHERE (("Employee".login_employee)::text = CURRENT_USER)))::text));
 +   DROP POLICY info_manager ON public."Task";
       public          postgres    false    215    215    220            d           3256    33911    Task select_info_doctor    POLICY     r   CREATE POLICY select_info_doctor ON public."Task" FOR SELECT TO doctor USING ((CURRENT_USER = (emp_name)::text));
 1   DROP POLICY select_info_doctor ON public."Task";
       public          postgres    false    220    220            e           3256    33912    Task update_info_doctor    POLICY     r   CREATE POLICY update_info_doctor ON public."Task" FOR UPDATE TO doctor USING ((CURRENT_USER = (emp_name)::text));
 1   DROP POLICY update_info_doctor ON public."Task";
       public          postgres    false    220    220            f   ?   x?m?;
?@E??U?dp2?M???DT? ?u?B[;Ac!1YÝ????5??{O?B????
?l6???h'?n^R????Р@>??=?hQ?????GI?R
?<??%r???????4Z???cX??W?x??A??؅j????]?;ިmF?G!p?|$9??a?      h   l   x?U???@C?d?[ ?]?0?
v@l?WB ?
?F:$;v?g?Vl81?b?p????????????&!	!??$??qaei?Ql????
?ciu???I%h??+A?      l   ?   x????0??֋M.컰I???S?8-,??-ML-L?9RK???JR?K???s9S??K????\?f_?p??bӅ}?/캰??^???.??bbjiafdfl?X\???????0)71/1=?I??Ј31%73??????????"?VT
??\1z\\\ ??J      m      x???46??0?˒??D??qqq 9??      j   l   x??A
?@F??N?	bf???x3??E m?Sb???}7J?>?/z?Ώ73Y?.V?j?~oܘt-??ė?,??`?$>?֖V|??OF??uT?k!??9?Z!9?      o      x???K?lIR??yWqW??????b??F ?????i??RAQ?[??7?A??s,jP???q???????~/o??n???????n?o???????>??_?ϗ?????Ϸ?}{>??&?????????~|????????????????ۏ?iy??????p??۷Ͽ~?M)o????????_|???ǗI/(???W????n?}?z????u?u??ǋ??E??????}?????????>?o????????_????xL???????????f???????????o??????c????Ͽ׏/g:????Ǜoҏ?????????????_i:?e?`?p?^??zuz????`kV??????Ԯ4?u?{?`??C]?E^???8?"~?À???w????F?.=I?????N"\?f?x??jMa~?o?j~?W?o?w[???yK??V?:?r΁??گ???m?m??????Mԋ????ߍ-???Ƙi?????-C?І??K?p}??ן.?{?~??E0;[???F??9.?R胆s????7&??h??;M????\d[#0b4?1??nZ?????ܰ??D??C??ejw]?jfQ??bt6???M=.8???1?????ǧڦ?Ǘv_aWO?????;??\?ޘ?~}Y??\??iO?~?q????-???@4??k:!Ph$??:???px?3ާ#????u?]$E?:R??xS?Y????ܧ?`??8?j?ab??T???C?l2a<-?N???9??m??Q?u}???O?'??????6???b?	?????b$B'?쯶I?h?o??+??r?kⷔK?Ώ???]?? ?r??w??;k?؉?$?/.?'~?44???H岡???M8]h9?O????؍w@-U?}??fBЦi?+*eh۩8?ڒ	p??Xv?!lV??????[????ŧ(?? i?*?DM)J??{!?Y???Hѿ?z??\?빒??X??????ρ?^??yc?kڸ?#?ᦊ/L?J?#nK?sgz??8D,MقfئZ?ɏk???+7Qg??m?p?k׹2?{??7v??????>??g???R???x??^ڇ??????P???????t{éP??{?ۘ¿??????! XE_1??n??}??_?P?2????ys?q^???/S?a?
;?~???Cl?S;튩q????eꌚ?bZ?>?8S????ŵP]???5*?x?VpR?????0EY??A?????s???L?F??,KЏ={?ec1????;ۧ?Cz?/ή!~ ƥ?"?Yqc??]/Z7;U??5?4@?PQq?_6w?Q"?jD?&?F?ߞ=?p?]??M??<?3.Ewv!??.7+???ٽn]?|?Աq[???'郺S\V`?n?^ꮸ???ъ??C???M??8S5 ?0??6iL???-/<n?o????m?R??:??z?/??Z?<z?k?Z?U?N?8??Ŕ?茮%?D??P?_????k?6͑e-?N?{???NYc5???X-#??cE??V??p?z "?5`?1?U?̰T?8QS|(?Ppn?M??g???e#?p?ax,֦?o?j?????y?_???4C?ĥk:2c?Dm??|Z?G?u????????e????b??u ?8????`? ???c ??!???[??G??????f???AR}??V?|??T3;?t?I?\?c? w???=]f??~?x5?8???>?C?ܱN{f??i??3Osno?$[?b2ju1?w&???????Gj?	??F?e>݈????CI?.}|3???޺`|?a,C?_h??S6?????<????2?Q??9?[^??.??`?S??m ?q?*(·??e???h?>p??A"̪??ŏ????m?*?xM??[?j?!??'m?U??k?t?]????~uk?>x? @c
kݦ??A?????i???j?>?'?o????+??????q??=+???????m?vYZҤ??.??gVg݇??n,X4?Qyh?
P?B?LE??XdoP?h}??U<?,?F??VL)????"c??LO??n?똍????e?Y?4??[ S?F?o?|M<?j??0??!.ѪYf?жjrm~\??еj?Rj?jMGއ?MU???????S?4???.?5C?bA3ޞͬ.rvZ?'3???vS"??u??D?n?wC??l'?p??vχS?k??????c0;??׺?????K??]0̸?ц9??<?\???@?j?dv?yMF^C???ܢ?Ja??{?j?Mw?ѡ?/??CS?????x.b?c?? ??=>/???6=b=?ԷFm.Fv???.o<?A?8i:?%?f?1?*7?^v .[?y??$m?K??v{Ӏ?0B[??c?i[ޡM_?????]z?Gӄ-?taN?B]?L??~yV????f1?(??MLv???^8?n????|??ML????R??{?%??? ??#4????c?RFm{???? /??=w?\7er.??#?xN???N??/m?]^w?2AE???8??S???\??????H?4?S?[? zЍ	/?a???\??i~?Wт??f???X?=??S?n?1???Ŭ4?O?+?IGw?2??^????hw?Ǹԣ?Lr????9?No&??^MX????X8?U{5??.??d??bi*B?z?!٩K????????<?{3??:??ý{??l???????5n?<?[ 7?????A??trQ?[?və?ջ??c_?u# ???vg"?w?????Q??H??d???zaB?k?Fقn%??'9???????3????9??g?;?dM?hK???y?}8D
???R?`?Ѝ??vӓy?Û>!?>=?0?$.P?K?I?5?nZ3?E?ϡm?m?ܚ??Z????H?q?W?Ʈ?o?K??E*;1????n?e?L????F????79??~|??p?ˌ?V=?.[??E$?t????Y?? ????H?]r?ㇽ(ڼyO??}??%/?	?}?!,3????;Jf??l\?ڊ?6k??S73?quӝ?@X?3?? g????(??F???˰R;.m?x??˱l,??Z?$?a?e4?q??K?X?.|b???@:??	?C??f\Y)?Q?Z??tk?FI??ۦ?r?z?Q???#h?<?)? ?>L?&?t??D?G5A?kF???,tV?}Ԝ??0ݚ#?????T?X?}T?*d<sXm????[?W??G?	???Sx>?1[??m????0?3Nk?????"????rB?=??޳R??Ԯ?vz^??%?????6ړz????y???;??Pp?̱ce(?Dd#??>FN?}????::?ޅ1r????g[????9??a?gL?N?aB]????>f.?3? ????
???Ҁv????e??????lv?Q?1??dWN	~X???F????Y1??4?k7? f?Y?4???	??*?5C.Ր?&???(????8Β?,??z2	g???R???7vMӎ?e?a?2?1G??????4J?O?%??~E~D|3,??6?NJÏ????F?{c?a?a?uY??h敓?????O?WJ~:=?X?WR~^/H?O.Þ???.Pr?1?Y~?s?4?,Ii??????4????x6]????????o:?]r?d??4??)i??f|kVԟ?!???3?<?GC?)i?Yu-5!?8C????ʅ??9i?in???o6??Cp?4?f?e6S?@??r??Ө?cD3????Tg?J?ϦӬ????gOJ?O-c??f$?\??d??eHs?=+?y3f??$^6ͅ ?zN~*e??t??4?T@?)?/H?ϑ???/݃9M?&???J?O#ivh8?C??w5d???s? ?M?&?s??᧡??4??^??('?M?&r8????3+?ӌ?cs???gЛɅ??t???JJ?O,;X??/?I?O,;I?M?Q?bJJ~?+??S4#?????1;H?O1??3?? ?X??᧘?.??0#i?))i??????s????p?,????s???g ?q?S???U???s??sk[Fi?u??K?<ZZ?rie?&?e? 4k??e?M)i?ݖ?u?u?" ?  ???4??L???2??Sָ?? p1,???h?ޚ???*9i???d????& D?VIIï???_A{&ϭӝɲ䫦????-?cqU|s??&b??r?e???e?2q?????1??????<?jK????%WЕ?????b?e?̸5dZ?? ??+N??"?????-/Hï?nl?]?,7?^?E 'R???????r0??I?uf"??zJ~?h?Kï@?????0c??S???p?0w\????/?I???GJ~9?2??.3;?b???L??_?u ?	HIï??4?2?h??7ݚ̋Z;C?w9}?(??????e?f?ɵfV~͜4??)i?5S??k???Y?%?+??0S]??٩cqa?f?ŗ?????>M$ڮ???_+%?i3n?_Fú?rg?IFی?/IIï?
 $?-?ov?|????%9i??Bh?r?H?/%vv?n_???\X?i?eXh(F?vN~?P~??4??W?4??)i?5jb?BL?&wuIp J?˕????D?؋5	?Q?T̕?ȣ???Q??&?t-?NM??#??l3?4??%?M???᛽?4?X???8???bo  
?????9ix??hR?TyOI?KMIË??d????.J???G??oO+????)ixq????Y?
"?*??4??L??ӂɧ???4?????i9ixqE?ޏ됒???a?5?)ix	??dڔ??P???ᥧ??%j?DV???(/F??ᥧ???(?1^̕??s??X?Z???뿊?,;I????	?|V^?+319ix1?'?c\b??aUY\z????)?j$??u??tf2? ޭ ؓ*?;???R??2_???rv?DӘ??z?R?`b?i??b?,???f{a&??b.???a^8?n???X>??RY9ix?KmR???K2;IË???%????????Aϧ??Ņ?N2]b?29???Q^LW&J??֖????ve? X^vR^?k2???I??NIË%?!B?nLx????%??w_9i???f?e?X?=9i?m?1???? ??m.??c?]???.???v?̸???Lr????9?No&??]r?𻤤?w?I?oӓ??𻤤?w?J?oC5;H?o?+?T??5'?k??5)?kN~ל4???H????4??)i???????R????F ????D.?v??@v??30Җ???-%?[J~[3?I=+?{N~??4?v?̘F???L?%?? y??\ph?='??n?F?t??LFk?xA~??4?/H?os??f??ι?Eq?; N?6r??;?????6Jf?????????????"???;????m?e?=_????i????؏ϔ4?6,3&Z?@????JI???+'?WJ~?䲓4?^)i??R??{?"?WN~~ىF?I?Cd&)i?m?@?i?Ӹ???D lݙ?f
?3T?ݒ?????4??eX??;%?wV~?2$?l?,Ñ?k4/?TC,cn?e?i????/_??/???@      q   ?   x???M
?0?דS?J@=?'?FDQ+Z\k?Ѕ??x????J?+???ӂ(?"$d?2??=?A8"G?+?y??׼?HE???D?J?3B?bܐ!?(????U?)d?U3e_J?L??=o?.hܙ{nw0N?Vv?pB?w?b+?E??K???????W?Fξ??7Җ?A?%?B?Tq?9??2???h?PMr??'9?iM?ԕRY ?#      r      x?36?42?26?42?????? ?g     