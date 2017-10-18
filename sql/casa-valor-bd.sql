/* TADAAAA!: */

CREATE TABLE Pais (
    id serial PRIMARY KEY,
    nome char(3)
);

CREATE TABLE Estado (
    id serial PRIMARY KEY,
    nome char(2),
    FK_Pais_id serial
);

CREATE TABLE Cidade (
    id serial PRIMARY KEY,
    nome varchar(50),
    FK_Estado_id serial
);

CREATE TABLE Categoria (
    id serial PRIMARY KEY,
    nome varchar(50),
    tipo varchar(50),
    check (tipo in ('à venda', 'para alugar'))
);

CREATE TABLE Imovel (
    id serial PRIMARY KEY,
    preco Int,
    area int,
    data_insercao TIMESTAMP,
    data_publicacao date,
    FK_Endereco_id serial,
    FK_Categoria_id serial
);

CREATE TABLE Endereco (
    id serial PRIMARY KEY,
    cep Integer,
    bairro varchar(100),
    FK_Cidade_id serial
);
 
ALTER TABLE Estado ADD CONSTRAINT FK_Estado_1
    FOREIGN KEY (FK_Pais_id)
    REFERENCES Pais (id);
 
ALTER TABLE Cidade ADD CONSTRAINT FK_Cidade_1
    FOREIGN KEY (FK_Estado_id)
    REFERENCES Estado (id);
 
ALTER TABLE Imovel ADD CONSTRAINT FK_Imovel_1
    FOREIGN KEY (FK_Endereco_id)
    REFERENCES Endereco (id);
 
ALTER TABLE Imovel ADD CONSTRAINT FK_Imovel_2
    FOREIGN KEY (FK_Categoria_id)
    REFERENCES Categoria (id);
 
ALTER TABLE Endereco ADD CONSTRAINT FK_Endereco_1
    FOREIGN KEY (FK_Cidade_id)
    REFERENCES Cidade (id);
ALTER TABLE imovel ALTER COLUMN data_insercao SET DEFAULT now();


