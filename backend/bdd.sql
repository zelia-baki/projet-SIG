PGDMP     '    2                |            carte_visite    15.3    15.3     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    49317    carte_visite    DATABASE     �   CREATE DATABASE carte_visite WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Madagascar.1252';
    DROP DATABASE carte_visite;
                postgres    false            �            1259    49319    carte    TABLE     �   CREATE TABLE public.carte (
    id integer NOT NULL,
    nom text,
    emploi text,
    tel text,
    mail text,
    site text,
    adresse text,
    logo character varying(100)
);
    DROP TABLE public.carte;
       public         heap    postgres    false            �            1259    49318    carte_id_seq    SEQUENCE     �   CREATE SEQUENCE public.carte_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.carte_id_seq;
       public          postgres    false    215            �           0    0    carte_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.carte_id_seq OWNED BY public.carte.id;
          public          postgres    false    214            e           2604    49322    carte id    DEFAULT     d   ALTER TABLE ONLY public.carte ALTER COLUMN id SET DEFAULT nextval('public.carte_id_seq'::regclass);
 7   ALTER TABLE public.carte ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    214    215    215            �          0    49319    carte 
   TABLE DATA                 public          postgres    false    215   T
       �           0    0    carte_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.carte_id_seq', 5, true);
          public          postgres    false    214            g           2606    49326    carte carte_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.carte
    ADD CONSTRAINT carte_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.carte DROP CONSTRAINT carte_pkey;
       public            postgres    false    215            �   �   x�ݏ�
�@E����ja(b�(nt�P�����c�L�L��ގ�	��&ܛ���lw\N��N{�۫�<��:�*����a�� ��׆	��R��Bi"�,7��#�-�R��\[0V��&�t<����;��vcǸ�><΍����b�I����e���h,���;K�VZՖOI�0������#J��hܟZ��/���     