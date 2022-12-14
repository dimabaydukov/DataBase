PGDMP         0            
    z            Company    14.5    14.5 ^    ,           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            -           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            .           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            /           1262    17030    Company    DATABASE     f   CREATE DATABASE "Company" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE "Company";
                postgres    false            ?            1255    17031    create_report() 	   PROCEDURE     ?   CREATE PROCEDURE public.create_report()
    LANGUAGE sql
    AS $$COPY "Task"(name_task, description_task, date_create, date_deadline, priority, date_end, status)
TO 'D:\GitHub\DataBase\save.json'
DELIMITER ','
CSV HEADER;$$;
 '   DROP PROCEDURE public.create_report();
       public          postgres    false            ?            1255    17032    delete_data()    FUNCTION     ?   CREATE FUNCTION public.delete_data() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM "Task" WHERE (CURRENT_DATE - date_end) >= 365;
    RETURN NULL;
END;
$$;
 $   DROP FUNCTION public.delete_data();
       public          postgres    false            0           0    0    FUNCTION delete_data()    ACL     p   GRANT ALL ON FUNCTION public.delete_data() TO manager;
GRANT ALL ON FUNCTION public.delete_data() TO tech_spec;
          public          postgres    false    223            ?            1255    17033 	   to_json() 	   PROCEDURE     ?   CREATE PROCEDURE public.to_json()
    LANGUAGE sql
    AS $$COPY ( SELECT array_to_json(array_agg(row_to_json(t)))
from "Task" 
t
) TO 'D:\GitHub\DataBase\save.json';$$;
 !   DROP PROCEDURE public.to_json();
       public          postgres    false            ?            1259    17034    Client    TABLE       CREATE TABLE public."Client" (
    id_client integer NOT NULL,
    phone_number_client character(11) NOT NULL,
    email_client character varying(30),
    address character varying(50),
    client_type character varying(15) NOT NULL,
    name_client character varying(30) NOT NULL
);
    DROP TABLE public."Client";
       public         heap    postgres    false            1           0    0    TABLE "Client"    COMMENT     k   COMMENT ON TABLE public."Client" IS 'Таблица для хранения данных клиента.';
          public          postgres    false    209            2           0    0    COLUMN "Client".id_client    COMMENT     ?   COMMENT ON COLUMN public."Client".id_client IS 'Первичный ключ для идентификации клиента.';
          public          postgres    false    209            3           0    0 #   COLUMN "Client".phone_number_client    COMMENT     ?   COMMENT ON COLUMN public."Client".phone_number_client IS 'Хранение информации о номере телефона клиента.';
          public          postgres    false    209            4           0    0    COLUMN "Client".email_client    COMMENT     y   COMMENT ON COLUMN public."Client".email_client IS 'Хранение информации о почте клиента.';
          public          postgres    false    209            5           0    0    COLUMN "Client".address    COMMENT     x   COMMENT ON COLUMN public."Client".address IS 'Хранение информации об адресе клиента.';
          public          postgres    false    209            6           0    0    COLUMN "Client".client_type    COMMENT     ?   COMMENT ON COLUMN public."Client".client_type IS 'Хранение данных о типе клиента. (частное лицо/организация, текущий/потенциальный)';
          public          postgres    false    209            7           0    0    COLUMN "Client".name_client    COMMENT     ?   COMMENT ON COLUMN public."Client".name_client IS 'Хранение информации об имени клиента / названии организации.';
          public          postgres    false    209            8           0    0    TABLE "Client"    ACL     /   GRANT ALL ON TABLE public."Client" TO manager;
          public          postgres    false    209            ?            1259    17037    Client_id_client_seq    SEQUENCE     ?   ALTER TABLE public."Client" ALTER COLUMN id_client ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Client_id_client_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    209            ?            1259    17038    Contract    TABLE     ?   CREATE TABLE public."Contract" (
    id_contract integer NOT NULL,
    description_contract text NOT NULL,
    date_contract date NOT NULL,
    id_client integer NOT NULL
);
    DROP TABLE public."Contract";
       public         heap    postgres    false            9           0    0    TABLE "Contract"    COMMENT     t   COMMENT ON TABLE public."Contract" IS 'Таблица для хранения данных о контракте.';
          public          postgres    false    211            :           0    0    COLUMN "Contract".id_contract    COMMENT     ?   COMMENT ON COLUMN public."Contract".id_contract IS 'Первичный ключ для идентификации контракта.';
          public          postgres    false    211            ;           0    0 &   COLUMN "Contract".description_contract    COMMENT     ?   COMMENT ON COLUMN public."Contract".description_contract IS 'Хранение информации об описании котракта.';
          public          postgres    false    211            <           0    0    COLUMN "Contract".date_contract    COMMENT     ?   COMMENT ON COLUMN public."Contract".date_contract IS 'Хранение информации о дате заключения контракта.';
          public          postgres    false    211            =           0    0    TABLE "Contract"    ACL     g   GRANT ALL ON TABLE public."Contract" TO manager;
GRANT SELECT ON TABLE public."Contract" TO tech_spec;
          public          postgres    false    211            ?            1259    17043    Contract_id_contract_seq    SEQUENCE     ?   ALTER TABLE public."Contract" ALTER COLUMN id_contract ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Contract_id_contract_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    211            ?            1259    17044    Detail    TABLE     ?   CREATE TABLE public."Detail" (
    id_detail integer NOT NULL,
    name_detail character varying(20) NOT NULL,
    serial_number character varying(50) NOT NULL
);
    DROP TABLE public."Detail";
       public         heap    postgres    false            >           0    0    TABLE "Detail"    COMMENT     ?   COMMENT ON TABLE public."Detail" IS 'Таблица для хранения данных о нужных комплектующих для определенной услуги.';
          public          postgres    false    213            ?           0    0    COLUMN "Detail".id_detail    COMMENT     ~   COMMENT ON COLUMN public."Detail".id_detail IS 'Первичный ключ для идентификации детали.';
          public          postgres    false    213            @           0    0    COLUMN "Detail".name_detail    COMMENT     |   COMMENT ON COLUMN public."Detail".name_detail IS 'Хранение информации о названии детали.';
          public          postgres    false    213            A           0    0    COLUMN "Detail".serial_number    COMMENT     ?   COMMENT ON COLUMN public."Detail".serial_number IS 'Хранение информации о серийном номере детали.';
          public          postgres    false    213            B           0    0    TABLE "Detail"    ACL     q   GRANT ALL ON TABLE public."Detail" TO manager;
GRANT SELECT,INSERT,UPDATE ON TABLE public."Detail" TO tech_spec;
          public          postgres    false    213            ?            1259    17047    Detail_id_detail_seq    SEQUENCE     ?   ALTER TABLE public."Detail" ALTER COLUMN id_detail ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Detail_id_detail_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    213            ?            1259    17048    Employee    TABLE     9  CREATE TABLE public."Employee" (
    id_employee integer NOT NULL,
    name_employee character varying(30) NOT NULL,
    phone_number_employee character(11) NOT NULL,
    email_employee character varying(30) NOT NULL,
    title character varying(20) NOT NULL,
    login_employee character varying(10) NOT NULL
);
    DROP TABLE public."Employee";
       public         heap    postgres    false            C           0    0    TABLE "Employee"    COMMENT     t   COMMENT ON TABLE public."Employee" IS 'Таблица для хранения данных сотрудника.
';
          public          postgres    false    215            D           0    0    COLUMN "Employee".id_employee    COMMENT     ?   COMMENT ON COLUMN public."Employee".id_employee IS 'Первичный ключ для идентификации сотрудника.';
          public          postgres    false    215            E           0    0    COLUMN "Employee".name_employee    COMMENT     ?   COMMENT ON COLUMN public."Employee".name_employee IS 'Хранение информации об имени сотрудника.';
          public          postgres    false    215            F           0    0 '   COLUMN "Employee".phone_number_employee    COMMENT     ?   COMMENT ON COLUMN public."Employee".phone_number_employee IS 'Хранение информации о номере телефона сотрудника.';
          public          postgres    false    215            G           0    0     COLUMN "Employee".email_employee    COMMENT     ?   COMMENT ON COLUMN public."Employee".email_employee IS 'Хранение информации о почте сотрудника.';
          public          postgres    false    215            H           0    0    COLUMN "Employee".title    COMMENT     ?   COMMENT ON COLUMN public."Employee".title IS 'Хранение информации о должности сотрудника.';
          public          postgres    false    215            I           0    0    TABLE "Employee"    ACL     u   GRANT ALL ON TABLE public."Employee" TO manager;
GRANT SELECT,INSERT,UPDATE ON TABLE public."Employee" TO tech_spec;
          public          postgres    false    215            ?            1259    17051    Employee_Task    TABLE     ?   CREATE TABLE public."Employee_Task" (
    "Employee_id_employee" integer NOT NULL,
    "Task_id_task" integer NOT NULL,
    "position" character(1) NOT NULL
);
 #   DROP TABLE public."Employee_Task";
       public         heap    postgres    false            J           0    0 -   COLUMN "Employee_Task"."Employee_id_employee"    COMMENT     ?   COMMENT ON COLUMN public."Employee_Task"."Employee_id_employee" IS 'Первичный ключ для идентификации сотрудника.';
          public          postgres    false    216            K           0    0 %   COLUMN "Employee_Task"."Task_id_task"    COMMENT     ?   COMMENT ON COLUMN public."Employee_Task"."Task_id_task" IS 'Первичный ключ для идентификации задания.';
          public          postgres    false    216            L           0    0 !   COLUMN "Employee_Task"."position"    COMMENT     ?   COMMENT ON COLUMN public."Employee_Task"."position" IS 'Позиция сотрудника (А - автор, И - исполнитель)';
          public          postgres    false    216            M           0    0    TABLE "Employee_Task"    ACL     6   GRANT ALL ON TABLE public."Employee_Task" TO manager;
          public          postgres    false    216            ?            1259    17054    Employee_id_employee_seq    SEQUENCE     ?   ALTER TABLE public."Employee" ALTER COLUMN id_employee ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Employee_id_employee_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    215            ?            1259    17055    Task    TABLE     ?  CREATE TABLE public."Task" (
    id_task integer NOT NULL,
    name_task character varying(30) NOT NULL,
    description_task text,
    date_create date NOT NULL,
    date_deadline date NOT NULL,
    priority character(1) NOT NULL,
    date_end date,
    status boolean NOT NULL,
    contract_id integer,
    emp_name character varying(10),
    manager_name character varying(10) NOT NULL
);
    DROP TABLE public."Task";
       public         heap    postgres    false            N           0    0    TABLE "Task"    COMMENT        COMMENT ON TABLE public."Task" IS 'Таблица для хранения данных о конкретной услуге.';
          public          postgres    false    218            O           0    0    COLUMN "Task".id_task    COMMENT     |   COMMENT ON COLUMN public."Task".id_task IS 'Первичный ключ для идентификации задания.';
          public          postgres    false    218            P           0    0    COLUMN "Task".name_task    COMMENT     z   COMMENT ON COLUMN public."Task".name_task IS 'Хранение информации о названии задания.';
          public          postgres    false    218            Q           0    0    COLUMN "Task".description_task    COMMENT     ?   COMMENT ON COLUMN public."Task".description_task IS 'Хранение информации об описании задания.';
          public          postgres    false    218            R           0    0    COLUMN "Task".date_create    COMMENT     ?   COMMENT ON COLUMN public."Task".date_create IS 'Хранение информации о дате создания задания.';
          public          postgres    false    218            S           0    0    COLUMN "Task".date_deadline    COMMENT     ~   COMMENT ON COLUMN public."Task".date_deadline IS 'Хранение информации о дедлайне задания.';
          public          postgres    false    218            T           0    0    COLUMN "Task".priority    COMMENT     ?   COMMENT ON COLUMN public."Task".priority IS 'Хранение информации о приоритете задания. (1 - высокий, 2 - средний, 3 - низкий)';
          public          postgres    false    218            U           0    0    COLUMN "Task".date_end    COMMENT     ?   COMMENT ON COLUMN public."Task".date_end IS 'Хранение информации о дате завершения задания.';
          public          postgres    false    218            V           0    0    COLUMN "Task".status    COMMENT     ?   COMMENT ON COLUMN public."Task".status IS 'Хранение информации о статусе задания. (0 - в работе, 1 - завершено)';
          public          postgres    false    218            W           0    0    COLUMN "Task".contract_id    COMMENT     |   COMMENT ON COLUMN public."Task".contract_id IS 'Хранение информации о номере контракта.';
          public          postgres    false    218            X           0    0    TABLE "Task"    ACL     n   GRANT ALL ON TABLE public."Task" TO manager;
GRANT SELECT,TRIGGER,UPDATE ON TABLE public."Task" TO tech_spec;
          public          postgres    false    218            ?            1259    17060    Task_Detail    TABLE     t   CREATE TABLE public."Task_Detail" (
    "Task_id_task" integer NOT NULL,
    "Detail_id_detail" integer NOT NULL
);
 !   DROP TABLE public."Task_Detail";
       public         heap    postgres    false            Y           0    0 #   COLUMN "Task_Detail"."Task_id_task"    COMMENT     ?   COMMENT ON COLUMN public."Task_Detail"."Task_id_task" IS 'Первичный ключ для идентификации задания.';
          public          postgres    false    219            Z           0    0 '   COLUMN "Task_Detail"."Detail_id_detail"    COMMENT     ?   COMMENT ON COLUMN public."Task_Detail"."Detail_id_detail" IS 'Первичный ключ для идентификации детали.';
          public          postgres    false    219            [           0    0    TABLE "Task_Detail"    ACL     {   GRANT ALL ON TABLE public."Task_Detail" TO manager;
GRANT SELECT,INSERT,UPDATE ON TABLE public."Task_Detail" TO tech_spec;
          public          postgres    false    219            ?            1259    17063    Task_id_task_seq    SEQUENCE     ?   ALTER TABLE public."Task" ALTER COLUMN id_task ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Task_id_task_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    218                      0    17034    Client 
   TABLE DATA           s   COPY public."Client" (id_client, phone_number_client, email_client, address, client_type, name_client) FROM stdin;
    public          postgres    false    209   ?n                  0    17038    Contract 
   TABLE DATA           a   COPY public."Contract" (id_contract, description_contract, date_contract, id_client) FROM stdin;
    public          postgres    false    211   ?o       "          0    17044    Detail 
   TABLE DATA           I   COPY public."Detail" (id_detail, name_detail, serial_number) FROM stdin;
    public          postgres    false    213   ?o       $          0    17048    Employee 
   TABLE DATA           ~   COPY public."Employee" (id_employee, name_employee, phone_number_employee, email_employee, title, login_employee) FROM stdin;
    public          postgres    false    215   Pp       %          0    17051    Employee_Task 
   TABLE DATA           ]   COPY public."Employee_Task" ("Employee_id_employee", "Task_id_task", "position") FROM stdin;
    public          postgres    false    216   ?p       '          0    17055    Task 
   TABLE DATA           ?   COPY public."Task" (id_task, name_task, description_task, date_create, date_deadline, priority, date_end, status, contract_id, emp_name, manager_name) FROM stdin;
    public          postgres    false    218   q       (          0    17060    Task_Detail 
   TABLE DATA           K   COPY public."Task_Detail" ("Task_id_task", "Detail_id_detail") FROM stdin;
    public          postgres    false    219   ?q       \           0    0    Client_id_client_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."Client_id_client_seq"', 5, true);
          public          postgres    false    210            ]           0    0    Contract_id_contract_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."Contract_id_contract_seq"', 6, true);
          public          postgres    false    212            ^           0    0    Detail_id_detail_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."Detail_id_detail_seq"', 4, true);
          public          postgres    false    214            _           0    0    Employee_id_employee_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."Employee_id_employee_seq"', 9, true);
          public          postgres    false    217            `           0    0    Task_id_task_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."Task_id_task_seq"', 20, true);
          public          postgres    false    220            |           2606    17065    Client Client_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public."Client"
    ADD CONSTRAINT "Client_pkey" PRIMARY KEY (id_client);
 @   ALTER TABLE ONLY public."Client" DROP CONSTRAINT "Client_pkey";
       public            postgres    false    209            ~           2606    17067    Contract Contract_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public."Contract"
    ADD CONSTRAINT "Contract_pkey" PRIMARY KEY (id_contract);
 D   ALTER TABLE ONLY public."Contract" DROP CONSTRAINT "Contract_pkey";
       public            postgres    false    211            ?           2606    17069    Detail Detail_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public."Detail"
    ADD CONSTRAINT "Detail_pkey" PRIMARY KEY (id_detail);
 @   ALTER TABLE ONLY public."Detail" DROP CONSTRAINT "Detail_pkey";
       public            postgres    false    213            ?           2606    17071    Employee Employee_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public."Employee"
    ADD CONSTRAINT "Employee_pkey" PRIMARY KEY (id_employee);
 D   ALTER TABLE ONLY public."Employee" DROP CONSTRAINT "Employee_pkey";
       public            postgres    false    215            ?           2606    17073    Task Task_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public."Task"
    ADD CONSTRAINT "Task_pkey" PRIMARY KEY (id_task);
 <   ALTER TABLE ONLY public."Task" DROP CONSTRAINT "Task_pkey";
       public            postgres    false    218            ?           1259    17074    detail_index    INDEX     c   CREATE UNIQUE INDEX detail_index ON public."Detail" USING btree (id_detail) INCLUDE (name_detail);
     DROP INDEX public.detail_index;
       public            postgres    false    213    213            ?           1259    17075    employee_index    INDEX     l   CREATE UNIQUE INDEX employee_index ON public."Employee" USING btree (id_employee) INCLUDE (email_employee);
 "   DROP INDEX public.employee_index;
       public            postgres    false    215    215            ?           1259    17076 
   task_index    INDEX     [   CREATE UNIQUE INDEX task_index ON public."Task" USING btree (id_task) INCLUDE (name_task);
    DROP INDEX public.task_index;
       public            postgres    false    218    218            ?           2620    17077    Task emp_stamp    TRIGGER     u   CREATE TRIGGER emp_stamp AFTER INSERT OR UPDATE ON public."Task" FOR EACH ROW EXECUTE FUNCTION public.delete_data();
 )   DROP TRIGGER emp_stamp ON public."Task";
       public          postgres    false    223    218            ?           2606    17078 5   Employee_Task Employee_Task_Employee_id_employee_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Employee_Task"
    ADD CONSTRAINT "Employee_Task_Employee_id_employee_fkey" FOREIGN KEY ("Employee_id_employee") REFERENCES public."Employee"(id_employee) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 c   ALTER TABLE ONLY public."Employee_Task" DROP CONSTRAINT "Employee_Task_Employee_id_employee_fkey";
       public          postgres    false    216    215    3203            ?           2606    17083 -   Employee_Task Employee_Task_Task_id_task_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Employee_Task"
    ADD CONSTRAINT "Employee_Task_Task_id_task_fkey" FOREIGN KEY ("Task_id_task") REFERENCES public."Task"(id_task) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 [   ALTER TABLE ONLY public."Employee_Task" DROP CONSTRAINT "Employee_Task_Task_id_task_fkey";
       public          postgres    false    216    3206    218            ?           2606    17088 -   Task_Detail Task_Detail_Detail_id_detail_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Task_Detail"
    ADD CONSTRAINT "Task_Detail_Detail_id_detail_fkey" FOREIGN KEY ("Detail_id_detail") REFERENCES public."Detail"(id_detail) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 [   ALTER TABLE ONLY public."Task_Detail" DROP CONSTRAINT "Task_Detail_Detail_id_detail_fkey";
       public          postgres    false    213    219    3200            ?           2606    17093 )   Task_Detail Task_Detail_Task_id_task_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Task_Detail"
    ADD CONSTRAINT "Task_Detail_Task_id_task_fkey" FOREIGN KEY ("Task_id_task") REFERENCES public."Task"(id_task) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 W   ALTER TABLE ONLY public."Task_Detail" DROP CONSTRAINT "Task_Detail_Task_id_task_fkey";
       public          postgres    false    218    3206    219            ?           2606    17098    Contract client_id    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Contract"
    ADD CONSTRAINT client_id FOREIGN KEY (id_client) REFERENCES public."Client"(id_client) NOT VALID;
 >   ALTER TABLE ONLY public."Contract" DROP CONSTRAINT client_id;
       public          postgres    false    209    211    3196            ?           2606    17103    Task contract_id    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Task"
    ADD CONSTRAINT contract_id FOREIGN KEY (contract_id) REFERENCES public."Contract"(id_contract) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 <   ALTER TABLE ONLY public."Task" DROP CONSTRAINT contract_id;
       public          postgres    false    211    3198    218                       0    17055    Task    ROW SECURITY     4   ALTER TABLE public."Task" ENABLE ROW LEVEL SECURITY;          public          postgres    false    218                       3256    25089    Task info_manager    POLICY     ?   CREATE POLICY info_manager ON public."Task" USING (('manager'::text = (( SELECT "Employee".title
   FROM public."Employee"
  WHERE (("Employee".login_employee)::text = CURRENT_USER)))::text));
 +   DROP POLICY info_manager ON public."Task";
       public          postgres    false    218    215    215                       3256    25090    Task select_info_spec    POLICY     s   CREATE POLICY select_info_spec ON public."Task" FOR SELECT TO tech_spec USING ((CURRENT_USER = (emp_name)::text));
 /   DROP POLICY select_info_spec ON public."Task";
       public          postgres    false    218    218                       3256    25091    Task update_info_spec    POLICY     s   CREATE POLICY update_info_spec ON public."Task" FOR UPDATE TO tech_spec USING ((CURRENT_USER = (emp_name)::text));
 /   DROP POLICY update_info_spec ON public."Task";
       public          postgres    false    218    218               ?   x???;
?@?z?{ Y?1;b?#B
0h?@?,Q<@?bB????+K?៟????NS7L???;#???s?@?	?C
?Q?r$?BE((??Hm(?P?)R)4?`xSw?'J??]?B?i???p@E??
՚??w???Z?0;?E?????7"DF???a1??pK??1?$KI?D?$q??'9?,???             x?3??4202?54"NC?=... $      "   F   x?3⼰??M.???va???????'?!?Ŧ[??{.컰?????ih`h`nnab????? r:      $   ?   x????0????.???~aׅ?*\??wa????????????	gNbqI~rFvf?CIjq?^r~.gnb^bzj??%????^l??pa߅M
f?]?
2??h????!gAjIQ~????????d?W? ?W=x      %      x?????? ? ?      '   ?   x?32༰?{.l??????M?^l r?]?a??ƋM?9?2[?/??-v????? ?????Yl(??w?(??b??]?r??i?i??Ǚ?i?Y?ZR?_ƙ?X\??????????? ??]?      (      x?????? ? ?     