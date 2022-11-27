PGDMP         5            
    z         
   Vet Clinic    14.5    14.5 l    6           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            7           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            8           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            9           1262    17196 
   Vet Clinic    DATABASE     i   CREATE DATABASE "Vet Clinic" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE "Vet Clinic";
                postgres    false            �            1255    17198    delete_data()    FUNCTION     �   CREATE FUNCTION public.delete_data() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM "Task" WHERE (CURRENT_DATE - date_end) >= 365;
    RETURN NULL;
END;
$$;
 $   DROP FUNCTION public.delete_data();
       public          postgres    false            :           0    0    FUNCTION delete_data()    ACL     p   GRANT ALL ON FUNCTION public.delete_data() TO manager;
GRANT ALL ON FUNCTION public.delete_data() TO tech_spec;
          public          postgres    false    224            �            1255    17199    save_to_json() 	   PROCEDURE     �   CREATE PROCEDURE public.save_to_json()
    LANGUAGE sql
    AS $$COPY ( SELECT array_to_json(array_agg(row_to_json(t)))
from "Task" 
t
) TO 'D:\GitHub\DataBase\save.json';$$;
 &   DROP PROCEDURE public.save_to_json();
       public          postgres    false            �            1259    17200    Client    TABLE       CREATE TABLE public."Client" (
    id_client integer NOT NULL,
    phone_number_client character(11) NOT NULL,
    email_client character varying(30),
    address character varying(50),
    client_type character varying(15) NOT NULL,
    name_client character varying(30) NOT NULL
);
    DROP TABLE public."Client";
       public         heap    postgres    false            ;           0    0    TABLE "Client"    COMMENT     k   COMMENT ON TABLE public."Client" IS 'Таблица для хранения данных клиента.';
          public          postgres    false    209            <           0    0    COLUMN "Client".id_client    COMMENT     �   COMMENT ON COLUMN public."Client".id_client IS 'Первичный ключ для идентификации клиента.';
          public          postgres    false    209            =           0    0 #   COLUMN "Client".phone_number_client    COMMENT     �   COMMENT ON COLUMN public."Client".phone_number_client IS 'Хранение информации о номере телефона клиента.';
          public          postgres    false    209            >           0    0    COLUMN "Client".email_client    COMMENT     y   COMMENT ON COLUMN public."Client".email_client IS 'Хранение информации о почте клиента.';
          public          postgres    false    209            ?           0    0    COLUMN "Client".address    COMMENT     x   COMMENT ON COLUMN public."Client".address IS 'Хранение информации об адресе клиента.';
          public          postgres    false    209            @           0    0    COLUMN "Client".client_type    COMMENT     �   COMMENT ON COLUMN public."Client".client_type IS 'Хранение данных о типе клиента. (текущий/потенциальный)';
          public          postgres    false    209            A           0    0    COLUMN "Client".name_client    COMMENT     �   COMMENT ON COLUMN public."Client".name_client IS 'Хранение информации об имени клиента / названии организации.';
          public          postgres    false    209            B           0    0    TABLE "Client"    ACL     /   GRANT ALL ON TABLE public."Client" TO manager;
          public          postgres    false    209            �            1259    17203    Client_id_client_seq    SEQUENCE     �   ALTER TABLE public."Client" ALTER COLUMN id_client ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Client_id_client_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    209            �            1259    17204    Contract    TABLE     �   CREATE TABLE public."Contract" (
    id_contract integer NOT NULL,
    description_contract text NOT NULL,
    date_contract date NOT NULL,
    id_client integer NOT NULL,
    id_pet integer NOT NULL
);
    DROP TABLE public."Contract";
       public         heap    postgres    false            C           0    0    TABLE "Contract"    COMMENT     t   COMMENT ON TABLE public."Contract" IS 'Таблица для хранения данных о контракте.';
          public          postgres    false    211            D           0    0    COLUMN "Contract".id_contract    COMMENT     �   COMMENT ON COLUMN public."Contract".id_contract IS 'Первичный ключ для идентификации контракта.';
          public          postgres    false    211            E           0    0 &   COLUMN "Contract".description_contract    COMMENT     �   COMMENT ON COLUMN public."Contract".description_contract IS 'Хранение информации об описании котракта.';
          public          postgres    false    211            F           0    0    COLUMN "Contract".date_contract    COMMENT     �   COMMENT ON COLUMN public."Contract".date_contract IS 'Хранение информации о дате заключения контракта.';
          public          postgres    false    211            G           0    0    COLUMN "Contract".id_pet    COMMENT     �   COMMENT ON COLUMN public."Contract".id_pet IS 'Хранение информации о первичном ключе питомца.';
          public          postgres    false    211            H           0    0    TABLE "Contract"    ACL     d   GRANT ALL ON TABLE public."Contract" TO manager;
GRANT SELECT ON TABLE public."Contract" TO doctor;
          public          postgres    false    211            �            1259    17209    Contract_id_contract_seq    SEQUENCE     �   ALTER TABLE public."Contract" ALTER COLUMN id_contract ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Contract_id_contract_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    211            �            1259    17210 	   Equipment    TABLE     �   CREATE TABLE public."Equipment" (
    id_equipment integer NOT NULL,
    name_equipment character varying(20) NOT NULL,
    vendor_code integer NOT NULL
);
    DROP TABLE public."Equipment";
       public         heap    postgres    false            I           0    0    TABLE "Equipment"    COMMENT     �   COMMENT ON TABLE public."Equipment" IS 'Таблица для хранения данных о нужных комплектующих для определенной услуги.';
          public          postgres    false    213            J           0    0    COLUMN "Equipment".id_equipment    COMMENT     �   COMMENT ON COLUMN public."Equipment".id_equipment IS 'Первичный ключ для идентификации инструмента.';
          public          postgres    false    213            K           0    0 !   COLUMN "Equipment".name_equipment    COMMENT     �   COMMENT ON COLUMN public."Equipment".name_equipment IS 'Хранение информации о названии инструмента.';
          public          postgres    false    213            L           0    0    COLUMN "Equipment".vendor_code    COMMENT     �   COMMENT ON COLUMN public."Equipment".vendor_code IS 'Хранение информации об артикуле инструмента.';
          public          postgres    false    213            M           0    0    TABLE "Equipment"    ACL     t   GRANT ALL ON TABLE public."Equipment" TO manager;
GRANT SELECT,INSERT,UPDATE ON TABLE public."Equipment" TO doctor;
          public          postgres    false    213            �            1259    17213    Detail_id_detail_seq    SEQUENCE     �   ALTER TABLE public."Equipment" ALTER COLUMN id_equipment ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Detail_id_detail_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    213            �            1259    17214    Employee    TABLE     9  CREATE TABLE public."Employee" (
    id_employee integer NOT NULL,
    name_employee character varying(30) NOT NULL,
    phone_number_employee character(11) NOT NULL,
    email_employee character varying(30) NOT NULL,
    title character varying(20) NOT NULL,
    login_employee character varying(10) NOT NULL
);
    DROP TABLE public."Employee";
       public         heap    postgres    false            N           0    0    TABLE "Employee"    COMMENT     t   COMMENT ON TABLE public."Employee" IS 'Таблица для хранения данных сотрудника.
';
          public          postgres    false    215            O           0    0    COLUMN "Employee".id_employee    COMMENT     �   COMMENT ON COLUMN public."Employee".id_employee IS 'Первичный ключ для идентификации сотрудника.';
          public          postgres    false    215            P           0    0    COLUMN "Employee".name_employee    COMMENT     �   COMMENT ON COLUMN public."Employee".name_employee IS 'Хранение информации об имени сотрудника.';
          public          postgres    false    215            Q           0    0 '   COLUMN "Employee".phone_number_employee    COMMENT     �   COMMENT ON COLUMN public."Employee".phone_number_employee IS 'Хранение информации о номере телефона сотрудника.';
          public          postgres    false    215            R           0    0     COLUMN "Employee".email_employee    COMMENT     �   COMMENT ON COLUMN public."Employee".email_employee IS 'Хранение информации о почте сотрудника.';
          public          postgres    false    215            S           0    0    COLUMN "Employee".title    COMMENT     �   COMMENT ON COLUMN public."Employee".title IS 'Хранение информации о должности сотрудника.';
          public          postgres    false    215            T           0    0    TABLE "Employee"    ACL     r   GRANT ALL ON TABLE public."Employee" TO manager;
GRANT SELECT,INSERT,UPDATE ON TABLE public."Employee" TO doctor;
          public          postgres    false    215            �            1259    17217    Employee_Task    TABLE     �   CREATE TABLE public."Employee_Task" (
    "Employee_id_employee" integer NOT NULL,
    "Task_id_task" integer NOT NULL,
    "position" character(1) NOT NULL
);
 #   DROP TABLE public."Employee_Task";
       public         heap    postgres    false            U           0    0 -   COLUMN "Employee_Task"."Employee_id_employee"    COMMENT     �   COMMENT ON COLUMN public."Employee_Task"."Employee_id_employee" IS 'Первичный ключ для идентификации сотрудника.';
          public          postgres    false    216            V           0    0 %   COLUMN "Employee_Task"."Task_id_task"    COMMENT     �   COMMENT ON COLUMN public."Employee_Task"."Task_id_task" IS 'Первичный ключ для идентификации задания.';
          public          postgres    false    216            W           0    0 !   COLUMN "Employee_Task"."position"    COMMENT     �   COMMENT ON COLUMN public."Employee_Task"."position" IS 'Позиция сотрудника (А - автор, И - исполнитель)';
          public          postgres    false    216            X           0    0    TABLE "Employee_Task"    ACL     6   GRANT ALL ON TABLE public."Employee_Task" TO manager;
          public          postgres    false    216            �            1259    17220    Employee_id_employee_seq    SEQUENCE     �   ALTER TABLE public."Employee" ALTER COLUMN id_employee ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Employee_id_employee_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    215            �            1259    17277    Pet    TABLE     �   CREATE TABLE public."Pet" (
    id_pet integer NOT NULL,
    kind_of_animal character varying(20) NOT NULL,
    sex character(1) NOT NULL,
    age character(2) NOT NULL,
    animal_name character(20)
);
    DROP TABLE public."Pet";
       public         heap    postgres    false            Y           0    0    TABLE "Pet"    COMMENT     s   COMMENT ON TABLE public."Pet" IS 'Таблица для хранения информации о питомце.';
          public          postgres    false    221            Z           0    0    COLUMN "Pet".id_pet    COMMENT     �   COMMENT ON COLUMN public."Pet".id_pet IS 'Хранение информации о первичном ключе питомца.';
          public          postgres    false    221            [           0    0    COLUMN "Pet".kind_of_animal    COMMENT     z   COMMENT ON COLUMN public."Pet".kind_of_animal IS 'Хранение информации о виде животного.';
          public          postgres    false    221            \           0    0    COLUMN "Pet".sex    COMMENT     �   COMMENT ON COLUMN public."Pet".sex IS 'Хранение информации о поле животного (М - мальчик, Д - девочка).';
          public          postgres    false    221            ]           0    0    COLUMN "Pet".age    COMMENT     s   COMMENT ON COLUMN public."Pet".age IS 'Хранение информации о возрасте питомца.';
          public          postgres    false    221            ^           0    0    COLUMN "Pet".animal_name    COMMENT     w   COMMENT ON COLUMN public."Pet".animal_name IS 'Хранение информации об имени питомца.';
          public          postgres    false    221            _           0    0    TABLE "Pet"    ACL     ,   GRANT ALL ON TABLE public."Pet" TO manager;
          public          postgres    false    221            �            1259    17286    Pet_id_pet_seq    SEQUENCE     �   ALTER TABLE public."Pet" ALTER COLUMN id_pet ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Pet_id_pet_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
    CYCLE
);
            public          postgres    false    221            �            1259    17221    Task    TABLE     �  CREATE TABLE public."Task" (
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
       public         heap    postgres    false            `           0    0    TABLE "Task"    COMMENT        COMMENT ON TABLE public."Task" IS 'Таблица для хранения данных о конкретной услуге.';
          public          postgres    false    218            a           0    0    COLUMN "Task".id_task    COMMENT     |   COMMENT ON COLUMN public."Task".id_task IS 'Первичный ключ для идентификации задания.';
          public          postgres    false    218            b           0    0    COLUMN "Task".name_task    COMMENT     z   COMMENT ON COLUMN public."Task".name_task IS 'Хранение информации о названии задания.';
          public          postgres    false    218            c           0    0    COLUMN "Task".description_task    COMMENT     �   COMMENT ON COLUMN public."Task".description_task IS 'Хранение информации об описании задания.';
          public          postgres    false    218            d           0    0    COLUMN "Task".date_create    COMMENT     �   COMMENT ON COLUMN public."Task".date_create IS 'Хранение информации о дате создания задания.';
          public          postgres    false    218            e           0    0    COLUMN "Task".date_deadline    COMMENT     ~   COMMENT ON COLUMN public."Task".date_deadline IS 'Хранение информации о дедлайне задания.';
          public          postgres    false    218            f           0    0    COLUMN "Task".priority    COMMENT     �   COMMENT ON COLUMN public."Task".priority IS 'Хранение информации о приоритете задания. (1 - высокий, 2 - средний, 3 - низкий)';
          public          postgres    false    218            g           0    0    COLUMN "Task".date_end    COMMENT     �   COMMENT ON COLUMN public."Task".date_end IS 'Хранение информации о дате завершения задания.';
          public          postgres    false    218            h           0    0    COLUMN "Task".status    COMMENT     �   COMMENT ON COLUMN public."Task".status IS 'Хранение информации о статусе задания. (0 - в работе, 1 - завершено)';
          public          postgres    false    218            i           0    0    COLUMN "Task".contract_id    COMMENT     |   COMMENT ON COLUMN public."Task".contract_id IS 'Хранение информации о номере контракта.';
          public          postgres    false    218            j           0    0    TABLE "Task"    ACL     k   GRANT ALL ON TABLE public."Task" TO manager;
GRANT SELECT,TRIGGER,UPDATE ON TABLE public."Task" TO doctor;
          public          postgres    false    218            �            1259    17226    Task_Equipment    TABLE     }   CREATE TABLE public."Task_Equipment" (
    "Task_id_task" integer NOT NULL,
    "Equipment_id_equipment" integer NOT NULL
);
 $   DROP TABLE public."Task_Equipment";
       public         heap    postgres    false            k           0    0 &   COLUMN "Task_Equipment"."Task_id_task"    COMMENT     �   COMMENT ON COLUMN public."Task_Equipment"."Task_id_task" IS 'Первичный ключ для идентификации задания.';
          public          postgres    false    219            l           0    0 0   COLUMN "Task_Equipment"."Equipment_id_equipment"    COMMENT     �   COMMENT ON COLUMN public."Task_Equipment"."Equipment_id_equipment" IS 'Первичный ключ для идентификации инструмента.';
          public          postgres    false    219            m           0    0    TABLE "Task_Equipment"    ACL     ~   GRANT ALL ON TABLE public."Task_Equipment" TO manager;
GRANT SELECT,INSERT,UPDATE ON TABLE public."Task_Equipment" TO doctor;
          public          postgres    false    219            �            1259    17229    Task_id_task_seq    SEQUENCE     �   ALTER TABLE public."Task" ALTER COLUMN id_task ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Task_id_task_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    218            &          0    17200    Client 
   TABLE DATA           s   COPY public."Client" (id_client, phone_number_client, email_client, address, client_type, name_client) FROM stdin;
    public          postgres    false    209   %~       (          0    17204    Contract 
   TABLE DATA           i   COPY public."Contract" (id_contract, description_contract, date_contract, id_client, id_pet) FROM stdin;
    public          postgres    false    211   �~       ,          0    17214    Employee 
   TABLE DATA           ~   COPY public."Employee" (id_employee, name_employee, phone_number_employee, email_employee, title, login_employee) FROM stdin;
    public          postgres    false    215   b       -          0    17217    Employee_Task 
   TABLE DATA           ]   COPY public."Employee_Task" ("Employee_id_employee", "Task_id_task", "position") FROM stdin;
    public          postgres    false    216   �       *          0    17210 	   Equipment 
   TABLE DATA           P   COPY public."Equipment" (id_equipment, name_equipment, vendor_code) FROM stdin;
    public          postgres    false    213   $�       2          0    17277    Pet 
   TABLE DATA           N   COPY public."Pet" (id_pet, kind_of_animal, sex, age, animal_name) FROM stdin;
    public          postgres    false    221   ��       /          0    17221    Task 
   TABLE DATA           �   COPY public."Task" (id_task, name_task, description_task, date_create, date_deadline, priority, date_end, status, contract_id, emp_name, manager_name) FROM stdin;
    public          postgres    false    218   ؀       0          0    17226    Task_Equipment 
   TABLE DATA           T   COPY public."Task_Equipment" ("Task_id_task", "Equipment_id_equipment") FROM stdin;
    public          postgres    false    219   ��       n           0    0    Client_id_client_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."Client_id_client_seq"', 5, true);
          public          postgres    false    210            o           0    0    Contract_id_contract_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."Contract_id_contract_seq"', 8, true);
          public          postgres    false    212            p           0    0    Detail_id_detail_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."Detail_id_detail_seq"', 7, true);
          public          postgres    false    214            q           0    0    Employee_id_employee_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."Employee_id_employee_seq"', 9, true);
          public          postgres    false    217            r           0    0    Pet_id_pet_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public."Pet_id_pet_seq"', 2, true);
          public          postgres    false    222            s           0    0    Task_id_task_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."Task_id_task_seq"', 23, true);
          public          postgres    false    220            �           2606    17231    Client Client_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public."Client"
    ADD CONSTRAINT "Client_pkey" PRIMARY KEY (id_client);
 @   ALTER TABLE ONLY public."Client" DROP CONSTRAINT "Client_pkey";
       public            postgres    false    209            �           2606    17233    Contract Contract_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public."Contract"
    ADD CONSTRAINT "Contract_pkey" PRIMARY KEY (id_contract);
 D   ALTER TABLE ONLY public."Contract" DROP CONSTRAINT "Contract_pkey";
       public            postgres    false    211            �           2606    17235    Equipment Detail_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public."Equipment"
    ADD CONSTRAINT "Detail_pkey" PRIMARY KEY (id_equipment);
 C   ALTER TABLE ONLY public."Equipment" DROP CONSTRAINT "Detail_pkey";
       public            postgres    false    213            �           2606    17237    Employee Employee_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public."Employee"
    ADD CONSTRAINT "Employee_pkey" PRIMARY KEY (id_employee);
 D   ALTER TABLE ONLY public."Employee" DROP CONSTRAINT "Employee_pkey";
       public            postgres    false    215            �           2606    17281    Pet Pet_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public."Pet"
    ADD CONSTRAINT "Pet_pkey" PRIMARY KEY (id_pet);
 :   ALTER TABLE ONLY public."Pet" DROP CONSTRAINT "Pet_pkey";
       public            postgres    false    221            �           2606    17239    Task Task_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public."Task"
    ADD CONSTRAINT "Task_pkey" PRIMARY KEY (id_task);
 <   ALTER TABLE ONLY public."Task" DROP CONSTRAINT "Task_pkey";
       public            postgres    false    218            �           1259    17240    detail_index    INDEX     l   CREATE UNIQUE INDEX detail_index ON public."Equipment" USING btree (id_equipment) INCLUDE (name_equipment);
     DROP INDEX public.detail_index;
       public            postgres    false    213    213            �           1259    17241    employee_index    INDEX     l   CREATE UNIQUE INDEX employee_index ON public."Employee" USING btree (id_employee) INCLUDE (email_employee);
 "   DROP INDEX public.employee_index;
       public            postgres    false    215    215            �           1259    17242 
   task_index    INDEX     [   CREATE UNIQUE INDEX task_index ON public."Task" USING btree (id_task) INCLUDE (name_task);
    DROP INDEX public.task_index;
       public            postgres    false    218    218            �           2620    17243    Task emp_stamp    TRIGGER     u   CREATE TRIGGER emp_stamp AFTER INSERT OR UPDATE ON public."Task" FOR EACH ROW EXECUTE FUNCTION public.delete_data();
 )   DROP TRIGGER emp_stamp ON public."Task";
       public          postgres    false    218    224            �           2606    17244 5   Employee_Task Employee_Task_Employee_id_employee_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Employee_Task"
    ADD CONSTRAINT "Employee_Task_Employee_id_employee_fkey" FOREIGN KEY ("Employee_id_employee") REFERENCES public."Employee"(id_employee) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 c   ALTER TABLE ONLY public."Employee_Task" DROP CONSTRAINT "Employee_Task_Employee_id_employee_fkey";
       public          postgres    false    216    3207    215            �           2606    17249 -   Employee_Task Employee_Task_Task_id_task_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Employee_Task"
    ADD CONSTRAINT "Employee_Task_Task_id_task_fkey" FOREIGN KEY ("Task_id_task") REFERENCES public."Task"(id_task) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 [   ALTER TABLE ONLY public."Employee_Task" DROP CONSTRAINT "Employee_Task_Task_id_task_fkey";
       public          postgres    false    216    218    3210            �           2606    17254 9   Task_Equipment Task_Equipment_Equipment_id_Equipment_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Task_Equipment"
    ADD CONSTRAINT "Task_Equipment_Equipment_id_Equipment_fkey" FOREIGN KEY ("Equipment_id_equipment") REFERENCES public."Equipment"(id_equipment) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 g   ALTER TABLE ONLY public."Task_Equipment" DROP CONSTRAINT "Task_Equipment_Equipment_id_Equipment_fkey";
       public          postgres    false    219    3204    213            �           2606    17259 /   Task_Equipment Task_Equipment_Task_id_task_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Task_Equipment"
    ADD CONSTRAINT "Task_Equipment_Task_id_task_fkey" FOREIGN KEY ("Task_id_task") REFERENCES public."Task"(id_task) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 ]   ALTER TABLE ONLY public."Task_Equipment" DROP CONSTRAINT "Task_Equipment_Task_id_task_fkey";
       public          postgres    false    219    218    3210            �           2606    17264    Contract client_id    FK CONSTRAINT     �   ALTER TABLE ONLY public."Contract"
    ADD CONSTRAINT client_id FOREIGN KEY (id_client) REFERENCES public."Client"(id_client) NOT VALID;
 >   ALTER TABLE ONLY public."Contract" DROP CONSTRAINT client_id;
       public          postgres    false    209    211    3200            �           2606    17269    Task contract_id    FK CONSTRAINT     �   ALTER TABLE ONLY public."Task"
    ADD CONSTRAINT contract_id FOREIGN KEY (contract_id) REFERENCES public."Contract"(id_contract) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 <   ALTER TABLE ONLY public."Task" DROP CONSTRAINT contract_id;
       public          postgres    false    218    3202    211            �           2606    17287    Contract pet_id    FK CONSTRAINT     }   ALTER TABLE ONLY public."Contract"
    ADD CONSTRAINT pet_id FOREIGN KEY (id_pet) REFERENCES public."Pet"(id_pet) NOT VALID;
 ;   ALTER TABLE ONLY public."Contract" DROP CONSTRAINT pet_id;
       public          postgres    false    3213    211    221            "           0    17277    Pet    ROW SECURITY     3   ALTER TABLE public."Pet" ENABLE ROW LEVEL SECURITY;          public          postgres    false    221            !           0    17221    Task    ROW SECURITY     4   ALTER TABLE public."Task" ENABLE ROW LEVEL SECURITY;          public          postgres    false    218            #           3256    17274    Task info_manager    POLICY     �   CREATE POLICY info_manager ON public."Task" USING (('manager'::text = (( SELECT "Employee".title
   FROM public."Employee"
  WHERE (("Employee".login_employee)::text = CURRENT_USER)))::text));
 +   DROP POLICY info_manager ON public."Task";
       public          postgres    false    215    215    218            $           3256    17283    Task select_info_doctor    POLICY     r   CREATE POLICY select_info_doctor ON public."Task" FOR SELECT TO doctor USING ((CURRENT_USER = (emp_name)::text));
 1   DROP POLICY select_info_doctor ON public."Task";
       public          postgres    false    218    218            %           3256    17285    Task update_info_doctor    POLICY     r   CREATE POLICY update_info_doctor ON public."Task" FOR UPDATE TO doctor USING ((CURRENT_USER = (emp_name)::text));
 1   DROP POLICY update_info_doctor ON public."Task";
       public          postgres    false    218    218            &   �   x���;
�@��zf� ��db�Bl|DHa��j��� �1B��5�ّ7�����9|��{m���-��0�IIB�x&p'�j�F�YK�/ng�Bi��J�������ʦv��)�G�Ì'5r�#�@�Ӡ.�]�7bL���j�f�m:Z�Pk�m7|�n��I)?�}�      (   o   x�M̻�@�x��k���J�C1v@1���@:Z�鈵#��h�<��80��p��?;_;
?ޫX2�9EK�%k#8Q��s���9f�؂?|1�l�V��i[���A(      ,   �   x���0����.��~aׅ�*\��wa������������	gNbqI~rFvf�CIjq�^r~.gnb^bzj��%���^l��pa߅M
f�]�
2��h����!gAjIQ~����"�0W� ,y<U      -      x���42�0�˂��D��qqq 9�      *   N   x�3㼰��/6_�}a���F ����xׅ}vr����[Xs�s^��$w\l����414����� ڳ'&      2   F   x�3估�¾�@r�)��
��\l�� P@\F�/컰����9�@��B;.�BW���� �Q'�      /   �   x���1�PD������EK=�'�����h�
)l�=*$���\��Ri��ٝd�0�$(Q�BR9Ytr@���F��E�Vrݕ�E2uU��^x}d�S<�E4�-i�Yo�CB��$���r|Q4wIQ�v��kqE���Q���O�`��#
��=�{M�1�	ZV��      0      x�32�4�22�4����� �     