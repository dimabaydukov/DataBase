PGDMP     :                    z         	   VetClinic    14.5    14.5 �    g           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            h           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            i           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            j           1262    33372 	   VetClinic    DATABASE     h   CREATE DATABASE "VetClinic" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE "VetClinic";
                postgres    false                       1255    33488    check_role(character varying)    FUNCTION     �   CREATE FUNCTION public.check_role(login character varying) RETURNS text
    LANGUAGE sql
    AS $$
  SELECT title FROM public."Employee" WHERE login_employee = login;
$$;
 :   DROP FUNCTION public.check_role(login character varying);
       public          postgres    false            k           0    0 ,   FUNCTION check_role(login character varying)    ACL     �   GRANT ALL ON FUNCTION public.check_role(login character varying) TO doctor;
GRANT ALL ON FUNCTION public.check_role(login character varying) TO manager;
          public          postgres    false    259            �            1255    33528    create_report_employee() 	   PROCEDURE       CREATE PROCEDURE public.create_report_employee()
    LANGUAGE sql
    AS $$
	COPY "Employee" (name_employee, phone_number_employee, email_employee, title, login_employee)
                TO 'D:\\Git\\DataBase\\saveEmployee.json'
                DELIMITER ',' CSV HEADER;
$$;
 0   DROP PROCEDURE public.create_report_employee();
       public          postgres    false            l           0    0 "   PROCEDURE create_report_employee()    ACL     C   GRANT ALL ON PROCEDURE public.create_report_employee() TO manager;
          public          postgres    false    245            �            1255    33527    create_report_task() 	   PROCEDURE       CREATE PROCEDURE public.create_report_task()
    LANGUAGE sql
    AS $$
	COPY "Task"(name_task, description_task, date_create, date_deadline, priority, date_end, status)
                TO 'D:\\Git\\DataBase\\saveTask.json\'
                DELIMITER ',' CSV HEADER;
$$;
 ,   DROP PROCEDURE public.create_report_task();
       public          postgres    false            m           0    0    PROCEDURE create_report_task()    ACL     ?   GRANT ALL ON PROCEDURE public.create_report_task() TO manager;
          public          postgres    false    246            �            1255    33485 D   create_user(character varying, character varying, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.create_user(IN login character varying, IN pass character varying, IN roleu character varying)
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
       public          postgres    false            n           0    0 h   PROCEDURE create_user(IN login character varying, IN pass character varying, IN roleu character varying)    ACL       GRANT ALL ON PROCEDURE public.create_user(IN login character varying, IN pass character varying, IN roleu character varying) TO doctor;
GRANT ALL ON PROCEDURE public.create_user(IN login character varying, IN pass character varying, IN roleu character varying) TO manager;
          public          postgres    false    242            �            1255    33465    delete_client(integer) 	   PROCEDURE     �   CREATE PROCEDURE public.delete_client(IN idclient integer)
    LANGUAGE sql
    AS $$
	DELETE FROM public."Client" WHERE id_client = idClient
$$;
 :   DROP PROCEDURE public.delete_client(IN idclient integer);
       public          postgres    false            o           0    0 ,   PROCEDURE delete_client(IN idclient integer)    ACL     M   GRANT ALL ON PROCEDURE public.delete_client(IN idclient integer) TO manager;
          public          postgres    false    244            �            1255    33480    delete_contract(integer) 	   PROCEDURE     �   CREATE PROCEDURE public.delete_contract(IN idc integer)
    LANGUAGE sql
    AS $$
    DELETE FROM public."Contract" WHERE id_contract = idC
$$;
 7   DROP PROCEDURE public.delete_contract(IN idc integer);
       public          postgres    false            p           0    0 )   PROCEDURE delete_contract(IN idc integer)    ACL     J   GRANT ALL ON PROCEDURE public.delete_contract(IN idc integer) TO manager;
          public          postgres    false    247            �            1255    33373    delete_data()    FUNCTION     �   CREATE FUNCTION public.delete_data() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM "Task" WHERE (CURRENT_DATE - date_end) >= 365;
    RETURN NULL;
END;
$$;
 $   DROP FUNCTION public.delete_data();
       public          postgres    false            q           0    0    FUNCTION delete_data()    ACL     p   GRANT ALL ON FUNCTION public.delete_data() TO manager;
GRANT ALL ON FUNCTION public.delete_data() TO tech_spec;
          public          postgres    false    226                       1255    33579    delete_equipment(integer) 	   PROCEDURE     �   CREATE PROCEDURE public.delete_equipment(IN id_e integer)
    LANGUAGE sql
    AS $$
    DELETE FROM public."Equipment" WHERE id_equipment = id_e
$$;
 9   DROP PROCEDURE public.delete_equipment(IN id_e integer);
       public          postgres    false            �            1255    33483 *   delete_equipmentfromtask(integer, integer) 	   PROCEDURE     �   CREATE PROCEDURE public.delete_equipmentfromtask(IN idtask integer, IN idequipment integer)
    LANGUAGE sql
    AS $$
    DELETE FROM public."Task_Equipment" WHERE "Task_id_task" = idTask AND 
                "Equipment_id_equipment" = idEquipment
$$;
 [   DROP PROCEDURE public.delete_equipmentfromtask(IN idtask integer, IN idequipment integer);
       public          postgres    false            r           0    0 M   PROCEDURE delete_equipmentfromtask(IN idtask integer, IN idequipment integer)    ACL     n   GRANT ALL ON PROCEDURE public.delete_equipmentfromtask(IN idtask integer, IN idequipment integer) TO manager;
          public          postgres    false    248            �            1255    33481    delete_pet(integer) 	   PROCEDURE     �   CREATE PROCEDURE public.delete_pet(IN idp integer)
    LANGUAGE sql
    AS $$
    DELETE FROM public."Pet" WHERE id_pet = idP
$$;
 2   DROP PROCEDURE public.delete_pet(IN idp integer);
       public          postgres    false            s           0    0 $   PROCEDURE delete_pet(IN idp integer)    ACL     E   GRANT ALL ON PROCEDURE public.delete_pet(IN idp integer) TO manager;
          public          postgres    false    232            �            1255    33479    delete_task(integer) 	   PROCEDURE     �   CREATE PROCEDURE public.delete_task(IN idt integer)
    LANGUAGE sql
    AS $$
    DELETE FROM public."Task" WHERE id_task = idT
$$;
 3   DROP PROCEDURE public.delete_task(IN idt integer);
       public          postgres    false            t           0    0 %   PROCEDURE delete_task(IN idt integer)    ACL     F   GRANT ALL ON PROCEDURE public.delete_task(IN idt integer) TO manager;
          public          postgres    false    249                       1255    33580 Y   insert_client(character varying, character varying, character varying, character varying) 	   PROCEDURE     ]  CREATE PROCEDURE public.insert_client(IN nameclient character varying, IN phonenumber character varying, IN email character varying, IN address_c character varying)
    LANGUAGE sql
    AS $$
INSERT INTO public."Client" (name_client, phone_number_client, email_client, address)
                VALUES (nameClient, phoneNumber, email, address_c)
$$;
 �   DROP PROCEDURE public.insert_client(IN nameclient character varying, IN phonenumber character varying, IN email character varying, IN address_c character varying);
       public          postgres    false            �            1255    33467 :   insert_contract(character varying, date, integer, integer) 	   PROCEDURE     7  CREATE PROCEDURE public.insert_contract(IN description character varying, IN datec date, IN idclient integer, IN idpet integer)
    LANGUAGE sql
    AS $$
    INSERT INTO public."Contract" (description_contract, date_contract, id_client, id_pet)
                VALUES (description, dateC, idClient, idPet)
$$;
    DROP PROCEDURE public.insert_contract(IN description character varying, IN datec date, IN idclient integer, IN idpet integer);
       public          postgres    false            u           0    0 q   PROCEDURE insert_contract(IN description character varying, IN datec date, IN idclient integer, IN idpet integer)    ACL     �   GRANT ALL ON PROCEDURE public.insert_contract(IN description character varying, IN datec date, IN idclient integer, IN idpet integer) TO manager;
          public          postgres    false    250            �            1255    33486 n   insert_employee(character varying, character varying, character varying, character varying, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.insert_employee(IN namee character varying, IN phone character varying, IN email character varying, IN title character varying, IN login_e character varying)
    LANGUAGE sql
    AS $$
    INSERT INTO public."Employee" (name_employee, phone_number_employee, email_employee,
                title, login_employee)
                VALUES (namee, phone, email, title, login_e)
$$;
 �   DROP PROCEDURE public.insert_employee(IN namee character varying, IN phone character varying, IN email character varying, IN title character varying, IN login_e character varying);
       public          postgres    false            v           0    0 �   PROCEDURE insert_employee(IN namee character varying, IN phone character varying, IN email character varying, IN title character varying, IN login_e character varying)    ACL     �  REVOKE ALL ON PROCEDURE public.insert_employee(IN namee character varying, IN phone character varying, IN email character varying, IN title character varying, IN login_e character varying) FROM PUBLIC;
GRANT ALL ON PROCEDURE public.insert_employee(IN namee character varying, IN phone character varying, IN email character varying, IN title character varying, IN login_e character varying) TO manager;
          public          postgres    false    243                       1255    33557 +   insert_employeetask(integer, integer, text) 	   PROCEDURE     �   CREATE PROCEDURE public.insert_employeetask(IN ide integer, IN idt integer, IN pos text)
    LANGUAGE sql
    AS $$
    INSERT INTO public."Employee_Task" ("Employee_id_employee", "Task_id_task", position)
                VALUES (idE, idT, pos)
	
$$;
 X   DROP PROCEDURE public.insert_employeetask(IN ide integer, IN idt integer, IN pos text);
       public          postgres    false            w           0    0 J   PROCEDURE insert_employeetask(IN ide integer, IN idt integer, IN pos text)    ACL     k   GRANT ALL ON PROCEDURE public.insert_employeetask(IN ide integer, IN idt integer, IN pos text) TO manager;
          public          postgres    false    267                       1255    33575 ?   insert_equipment(character varying, integer, character varying) 	   PROCEDURE       CREATE PROCEDURE public.insert_equipment(IN name_e character varying, IN vendor_c integer, IN type_e character varying)
    LANGUAGE sql
    AS $$
    INSERT INTO public."Equipment" (name_equipment, vendor_code, type_equipment)
                VALUES (name_e, vendor_c, type_e)
$$;
 w   DROP PROCEDURE public.insert_equipment(IN name_e character varying, IN vendor_c integer, IN type_e character varying);
       public          postgres    false            �            1255    33532 N   insert_pet(character varying, character varying, character varying, character) 	   PROCEDURE       CREATE PROCEDURE public.insert_pet(IN namep character varying, IN kind character varying, IN age character varying, IN sex character)
    LANGUAGE sql
    AS $$
    INSERT INTO public."Pet" (animal_name, kind_of_animal, age, sex)
                VALUES (namep, kind, age, sex)
$$;
 �   DROP PROCEDURE public.insert_pet(IN namep character varying, IN kind character varying, IN age character varying, IN sex character);
       public          postgres    false            x           0    0 w   PROCEDURE insert_pet(IN namep character varying, IN kind character varying, IN age character varying, IN sex character)    ACL     �   GRANT ALL ON PROCEDURE public.insert_pet(IN namep character varying, IN kind character varying, IN age character varying, IN sex character) TO manager;
          public          postgres    false    254                       1255    33566 �   insert_task(character varying, character varying, date, date, character varying, boolean, integer, character varying, character varying, date) 	   PROCEDURE     s  CREATE PROCEDURE public.insert_task(IN namet character varying, IN description character varying, IN datecreate date, IN deadline date, IN priority character varying, IN status boolean, IN idcontract integer, IN employeename character varying, IN managername character varying, IN dateend date)
    LANGUAGE sql
    AS $$
    INSERT INTO public."Task" (name_task, description_task, date_create, date_deadline,
                priority, status, contract_id, emp_name, manager_name, date_end) 
                VALUES (nameT,description,dateCreate,deadline,priority,status,idContract,
						employeeName,managerName,dateEnd);
$$;
 &  DROP PROCEDURE public.insert_task(IN namet character varying, IN description character varying, IN datecreate date, IN deadline date, IN priority character varying, IN status boolean, IN idcontract integer, IN employeename character varying, IN managername character varying, IN dateend date);
       public          postgres    false            y           0    0   PROCEDURE insert_task(IN namet character varying, IN description character varying, IN datecreate date, IN deadline date, IN priority character varying, IN status boolean, IN idcontract integer, IN employeename character varying, IN managername character varying, IN dateend date)    ACL     9  GRANT ALL ON PROCEDURE public.insert_task(IN namet character varying, IN description character varying, IN datecreate date, IN deadline date, IN priority character varying, IN status boolean, IN idcontract integer, IN employeename character varying, IN managername character varying, IN dateend date) TO manager;
          public          postgres    false    270                        1255    33474 &   insert_taskequipment(integer, integer) 	   PROCEDURE     �   CREATE PROCEDURE public.insert_taskequipment(IN idtask integer, IN idequipment integer)
    LANGUAGE sql
    AS $$
    INSERT INTO public."Task_Equipment" ("Task_id_task", "Equipment_id_equipment")
                VALUES (idTask, idEquipment)
$$;
 W   DROP PROCEDURE public.insert_taskequipment(IN idtask integer, IN idequipment integer);
       public          postgres    false            z           0    0 I   PROCEDURE insert_taskequipment(IN idtask integer, IN idequipment integer)    ACL     �   GRANT ALL ON PROCEDURE public.insert_taskequipment(IN idtask integer, IN idequipment integer) TO doctor;
GRANT ALL ON PROCEDURE public.insert_taskequipment(IN idtask integer, IN idequipment integer) TO manager;
          public          postgres    false    256            �            1255    33374    save_to_json() 	   PROCEDURE     �   CREATE PROCEDURE public.save_to_json()
    LANGUAGE sql
    AS $$COPY ( SELECT array_to_json(array_agg(row_to_json(t)))
from "Task" 
t
) TO 'D:\GitHub\DataBase\save.json';$$;
 &   DROP PROCEDURE public.save_to_json();
       public          postgres    false                       1255    33581    select_all_clients()    FUNCTION       CREATE FUNCTION public.select_all_clients() RETURNS TABLE(id_client integer, name_client text, phone_number_client text, email_client text, address text)
    LANGUAGE sql
    AS $$
	SELECT id_client, name_client, phone_number_client, email_client, address FROM public."Client"
$$;
 +   DROP FUNCTION public.select_all_clients();
       public          postgres    false            �            1255    33502    select_all_contracts()    FUNCTION     %  CREATE FUNCTION public.select_all_contracts() RETURNS TABLE(id_contract integer, description_contract text, date_contract date, id_client integer, id_pet integer)
    LANGUAGE sql
    AS $$
	SELECT id_contract, description_contract, date_contract, id_client, id_pet FROM public."Contract"
$$;
 -   DROP FUNCTION public.select_all_contracts();
       public          postgres    false            {           0    0    FUNCTION select_all_contracts()    ACL     @   GRANT ALL ON FUNCTION public.select_all_contracts() TO manager;
          public          postgres    false    241                       1255    33577    select_all_equipments()    FUNCTION       CREATE FUNCTION public.select_all_equipments() RETURNS TABLE(id_equipment integer, name_equipment text, vendor_code text, type_equipment text)
    LANGUAGE sql
    AS $$
	SELECT id_equipment, name_equipment, vendor_code, type_equipment FROM public."Equipment"
$$;
 .   DROP FUNCTION public.select_all_equipments();
       public          postgres    false            �            1255    33526 (   select_all_equipments_from_task(integer)    FUNCTION     �   CREATE FUNCTION public.select_all_equipments_from_task(id_t integer) RETURNS TABLE(equipment_id_equipment integer)
    LANGUAGE sql
    AS $$
	SELECT "Equipment_id_equipment" FROM public."Task_Equipment" WHERE "Task_id_task" = id_t
$$;
 D   DROP FUNCTION public.select_all_equipments_from_task(id_t integer);
       public          postgres    false            |           0    0 6   FUNCTION select_all_equipments_from_task(id_t integer)    ACL     �   GRANT ALL ON FUNCTION public.select_all_equipments_from_task(id_t integer) TO doctor;
GRANT ALL ON FUNCTION public.select_all_equipments_from_task(id_t integer) TO manager;
          public          postgres    false    253            
           1255    33538    select_all_equipments_id()    FUNCTION     �   CREATE FUNCTION public.select_all_equipments_id() RETURNS TABLE(id_equipment integer)
    LANGUAGE sql
    AS $$
	SELECT id_equipment FROM public."Equipment" 
$$;
 1   DROP FUNCTION public.select_all_equipments_id();
       public          postgres    false                       1255    33506    select_all_pets()    FUNCTION     �   CREATE FUNCTION public.select_all_pets() RETURNS TABLE(id_pet integer, kind_of_animal text, sex character, age text, animal_name text)
    LANGUAGE sql
    AS $$
	SELECT id_pet, kind_of_animal, sex, age, animal_name FROM public."Pet"
$$;
 (   DROP FUNCTION public.select_all_pets();
       public          postgres    false            }           0    0    FUNCTION select_all_pets()    ACL     ;   GRANT ALL ON FUNCTION public.select_all_pets() TO manager;
          public          postgres    false    260                       1255    33500    select_all_tasks()    FUNCTION     �  CREATE FUNCTION public.select_all_tasks() RETURNS TABLE(id_task integer, name_task text, description_task text, date_create date, date_deadline date, priority text, status boolean, date_end date, contract_id integer, emp_name text, manager_name text)
    LANGUAGE sql
    AS $$

	SELECT id_task, name_task, description_task, date_create, date_deadline, 
    priority, status, date_end, contract_id, emp_name, manager_name FROM public."Task"

$$;
 )   DROP FUNCTION public.select_all_tasks();
       public          postgres    false            ~           0    0    FUNCTION select_all_tasks()    ACL     w   GRANT ALL ON FUNCTION public.select_all_tasks() TO doctor;
GRANT ALL ON FUNCTION public.select_all_tasks() TO manager;
          public          postgres    false    261            �            1255    33507 *   select_clients_name_from_contract(integer)    FUNCTION     �   CREATE FUNCTION public.select_clients_name_from_contract(id_cl integer) RETURNS TABLE(name_client text)
    LANGUAGE sql
    AS $$
	SELECT name_client FROM public."Client" WHERE id_client = id_cl
$$;
 G   DROP FUNCTION public.select_clients_name_from_contract(id_cl integer);
       public          postgres    false                       0    0 9   FUNCTION select_clients_name_from_contract(id_cl integer)    ACL     Z   GRANT ALL ON FUNCTION public.select_clients_name_from_contract(id_cl integer) TO manager;
          public          postgres    false    255                       1255    33555     select_current_employee_id(text)    FUNCTION     �   CREATE FUNCTION public.select_current_employee_id(login text) RETURNS integer
    LANGUAGE sql
    AS $$
	SELECT id_employee FROM public."Employee" WHERE login_employee = login
$$;
 =   DROP FUNCTION public.select_current_employee_id(login text);
       public          postgres    false            �           0    0 /   FUNCTION select_current_employee_id(login text)    ACL     P   GRANT ALL ON FUNCTION public.select_current_employee_id(login text) TO manager;
          public          postgres    false    269                       1255    33554 W   select_current_task_id(text, text, date, date, character, boolean, integer, text, text)    FUNCTION     =  CREATE FUNCTION public.select_current_task_id(namet text, description text, datecreate date, deadline date, priorityt character, statust boolean, idcontract integer, employeename text, managername text) RETURNS integer
    LANGUAGE sql
    AS $$
	SELECT id_task FROM public."Task" WHERE name_task = nameT AND description_task = description
                AND date_create = dateCreate AND date_deadline = deadline AND priority = priorityT 
				AND status = statusT AND contract_id = idContract
                AND emp_name = employeeName AND manager_name = managerName
$$;
 �   DROP FUNCTION public.select_current_task_id(namet text, description text, datecreate date, deadline date, priorityt character, statust boolean, idcontract integer, employeename text, managername text);
       public          postgres    false            �           0    0 �   FUNCTION select_current_task_id(namet text, description text, datecreate date, deadline date, priorityt character, statust boolean, idcontract integer, employeename text, managername text)    ACL     �   GRANT ALL ON FUNCTION public.select_current_task_id(namet text, description text, datecreate date, deadline date, priorityt character, statust boolean, idcontract integer, employeename text, managername text) TO manager;
          public          postgres    false    268                       1255    33530    select_emp_logins()    FUNCTION     �   CREATE FUNCTION public.select_emp_logins() RETURNS TABLE(login text)
    LANGUAGE sql
    AS $$
	SELECT login_employee FROM public."Employee"
$$;
 *   DROP FUNCTION public.select_emp_logins();
       public          postgres    false            �           0    0    FUNCTION select_emp_logins()    ACL     =   GRANT ALL ON FUNCTION public.select_emp_logins() TO manager;
          public          postgres    false    262                       1255    33578    select_equipment(integer)    FUNCTION     )  CREATE FUNCTION public.select_equipment(id_e integer) RETURNS TABLE(id_equipment integer, name_equipment text, vendor_code text, type_equipment text)
    LANGUAGE sql
    AS $$
	SELECT id_equipment, name_equipment, vendor_code, type_equipment FROM public."Equipment" WHERE id_equipment = id_e
$$;
 5   DROP FUNCTION public.select_equipment(id_e integer);
       public          postgres    false                       1255    33489    select_id_clients()    FUNCTION     �   CREATE FUNCTION public.select_id_clients() RETURNS TABLE(a integer)
    LANGUAGE sql
    AS $$
  SELECT id_client FROM public."Client";
$$;
 *   DROP FUNCTION public.select_id_clients();
       public          postgres    false            �           0    0    FUNCTION select_id_clients()    ACL     =   GRANT ALL ON FUNCTION public.select_id_clients() TO manager;
          public          postgres    false    263            �            1255    33492    select_id_contracts()    FUNCTION     �   CREATE FUNCTION public.select_id_contracts() RETURNS TABLE(a integer)
    LANGUAGE sql
    AS $$
  SELECT id_contract FROM public."Contract"
$$;
 ,   DROP FUNCTION public.select_id_contracts();
       public          postgres    false            �           0    0    FUNCTION select_id_contracts()    ACL     ?   GRANT ALL ON FUNCTION public.select_id_contracts() TO manager;
          public          postgres    false    227                       1255    33490    select_id_pets()    FUNCTION     �   CREATE FUNCTION public.select_id_pets() RETURNS TABLE(a integer)
    LANGUAGE sql
    AS $$
  SELECT id_pet FROM public."Pet"
$$;
 '   DROP FUNCTION public.select_id_pets();
       public          postgres    false            �           0    0    FUNCTION select_id_pets()    ACL     :   GRANT ALL ON FUNCTION public.select_id_pets() TO manager;
          public          postgres    false    264            �            1255    33509 ,   select_kind_of_animal_from_contract(integer)    FUNCTION     �   CREATE FUNCTION public.select_kind_of_animal_from_contract(id_p integer) RETURNS TABLE(animal_name text)
    LANGUAGE sql
    AS $$
	SELECT kind_of_animal FROM public."Pet" WHERE id_pet = id_p
$$;
 H   DROP FUNCTION public.select_kind_of_animal_from_contract(id_p integer);
       public          postgres    false            �           0    0 :   FUNCTION select_kind_of_animal_from_contract(id_p integer)    ACL     [   GRANT ALL ON FUNCTION public.select_kind_of_animal_from_contract(id_p integer) TO manager;
          public          postgres    false    252            	           1255    33508 '   select_pets_name_from_contract(integer)    FUNCTION     �   CREATE FUNCTION public.select_pets_name_from_contract(id_p integer) RETURNS TABLE(animal_name text)
    LANGUAGE sql
    AS $$
	SELECT animal_name FROM public."Pet" WHERE id_pet = id_p
$$;
 C   DROP FUNCTION public.select_pets_name_from_contract(id_p integer);
       public          postgres    false            �           0    0 5   FUNCTION select_pets_name_from_contract(id_p integer)    ACL     V   GRANT ALL ON FUNCTION public.select_pets_name_from_contract(id_p integer) TO manager;
          public          postgres    false    265                       1255    33464 b   update_client(character varying, character varying, character varying, character varying, integer) 	   PROCEDURE     �  CREATE PROCEDURE public.update_client(IN nameclient character varying, IN phonenumber character varying, IN email character varying, IN address character varying, IN idclient integer)
    LANGUAGE sql
    AS $$
UPDATE public."Client" SET name_client = nameClient, phone_number_client = phoneNumber,
                 email_client = email, address = address WHERE id_client = idClient
$$;
 �   DROP PROCEDURE public.update_client(IN nameclient character varying, IN phonenumber character varying, IN email character varying, IN address character varying, IN idclient integer);
       public          postgres    false            �           0    0 �   PROCEDURE update_client(IN nameclient character varying, IN phonenumber character varying, IN email character varying, IN address character varying, IN idclient integer)    ACL     �   GRANT ALL ON PROCEDURE public.update_client(IN nameclient character varying, IN phonenumber character varying, IN email character varying, IN address character varying, IN idclient integer) TO manager;
          public          postgres    false    257            �            1255    33475 =   update_contract(character varying, integer, integer, integer) 	   PROCEDURE       CREATE PROCEDURE public.update_contract(IN descript character varying, IN clientid integer, IN petid integer, IN idc integer)
    LANGUAGE sql
    AS $$
    UPDATE public."Contract" SET description_contract = descript, id_client = clientId, 
	id_pet = petId WHERE id_contract = idC
$$;
 }   DROP PROCEDURE public.update_contract(IN descript character varying, IN clientid integer, IN petid integer, IN idc integer);
       public          postgres    false            �           0    0 o   PROCEDURE update_contract(IN descript character varying, IN clientid integer, IN petid integer, IN idc integer)    ACL     �   GRANT ALL ON PROCEDURE public.update_contract(IN descript character varying, IN clientid integer, IN petid integer, IN idc integer) TO manager;
          public          postgres    false    228                       1255    33576 H   update_equipment(character varying, integer, character varying, integer) 	   PROCEDURE     C  CREATE PROCEDURE public.update_equipment(IN name_e character varying, IN vendor_code integer, IN type_e character varying, IN id_e integer)
    LANGUAGE sql
    AS $$
    UPDATE public."Equipment" SET name_equipment = name_e, vendor_code = vendor_code, type_equipment = type_e
                WHERE id_equipment = id_e
$$;
 �   DROP PROCEDURE public.update_equipment(IN name_e character varying, IN vendor_code integer, IN type_e character varying, IN id_e integer);
       public          postgres    false            �            1255    33533 W   update_pet(character varying, character varying, character varying, character, integer) 	   PROCEDURE     5  CREATE PROCEDURE public.update_pet(IN namep character varying, IN kind character varying, IN age character varying, IN sex character, IN idp integer)
    LANGUAGE sql
    AS $$
    UPDATE public."Pet" SET animal_name = nameP, kind_of_animal = kind,
                age = age, sex = sex WHERE id_pet = idP
$$;
 �   DROP PROCEDURE public.update_pet(IN namep character varying, IN kind character varying, IN age character varying, IN sex character, IN idp integer);
       public          postgres    false            �           0    0 �   PROCEDURE update_pet(IN namep character varying, IN kind character varying, IN age character varying, IN sex character, IN idp integer)    ACL     �   GRANT ALL ON PROCEDURE public.update_pet(IN namep character varying, IN kind character varying, IN age character varying, IN sex character, IN idp integer) TO manager;
          public          postgres    false    251                       1255    33478 ~   update_task(character varying, character varying, date, character varying, boolean, integer, character varying, date, integer) 	   PROCEDURE       CREATE PROCEDURE public.update_task(IN namet character varying, IN description character varying, IN deadline date, IN priority character varying, IN status boolean, IN idcontract integer, IN employeename character varying, IN dateend date, IN idt integer)
    LANGUAGE sql
    AS $$
    UPDATE public."Task" SET name_task = nameT, description_task = description, 
	date_deadline = deadline, priority = priority, status = status, contract_id = idContract, 
	emp_name = employeeName, date_end = dateEnd WHERE id_task = idT
$$;
    DROP PROCEDURE public.update_task(IN namet character varying, IN description character varying, IN deadline date, IN priority character varying, IN status boolean, IN idcontract integer, IN employeename character varying, IN dateend date, IN idt integer);
       public          postgres    false            �           0    0 �   PROCEDURE update_task(IN namet character varying, IN description character varying, IN deadline date, IN priority character varying, IN status boolean, IN idcontract integer, IN employeename character varying, IN dateend date, IN idt integer)    ACL     %  GRANT ALL ON PROCEDURE public.update_task(IN namet character varying, IN description character varying, IN deadline date, IN priority character varying, IN status boolean, IN idcontract integer, IN employeename character varying, IN dateend date, IN idt integer) TO manager;
GRANT ALL ON PROCEDURE public.update_task(IN namet character varying, IN description character varying, IN deadline date, IN priority character varying, IN status boolean, IN idcontract integer, IN employeename character varying, IN dateend date, IN idt integer) TO doctor;
          public          postgres    false    258            �            1259    33375    Client    TABLE       CREATE TABLE public."Client" (
    id_client integer NOT NULL,
    phone_number_client character(11) NOT NULL,
    email_client character varying(30),
    address character varying(50),
    client_type character varying(15) NOT NULL,
    name_client character varying(30) NOT NULL
);
    DROP TABLE public."Client";
       public         heap    postgres    false            �           0    0    TABLE "Client"    COMMENT     k   COMMENT ON TABLE public."Client" IS 'Таблица для хранения данных клиента.';
          public          postgres    false    209            �           0    0    COLUMN "Client".id_client    COMMENT     �   COMMENT ON COLUMN public."Client".id_client IS 'Первичный ключ для идентификации клиента.';
          public          postgres    false    209            �           0    0 #   COLUMN "Client".phone_number_client    COMMENT     �   COMMENT ON COLUMN public."Client".phone_number_client IS 'Хранение информации о номере телефона клиента.';
          public          postgres    false    209            �           0    0    COLUMN "Client".email_client    COMMENT     y   COMMENT ON COLUMN public."Client".email_client IS 'Хранение информации о почте клиента.';
          public          postgres    false    209            �           0    0    COLUMN "Client".address    COMMENT     x   COMMENT ON COLUMN public."Client".address IS 'Хранение информации об адресе клиента.';
          public          postgres    false    209            �           0    0    COLUMN "Client".client_type    COMMENT     �   COMMENT ON COLUMN public."Client".client_type IS 'Хранение данных о типе клиента. (текущий/потенциальный)';
          public          postgres    false    209            �           0    0    COLUMN "Client".name_client    COMMENT     �   COMMENT ON COLUMN public."Client".name_client IS 'Хранение информации об имени клиента / названии организации.';
          public          postgres    false    209            �           0    0    TABLE "Client"    ACL     /   GRANT ALL ON TABLE public."Client" TO manager;
          public          postgres    false    209            �            1259    33378    Client_id_client_seq    SEQUENCE     �   ALTER TABLE public."Client" ALTER COLUMN id_client ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Client_id_client_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    209            �            1259    33379    Contract    TABLE     �   CREATE TABLE public."Contract" (
    id_contract integer NOT NULL,
    description_contract text NOT NULL,
    date_contract date NOT NULL,
    id_client integer NOT NULL,
    id_pet integer NOT NULL
);
    DROP TABLE public."Contract";
       public         heap    postgres    false            �           0    0    TABLE "Contract"    COMMENT     t   COMMENT ON TABLE public."Contract" IS 'Таблица для хранения данных о контракте.';
          public          postgres    false    211            �           0    0    COLUMN "Contract".id_contract    COMMENT     �   COMMENT ON COLUMN public."Contract".id_contract IS 'Первичный ключ для идентификации контракта.';
          public          postgres    false    211            �           0    0 &   COLUMN "Contract".description_contract    COMMENT     �   COMMENT ON COLUMN public."Contract".description_contract IS 'Хранение информации об описании котракта.';
          public          postgres    false    211            �           0    0    COLUMN "Contract".date_contract    COMMENT     �   COMMENT ON COLUMN public."Contract".date_contract IS 'Хранение информации о дате заключения контракта.';
          public          postgres    false    211            �           0    0    COLUMN "Contract".id_pet    COMMENT     �   COMMENT ON COLUMN public."Contract".id_pet IS 'Хранение информации о первичном ключе питомца.';
          public          postgres    false    211            �           0    0    TABLE "Contract"    ACL     d   GRANT ALL ON TABLE public."Contract" TO manager;
GRANT SELECT ON TABLE public."Contract" TO doctor;
          public          postgres    false    211            �            1259    33384    Contract_id_contract_seq    SEQUENCE     �   ALTER TABLE public."Contract" ALTER COLUMN id_contract ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Contract_id_contract_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    211            �            1259    33385 	   Equipment    TABLE     �   CREATE TABLE public."Equipment" (
    id_equipment integer NOT NULL,
    name_equipment character varying(20) NOT NULL,
    vendor_code integer NOT NULL,
    type_equipment character varying(20) NOT NULL
);
    DROP TABLE public."Equipment";
       public         heap    postgres    false            �           0    0    TABLE "Equipment"    COMMENT     �   COMMENT ON TABLE public."Equipment" IS 'Таблица для хранения данных о нужных комплектующих для определенной услуги.';
          public          postgres    false    213            �           0    0    COLUMN "Equipment".id_equipment    COMMENT     �   COMMENT ON COLUMN public."Equipment".id_equipment IS 'Первичный ключ для идентификации инструмента.';
          public          postgres    false    213            �           0    0 !   COLUMN "Equipment".name_equipment    COMMENT     �   COMMENT ON COLUMN public."Equipment".name_equipment IS 'Хранение информации о названии инструмента.';
          public          postgres    false    213            �           0    0    COLUMN "Equipment".vendor_code    COMMENT     �   COMMENT ON COLUMN public."Equipment".vendor_code IS 'Хранение информации об артикуле инструмента.';
          public          postgres    false    213            �           0    0    TABLE "Equipment"    ACL     t   GRANT ALL ON TABLE public."Equipment" TO manager;
GRANT SELECT,INSERT,UPDATE ON TABLE public."Equipment" TO doctor;
          public          postgres    false    213            �            1259    33388    Detail_id_detail_seq    SEQUENCE     �   ALTER TABLE public."Equipment" ALTER COLUMN id_equipment ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Detail_id_detail_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    213            �            1259    33389    Employee    TABLE     9  CREATE TABLE public."Employee" (
    id_employee integer NOT NULL,
    name_employee character varying(30) NOT NULL,
    phone_number_employee character(11) NOT NULL,
    email_employee character varying(30) NOT NULL,
    title character varying(20) NOT NULL,
    login_employee character varying(10) NOT NULL
);
    DROP TABLE public."Employee";
       public         heap    postgres    false            �           0    0    TABLE "Employee"    COMMENT     t   COMMENT ON TABLE public."Employee" IS 'Таблица для хранения данных сотрудника.
';
          public          postgres    false    215            �           0    0    COLUMN "Employee".id_employee    COMMENT     �   COMMENT ON COLUMN public."Employee".id_employee IS 'Первичный ключ для идентификации сотрудника.';
          public          postgres    false    215            �           0    0    COLUMN "Employee".name_employee    COMMENT     �   COMMENT ON COLUMN public."Employee".name_employee IS 'Хранение информации об имени сотрудника.';
          public          postgres    false    215            �           0    0 '   COLUMN "Employee".phone_number_employee    COMMENT     �   COMMENT ON COLUMN public."Employee".phone_number_employee IS 'Хранение информации о номере телефона сотрудника.';
          public          postgres    false    215            �           0    0     COLUMN "Employee".email_employee    COMMENT     �   COMMENT ON COLUMN public."Employee".email_employee IS 'Хранение информации о почте сотрудника.';
          public          postgres    false    215            �           0    0    COLUMN "Employee".title    COMMENT     �   COMMENT ON COLUMN public."Employee".title IS 'Хранение информации о должности сотрудника.';
          public          postgres    false    215            �           0    0    TABLE "Employee"    ACL     k   GRANT ALL ON TABLE public."Employee" TO manager;
GRANT SELECT,UPDATE ON TABLE public."Employee" TO doctor;
          public          postgres    false    215            �            1259    33392    Employee_Task    TABLE     �   CREATE TABLE public."Employee_Task" (
    "Employee_id_employee" integer NOT NULL,
    "Task_id_task" integer NOT NULL,
    "position" character(1) NOT NULL
);
 #   DROP TABLE public."Employee_Task";
       public         heap    postgres    false            �           0    0 -   COLUMN "Employee_Task"."Employee_id_employee"    COMMENT     �   COMMENT ON COLUMN public."Employee_Task"."Employee_id_employee" IS 'Первичный ключ для идентификации сотрудника.';
          public          postgres    false    216            �           0    0 %   COLUMN "Employee_Task"."Task_id_task"    COMMENT     �   COMMENT ON COLUMN public."Employee_Task"."Task_id_task" IS 'Первичный ключ для идентификации задания.';
          public          postgres    false    216            �           0    0 !   COLUMN "Employee_Task"."position"    COMMENT     �   COMMENT ON COLUMN public."Employee_Task"."position" IS 'Позиция сотрудника (А - автор, И - исполнитель)';
          public          postgres    false    216            �           0    0    TABLE "Employee_Task"    ACL     n   GRANT ALL ON TABLE public."Employee_Task" TO manager;
GRANT INSERT ON TABLE public."Employee_Task" TO doctor;
          public          postgres    false    216            �            1259    33395    Employee_id_employee_seq    SEQUENCE     �   ALTER TABLE public."Employee" ALTER COLUMN id_employee ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Employee_id_employee_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    215            �            1259    33396    Pet    TABLE     �   CREATE TABLE public."Pet" (
    id_pet integer NOT NULL,
    kind_of_animal character varying(20) NOT NULL,
    sex character(1) NOT NULL,
    age character(2) NOT NULL,
    animal_name character(20) NOT NULL
);
    DROP TABLE public."Pet";
       public         heap    postgres    false            �           0    0    TABLE "Pet"    COMMENT     s   COMMENT ON TABLE public."Pet" IS 'Таблица для хранения информации о питомце.';
          public          postgres    false    218            �           0    0    COLUMN "Pet".id_pet    COMMENT     �   COMMENT ON COLUMN public."Pet".id_pet IS 'Хранение информации о первичном ключе питомца.';
          public          postgres    false    218            �           0    0    COLUMN "Pet".kind_of_animal    COMMENT     z   COMMENT ON COLUMN public."Pet".kind_of_animal IS 'Хранение информации о виде животного.';
          public          postgres    false    218            �           0    0    COLUMN "Pet".sex    COMMENT     �   COMMENT ON COLUMN public."Pet".sex IS 'Хранение информации о поле животного (М - мальчик, Д - девочка).';
          public          postgres    false    218            �           0    0    COLUMN "Pet".age    COMMENT     s   COMMENT ON COLUMN public."Pet".age IS 'Хранение информации о возрасте питомца.';
          public          postgres    false    218            �           0    0    COLUMN "Pet".animal_name    COMMENT     w   COMMENT ON COLUMN public."Pet".animal_name IS 'Хранение информации об имени питомца.';
          public          postgres    false    218            �           0    0    TABLE "Pet"    ACL     Z   GRANT ALL ON TABLE public."Pet" TO manager;
GRANT SELECT ON TABLE public."Pet" TO doctor;
          public          postgres    false    218            �            1259    33399    Pet_id_pet_seq    SEQUENCE     �   ALTER TABLE public."Pet" ALTER COLUMN id_pet ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Pet_id_pet_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
    CYCLE
);
            public          postgres    false    218            �            1259    33400    Task    TABLE     �  CREATE TABLE public."Task" (
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
    priority "char" NOT NULL
);
    DROP TABLE public."Task";
       public         heap    postgres    false            �           0    0    TABLE "Task"    COMMENT        COMMENT ON TABLE public."Task" IS 'Таблица для хранения данных о конкретной услуге.';
          public          postgres    false    220            �           0    0    COLUMN "Task".id_task    COMMENT     |   COMMENT ON COLUMN public."Task".id_task IS 'Первичный ключ для идентификации задания.';
          public          postgres    false    220            �           0    0    COLUMN "Task".name_task    COMMENT     z   COMMENT ON COLUMN public."Task".name_task IS 'Хранение информации о названии задания.';
          public          postgres    false    220            �           0    0    COLUMN "Task".description_task    COMMENT     �   COMMENT ON COLUMN public."Task".description_task IS 'Хранение информации об описании задания.';
          public          postgres    false    220            �           0    0    COLUMN "Task".date_create    COMMENT     �   COMMENT ON COLUMN public."Task".date_create IS 'Хранение информации о дате создания задания.';
          public          postgres    false    220            �           0    0    COLUMN "Task".date_deadline    COMMENT     ~   COMMENT ON COLUMN public."Task".date_deadline IS 'Хранение информации о дедлайне задания.';
          public          postgres    false    220            �           0    0    COLUMN "Task".date_end    COMMENT     �   COMMENT ON COLUMN public."Task".date_end IS 'Хранение информации о дате завершения задания.';
          public          postgres    false    220            �           0    0    COLUMN "Task".status    COMMENT     �   COMMENT ON COLUMN public."Task".status IS 'Хранение информации о статусе задания. (0 - в работе, 1 - завершено)';
          public          postgres    false    220            �           0    0    COLUMN "Task".contract_id    COMMENT     |   COMMENT ON COLUMN public."Task".contract_id IS 'Хранение информации о номере контракта.';
          public          postgres    false    220            �           0    0    COLUMN "Task".priority    COMMENT     |   COMMENT ON COLUMN public."Task".priority IS 'Хранение информации о приоритете задания';
          public          postgres    false    220            �           0    0    TABLE "Task"    ACL     k   GRANT ALL ON TABLE public."Task" TO manager;
GRANT SELECT,TRIGGER,UPDATE ON TABLE public."Task" TO doctor;
          public          postgres    false    220            �            1259    33405    Task_Equipment    TABLE     }   CREATE TABLE public."Task_Equipment" (
    "Task_id_task" integer NOT NULL,
    "Equipment_id_equipment" integer NOT NULL
);
 $   DROP TABLE public."Task_Equipment";
       public         heap    postgres    false            �           0    0 &   COLUMN "Task_Equipment"."Task_id_task"    COMMENT     �   COMMENT ON COLUMN public."Task_Equipment"."Task_id_task" IS 'Первичный ключ для идентификации задания.';
          public          postgres    false    221            �           0    0 0   COLUMN "Task_Equipment"."Equipment_id_equipment"    COMMENT     �   COMMENT ON COLUMN public."Task_Equipment"."Equipment_id_equipment" IS 'Первичный ключ для идентификации инструмента.';
          public          postgres    false    221            �           0    0    TABLE "Task_Equipment"    ACL     ~   GRANT ALL ON TABLE public."Task_Equipment" TO manager;
GRANT SELECT,INSERT,UPDATE ON TABLE public."Task_Equipment" TO doctor;
          public          postgres    false    221            �            1259    33408    Task_id_task_seq    SEQUENCE     �   ALTER TABLE public."Task" ALTER COLUMN id_task ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Task_id_task_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    220            �            1259    33582 
   allClients    VIEW     Y  CREATE VIEW public."allClients" AS
 SELECT select_all_clients.id_client,
    select_all_clients.name_client,
    select_all_clients.phone_number_client,
    select_all_clients.email_client,
    select_all_clients.address
   FROM public.select_all_clients() select_all_clients(id_client, name_client, phone_number_client, email_client, address);
    DROP VIEW public."allClients";
       public          postgres    false    277            �           0    0    TABLE "allClients"    ACL     3   GRANT ALL ON TABLE public."allClients" TO manager;
          public          postgres    false    224            �            1259    33571    allPets    VIEW       CREATE VIEW public."allPets" AS
 SELECT select_all_pets.id_pet,
    select_all_pets.kind_of_animal,
    select_all_pets.sex,
    select_all_pets.age,
    select_all_pets.animal_name
   FROM public.select_all_pets() select_all_pets(id_pet, kind_of_animal, sex, age, animal_name);
    DROP VIEW public."allPets";
       public          postgres    false    260            �           0    0    TABLE "allPets"    ACL     0   GRANT ALL ON TABLE public."allPets" TO manager;
          public          postgres    false    223            W          0    33375    Client 
   TABLE DATA           s   COPY public."Client" (id_client, phone_number_client, email_client, address, client_type, name_client) FROM stdin;
    public          postgres    false    209   �      Y          0    33379    Contract 
   TABLE DATA           i   COPY public."Contract" (id_contract, description_contract, date_contract, id_client, id_pet) FROM stdin;
    public          postgres    false    211   �      ]          0    33389    Employee 
   TABLE DATA           ~   COPY public."Employee" (id_employee, name_employee, phone_number_employee, email_employee, title, login_employee) FROM stdin;
    public          postgres    false    215   �      ^          0    33392    Employee_Task 
   TABLE DATA           ]   COPY public."Employee_Task" ("Employee_id_employee", "Task_id_task", "position") FROM stdin;
    public          postgres    false    216   g      [          0    33385 	   Equipment 
   TABLE DATA           `   COPY public."Equipment" (id_equipment, name_equipment, vendor_code, type_equipment) FROM stdin;
    public          postgres    false    213   �      `          0    33396    Pet 
   TABLE DATA           N   COPY public."Pet" (id_pet, kind_of_animal, sex, age, animal_name) FROM stdin;
    public          postgres    false    218   �      b          0    33400    Task 
   TABLE DATA           �   COPY public."Task" (id_task, name_task, description_task, date_create, date_deadline, date_end, status, contract_id, emp_name, manager_name, priority) FROM stdin;
    public          postgres    false    220   �      c          0    33405    Task_Equipment 
   TABLE DATA           T   COPY public."Task_Equipment" ("Task_id_task", "Equipment_id_equipment") FROM stdin;
    public          postgres    false    221         �           0    0    Client_id_client_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."Client_id_client_seq"', 7, true);
          public          postgres    false    210            �           0    0    Contract_id_contract_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public."Contract_id_contract_seq"', 10, true);
          public          postgres    false    212            �           0    0    Detail_id_detail_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."Detail_id_detail_seq"', 19, true);
          public          postgres    false    214            �           0    0    Employee_id_employee_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public."Employee_id_employee_seq"', 10, true);
          public          postgres    false    217            �           0    0    Pet_id_pet_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public."Pet_id_pet_seq"', 6, true);
          public          postgres    false    219            �           0    0    Task_id_task_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."Task_id_task_seq"', 35, true);
          public          postgres    false    222            �           2606    33410    Client Client_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public."Client"
    ADD CONSTRAINT "Client_pkey" PRIMARY KEY (id_client);
 @   ALTER TABLE ONLY public."Client" DROP CONSTRAINT "Client_pkey";
       public            postgres    false    209            �           2606    33412    Contract Contract_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public."Contract"
    ADD CONSTRAINT "Contract_pkey" PRIMARY KEY (id_contract);
 D   ALTER TABLE ONLY public."Contract" DROP CONSTRAINT "Contract_pkey";
       public            postgres    false    211            �           2606    33414    Equipment Detail_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public."Equipment"
    ADD CONSTRAINT "Detail_pkey" PRIMARY KEY (id_equipment);
 C   ALTER TABLE ONLY public."Equipment" DROP CONSTRAINT "Detail_pkey";
       public            postgres    false    213            �           2606    33416    Employee Employee_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public."Employee"
    ADD CONSTRAINT "Employee_pkey" PRIMARY KEY (id_employee);
 D   ALTER TABLE ONLY public."Employee" DROP CONSTRAINT "Employee_pkey";
       public            postgres    false    215            �           2606    33418    Pet Pet_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public."Pet"
    ADD CONSTRAINT "Pet_pkey" PRIMARY KEY (id_pet);
 :   ALTER TABLE ONLY public."Pet" DROP CONSTRAINT "Pet_pkey";
       public            postgres    false    218            �           2606    33420    Task Task_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public."Task"
    ADD CONSTRAINT "Task_pkey" PRIMARY KEY (id_task);
 <   ALTER TABLE ONLY public."Task" DROP CONSTRAINT "Task_pkey";
       public            postgres    false    220            �           1259    33421    detail_index    INDEX     l   CREATE UNIQUE INDEX detail_index ON public."Equipment" USING btree (id_equipment) INCLUDE (name_equipment);
     DROP INDEX public.detail_index;
       public            postgres    false    213    213            �           1259    33422    employee_index    INDEX     l   CREATE UNIQUE INDEX employee_index ON public."Employee" USING btree (id_employee) INCLUDE (email_employee);
 "   DROP INDEX public.employee_index;
       public            postgres    false    215    215            �           1259    33423 
   task_index    INDEX     [   CREATE UNIQUE INDEX task_index ON public."Task" USING btree (id_task) INCLUDE (name_task);
    DROP INDEX public.task_index;
       public            postgres    false    220    220            �           2620    33424    Task emp_stamp    TRIGGER     u   CREATE TRIGGER emp_stamp AFTER INSERT OR UPDATE ON public."Task" FOR EACH ROW EXECUTE FUNCTION public.delete_data();
 )   DROP TRIGGER emp_stamp ON public."Task";
       public          postgres    false    226    220            �           2606    33425 5   Employee_Task Employee_Task_Employee_id_employee_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Employee_Task"
    ADD CONSTRAINT "Employee_Task_Employee_id_employee_fkey" FOREIGN KEY ("Employee_id_employee") REFERENCES public."Employee"(id_employee) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 c   ALTER TABLE ONLY public."Employee_Task" DROP CONSTRAINT "Employee_Task_Employee_id_employee_fkey";
       public          postgres    false    3255    215    216            �           2606    33430 -   Employee_Task Employee_Task_Task_id_task_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Employee_Task"
    ADD CONSTRAINT "Employee_Task_Task_id_task_fkey" FOREIGN KEY ("Task_id_task") REFERENCES public."Task"(id_task) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 [   ALTER TABLE ONLY public."Employee_Task" DROP CONSTRAINT "Employee_Task_Task_id_task_fkey";
       public          postgres    false    220    3260    216            �           2606    33435 9   Task_Equipment Task_Equipment_Equipment_id_Equipment_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Task_Equipment"
    ADD CONSTRAINT "Task_Equipment_Equipment_id_Equipment_fkey" FOREIGN KEY ("Equipment_id_equipment") REFERENCES public."Equipment"(id_equipment) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 g   ALTER TABLE ONLY public."Task_Equipment" DROP CONSTRAINT "Task_Equipment_Equipment_id_Equipment_fkey";
       public          postgres    false    213    3252    221            �           2606    33440 /   Task_Equipment Task_Equipment_Task_id_task_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Task_Equipment"
    ADD CONSTRAINT "Task_Equipment_Task_id_task_fkey" FOREIGN KEY ("Task_id_task") REFERENCES public."Task"(id_task) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 ]   ALTER TABLE ONLY public."Task_Equipment" DROP CONSTRAINT "Task_Equipment_Task_id_task_fkey";
       public          postgres    false    3260    220    221            �           2606    33445    Contract client_id    FK CONSTRAINT     �   ALTER TABLE ONLY public."Contract"
    ADD CONSTRAINT client_id FOREIGN KEY (id_client) REFERENCES public."Client"(id_client) NOT VALID;
 >   ALTER TABLE ONLY public."Contract" DROP CONSTRAINT client_id;
       public          postgres    false    211    3248    209            �           2606    33450    Task contract_id    FK CONSTRAINT     �   ALTER TABLE ONLY public."Task"
    ADD CONSTRAINT contract_id FOREIGN KEY (contract_id) REFERENCES public."Contract"(id_contract) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 <   ALTER TABLE ONLY public."Task" DROP CONSTRAINT contract_id;
       public          postgres    false    220    211    3250            �           2606    33455    Contract pet_id    FK CONSTRAINT     }   ALTER TABLE ONLY public."Contract"
    ADD CONSTRAINT pet_id FOREIGN KEY (id_pet) REFERENCES public."Pet"(id_pet) NOT VALID;
 ;   ALTER TABLE ONLY public."Contract" DROP CONSTRAINT pet_id;
       public          postgres    false    218    3258    211            S           0    33400    Task    ROW SECURITY     4   ALTER TABLE public."Task" ENABLE ROW LEVEL SECURITY;          public          postgres    false    220            T           3256    33460    Task info_manager    POLICY     �   CREATE POLICY info_manager ON public."Task" USING (('manager'::text = (( SELECT "Employee".title
   FROM public."Employee"
  WHERE (("Employee".login_employee)::text = CURRENT_USER)))::text));
 +   DROP POLICY info_manager ON public."Task";
       public          postgres    false    215    220    215            U           3256    33461    Task select_info_doctor    POLICY     r   CREATE POLICY select_info_doctor ON public."Task" FOR SELECT TO doctor USING ((CURRENT_USER = (emp_name)::text));
 1   DROP POLICY select_info_doctor ON public."Task";
       public          postgres    false    220    220            V           3256    33462    Task update_info_doctor    POLICY     r   CREATE POLICY update_info_doctor ON public."Task" FOR UPDATE TO doctor USING ((CURRENT_USER = (emp_name)::text));
 1   DROP POLICY update_info_doctor ON public."Task";
       public          postgres    false    220    220            W      x������ � �      Y      x������ � �      ]   �   x���0����.��~aׅ�*\��wa������������	gNbqI~rFvf�CIjq�^r~.gnb^bzj��%���^l��pa߅M
f�]�
2��h����!gAjIQ~����"�0W� ,y<U      ^      x������ � �      [      x������ � �      `   F   x�3估�¾�@r�)��
��\l�� P@\F�/컰����9�@��B;.�BW���� �Q'�      b      x������ � �      c      x������ � �     