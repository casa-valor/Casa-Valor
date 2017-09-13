--------- CRIAÇÃO ---------
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
    preco int,
    area int,
    data_insercao TIMESTAMP,
    data_publicacao date,
    FK_Cidade_id serial
);

CREATE TABLE Cat_imo (
    FK_Categoria_id serial,
    FK_Imovel_id serial
);
 
ALTER TABLE Estado ADD CONSTRAINT FK_Estado_1
    FOREIGN KEY (FK_Pais_id)
    REFERENCES Pais (id);
 
ALTER TABLE Cidade ADD CONSTRAINT FK_Cidade_1
    FOREIGN KEY (FK_Estado_id)
    REFERENCES Estado (id);
 
ALTER TABLE Imovel ADD CONSTRAINT FK_Imovel_1
    FOREIGN KEY (FK_Cidade_id)
    REFERENCES Cidade (id);
 
ALTER TABLE Cat_imo ADD CONSTRAINT FK_Cat_imo_0
    FOREIGN KEY (FK_Categoria_id)
    REFERENCES Categoria (id);
 
ALTER TABLE Cat_imo ADD CONSTRAINT FK_Cat_imo_1
    FOREIGN KEY (FK_Imovel_id)
    REFERENCES Imovel (id);

ALTER TABLE imovel ALTER COLUMN data_insercao SET DEFAULT now();

--------- VIEWS ---------
CREATE VIEW media_preco_estado AS
  SELECT est.id, est.nome, AVG(imo.preco) AS preco_medio FROM estado as est
    INNER JOIN cidade AS cid ON (cid.fk_estado_id = est.id)
    INNER JOIN imovel AS imo ON (imo.fk_cidade_id = cid.id)
    GROUP BY (est.id);

CREATE VIEW media_preco_categoria AS
  SELECT DISTINCT cat.id, cat.nome, cat.tipo, AVG(im.preco) AS preco_medio FROM categoria AS cat
    INNER JOIN cat_imo AS ci ON (ci.fk_categoria_id = cat.id)
    INNER JOIN imovel AS im ON (im.id = ci.fk_imovel_id)
    WHERE cat.nome <> ''
    GROUP BY (cat.id);

CREATE VIEW todos_imoveis AS
 SELECT imovel.id, imovel.preco, imovel.area, imovel.data_publicacao, imovel.data_insercao, cidade.nome as cidade, estado.nome as estado,
        pais.nome as pais, categoria.nome as categoria, categoria.tipo as tipo FROM imovel
  INNER JOIN cidade ON (imovel.fk_cidade_id = cidade.id)
  INNER JOIN estado ON (cidade.fk_estado_id = estado.id)
  INNER JOIN pais ON (estado.fk_pais_id = pais.id)
  INNER JOIN cat_imo ON (imovel.id = cat_imo.fk_imovel_id)
  INNER JOIN categoria ON (cat_imo.fk_categoria_id = categoria.id);


--------- INSERÇÃO ---------
INSERT INTO categoria (nome,tipo) SELECT 'apartamentos','à venda' WHERE NOT EXISTS (SELECT nome,tipo FROM categoria WHERE nome='apartamentos' AND tipo='à venda');
INSERT INTO categoria (nome,tipo) SELECT 'casas','à venda' WHERE NOT EXISTS (SELECT nome,tipo FROM categoria WHERE nome='casas' AND tipo='à venda');
INSERT INTO categoria (nome,tipo) SELECT 'terrenos, sítios e fazendas','à venda' WHERE NOT EXISTS (SELECT nome,tipo FROM categoria WHERE nome='terrenos, sítios e fazendas' AND tipo='à venda');
INSERT INTO categoria (nome,tipo) SELECT 'lojas, salas e outros','à venda' WHERE NOT EXISTS (SELECT nome,tipo FROM categoria WHERE nome='lojas, salas e outros' AND tipo='à venda');
INSERT INTO categoria (nome,tipo) SELECT 'apartamentos','para alugar' WHERE NOT EXISTS (SELECT nome,tipo FROM categoria WHERE nome='apartamentos' AND tipo='para alugar');
INSERT INTO categoria (nome,tipo) SELECT 'casas','para alugar' WHERE NOT EXISTS (SELECT nome,tipo FROM categoria WHERE nome='casas' AND tipo='para alugar');
INSERT INTO categoria (nome,tipo) SELECT 'aluguel de quartos','para alugar' WHERE NOT EXISTS (SELECT nome,tipo FROM categoria WHERE nome='aluguel de quartos' AND tipo='para alugar');
INSERT INTO categoria (nome,tipo) SELECT 'lojas, salas e outros','para alugar' WHERE NOT EXISTS (SELECT nome,tipo FROM categoria WHERE nome='lojas, salas e outros' AND tipo='para alugar');
INSERT INTO categoria (nome,tipo) SELECT 'terrenos, sítios e fazendas','para alugar' WHERE NOT EXISTS (SELECT nome,tipo FROM categoria WHERE nome='terrenos, sítios e fazendas' AND tipo='para alugar');
INSERT INTO categoria (nome,tipo) SELECT 'temporada','para alugar' WHERE NOT EXISTS (SELECT nome,tipo FROM categoria WHERE nome='temporada' AND tipo='para alugar');
INSERT INTO categoria (nome,tipo) SELECT 'lançamentos','à venda' WHERE NOT EXISTS (SELECT nome,tipo FROM categoria WHERE nome='lançamentos' AND tipo='à venda');
INSERT INTO pais (nome) SELECT 'BRA' WHERE NOT EXISTS (SELECT nome FROM pais WHERE nome='BRA');
INSERT INTO estado (nome,fk_pais_id) SELECT 'ES',1 WHERE NOT EXISTS (SELECT nome,fk_pais_id FROM estado WHERE nome='ES' AND fk_pais_id=1);
INSERT INTO estado (nome,fk_pais_id) SELECT 'RJ',1 WHERE NOT EXISTS (SELECT nome,fk_pais_id FROM estado WHERE nome='RJ' AND fk_pais_id=1);
INSERT INTO estado (nome,fk_pais_id) SELECT 'MG',1 WHERE NOT EXISTS (SELECT nome,fk_pais_id FROM estado WHERE nome='MG' AND fk_pais_id=1);
INSERT INTO estado (nome,fk_pais_id) SELECT 'SP',1 WHERE NOT EXISTS (SELECT nome,fk_pais_id FROM estado WHERE nome='SP' AND fk_pais_id=1);
INSERT INTO estado (nome,fk_pais_id) SELECT 'AC',1 WHERE NOT EXISTS (SELECT nome,fk_pais_id FROM estado WHERE nome='AC' AND fk_pais_id=1);
INSERT INTO estado (nome,fk_pais_id) SELECT 'RS',1 WHERE NOT EXISTS (SELECT nome,fk_pais_id FROM estado WHERE nome='RS' AND fk_pais_id=1);
INSERT INTO estado (nome,fk_pais_id) SELECT 'BA',1 WHERE NOT EXISTS (SELECT nome,fk_pais_id FROM estado WHERE nome='BA' AND fk_pais_id=1);
INSERT INTO estado (nome,fk_pais_id) SELECT 'CE',1 WHERE NOT EXISTS (SELECT nome,fk_pais_id FROM estado WHERE nome='CE' AND fk_pais_id=1);
INSERT INTO estado (nome,fk_pais_id) SELECT 'PE',1 WHERE NOT EXISTS (SELECT nome,fk_pais_id FROM estado WHERE nome='PE' AND fk_pais_id=1);
INSERT INTO estado (nome,fk_pais_id) SELECT 'RN',1 WHERE NOT EXISTS (SELECT nome,fk_pais_id FROM estado WHERE nome='RN' AND fk_pais_id=1);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Vila Velha',1 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Vila Velha' AND fk_estado_id=1);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Serra',1 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Serra' AND fk_estado_id=1);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Linhares',1 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Linhares' AND fk_estado_id=1);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Vitória',1 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Vitória' AND fk_estado_id=1);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'São Mateus',1 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='São Mateus' AND fk_estado_id=1);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Nova Iguaçu',2 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Nova Iguaçu' AND fk_estado_id=2);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Belo Horizonte',3 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Belo Horizonte' AND fk_estado_id=3);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Sumaré',4 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Sumaré' AND fk_estado_id=4);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'São Lourenço da Serra',4 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='São Lourenço da Serra' AND fk_estado_id=4);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Praia Grande',4 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Praia Grande' AND fk_estado_id=4);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'São José Dos Campos',4 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='São José Dos Campos' AND fk_estado_id=4);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389461238,650000,135,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389461238);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389461238);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389461026,120000,48,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389461026);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389461026);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Cariacica',1 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Cariacica' AND fk_estado_id=1);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459755,480000,123,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459755);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389459755);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459574,159900,55,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459574);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389459574);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460648,175000,null,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460648);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389460648);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459215,379000,123,'2017-09-13',2 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459215);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389459215);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460343,220000,90,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460343);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389460343);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460173,280000,65,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460173);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389460173);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460076,550000,100,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460076);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389460076);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458331,null,1,'2017-09-13',3 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458331);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (3,389458331);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459509,690000,170,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459509);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389459509);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459310,110000,42,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459310);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389459310);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458847,750000,100,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458847);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389458847);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 382942551,800,null,'2017-09-13',4 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=382942551);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (5,382942551);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458795,216000,60,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458795);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389458795);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458728,269000,60,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458728);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389458728);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458691,230000,65,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458691);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389458691);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389457374,620000,120,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389457374);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389457374);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458616,400000,62,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458616);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389458616);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458579,600000,200,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458579);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389458579);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458405,290000,160,'2017-09-13',2 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458405);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389458405);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389457064,180000,72,'2017-09-13',2 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389457064);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389457064);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389457051,290000,55,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389457051);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389457051);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389457023,400,82,'2017-09-13',5 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389457023);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (6,389457023);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Domingos Martins',1 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Domingos Martins' AND fk_estado_id=1);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458176,216000,60,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458176);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389458176);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458138,255000,68,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458138);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389458138);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458077,1600,350,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458077);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389458077);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389456773,249000,63,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389456773);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389456773);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458022,300000,120,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458022);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389458022);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389457957,89000,55,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389457957);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389457957);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389457939,980000,145,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389457939);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389457939);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389457889,238000,66,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389457889);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389457889);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Guarapari',1 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Guarapari' AND fk_estado_id=1);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389457742,725000,135,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389457742);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389457742);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389457673,590000,97,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389457673);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389457673);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389457658,650000,null,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389457658);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389457658);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Anchieta',1 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Anchieta' AND fk_estado_id=1);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389457620,270000,62,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389457620);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389457620);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389457494,269000,60,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389457494);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389457494);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389457503,216000,60,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389457503);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389457503);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389457480,269000,60,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389457480);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389457480);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389457459,5000,400,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389457459);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389457459);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389457325,1650,null,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389457325);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389457325);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389457205,110000,45,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389457205);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389457205);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 360129500,937,70,'2017-09-13',4 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=360129500);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (6,360129500);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389457147,279000,null,'2017-09-13',1 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389457147);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389457147);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389456965,150000,85,'2017-09-13',2 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389456965);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389456965);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Rio de Janeiro',2 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Rio de Janeiro' AND fk_estado_id=2);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459748,124000,55,'2017-09-13',6 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459748);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389459748);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'São Gonçalo',2 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='São Gonçalo' AND fk_estado_id=2);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Niterói',2 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Niterói' AND fk_estado_id=2);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Guapimirim',2 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Guapimirim' AND fk_estado_id=2);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Duque de Caxias',2 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Duque de Caxias' AND fk_estado_id=2);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Campos Dos Goytacazes',2 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Campos Dos Goytacazes' AND fk_estado_id=2);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458264,15000,200,'2017-09-13',6 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458264);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (3,389458264);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Belford Roxo',2 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Belford Roxo' AND fk_estado_id=2);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Lagoa Santa',3 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Lagoa Santa' AND fk_estado_id=3);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460097,600,45,'2017-09-13',7 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460097);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (5,389460097);
INSERT INTO cidade (nome,fk_estado_id) SELECT '7 Lagoas',3 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='7 Lagoas' AND fk_estado_id=3);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Pouso Alegre',3 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Pouso Alegre' AND fk_estado_id=3);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Juiz de Fora',3 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Juiz de Fora' AND fk_estado_id=3);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Vespasiano',3 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Vespasiano' AND fk_estado_id=3);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460927,1600,211,'2017-09-13',7 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460927);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389460927);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Timóteo',3 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Timóteo' AND fk_estado_id=3);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Uberaba',3 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Uberaba' AND fk_estado_id=3);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Governador Valadares',3 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Governador Valadares' AND fk_estado_id=3);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Ribeirão das Neves',3 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Ribeirão das Neves' AND fk_estado_id=3);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458830,100000,1000,'2017-09-13',7 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458830);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (3,389458830);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Montes Claros',3 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Montes Claros' AND fk_estado_id=3);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459994,1970,234,'2017-09-13',7 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459994);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389459994);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Contagem',3 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Contagem' AND fk_estado_id=3);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Ibirité',3 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Ibirité' AND fk_estado_id=3);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Betim',3 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Betim' AND fk_estado_id=3);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459267,650,null,'2017-09-13',7 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459267);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (5,389459267);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Igarapé',3 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Igarapé' AND fk_estado_id=3);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458982,1400,60,'2017-09-13',7 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458982);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (5,389458982);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Sarzedo',3 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Sarzedo' AND fk_estado_id=3);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458031,800,null,'2017-09-13',7 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458031);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (5,389458031);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Uberlândia',3 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Uberlândia' AND fk_estado_id=3);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Juatuba',3 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Juatuba' AND fk_estado_id=3);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389457516,1300,70,'2017-09-13',7 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389457516);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (5,389457516);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Araguari',3 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Araguari' AND fk_estado_id=3);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389456877,650,null,'2017-09-13',7 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389456877);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (5,389456877);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Ipatinga',3 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Ipatinga' AND fk_estado_id=3);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Pequeri',3 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Pequeri' AND fk_estado_id=3);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Pedro Leopoldo',3 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Pedro Leopoldo' AND fk_estado_id=3);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Goianá',3 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Goianá' AND fk_estado_id=3);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Brumadinho',3 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Brumadinho' AND fk_estado_id=3);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389461452,38000,null,'2017-09-13',8 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389461452);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389461452);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460183,1200,1000,'2017-09-13',9 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460183);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (9,389460183);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Sorocaba',4 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Sorocaba' AND fk_estado_id=4);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Guarujá',4 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Guarujá' AND fk_estado_id=4);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 367525191,200,null,'2017-09-13',10 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=367525191);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (10,367525191);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'São Paulo',4 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='São Paulo' AND fk_estado_id=4);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Hortolândia',4 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Hortolândia' AND fk_estado_id=4);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459899,160000,null,'2017-09-13',11 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459899);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (11,389459899);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Itaquaquecetuba',4 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Itaquaquecetuba' AND fk_estado_id=4);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Caçapava',4 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Caçapava' AND fk_estado_id=4);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Guarulhos',4 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Guarulhos' AND fk_estado_id=4);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Teodoro Sampaio',4 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Teodoro Sampaio' AND fk_estado_id=4);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460962,1600,null,'2017-09-13',10 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460962);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (5,389460962);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Mogi das Cruzes',4 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Mogi das Cruzes' AND fk_estado_id=4);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Bebedouro',4 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Bebedouro' AND fk_estado_id=4);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Monte Mor',4 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Monte Mor' AND fk_estado_id=4);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460637,1800,85,'2017-09-13',10 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460637);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (5,389460637);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Porangaba',4 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Porangaba' AND fk_estado_id=4);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Franca',4 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Franca' AND fk_estado_id=4);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460546,409000,78,'2017-09-13',11 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460546);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389460546);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Pardinho',4 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Pardinho' AND fk_estado_id=4);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460348,550000,24240,'2017-09-13',11 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460348);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (3,389460348);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Taboão da Serra',4 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Taboão da Serra' AND fk_estado_id=4);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460187,800,null,'2017-09-13',10 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460187);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (5,389460187);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460158,230000,68,'2017-09-13',11 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460158);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389460158);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Santos',4 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Santos' AND fk_estado_id=4);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460021,1500,100,'2017-09-13',10 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460021);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (5,389460021);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Santo André',4 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Santo André' AND fk_estado_id=4);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Campinas',4 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Campinas' AND fk_estado_id=4);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Tupã',4 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Tupã' AND fk_estado_id=4);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458471,215000,54,'2017-09-13',11 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458471);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389458471);
INSERT INTO cidade (nome,fk_estado_id) SELECT 'Guaiçara',4 WHERE NOT EXISTS (SELECT nome,fk_estado_id FROM cidade WHERE nome='Guaiçara' AND fk_estado_id=4);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460972,220000,250,'2017-09-13',12 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460972);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389460972);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458997,190000,55,'2017-09-13',2 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458997);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (4,389458997);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389456830,900000,null,'2017-09-13',13 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389456830);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (3,389456830);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389456460,1100,80,'2017-09-13',14 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389456460);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (5,389456460);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389456323,65000,2034,'2017-09-13',15 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389456323);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (3,389456323);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 374704113,890000,94,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=374704113);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,374704113);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459284,750,100,'2017-09-13',17 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459284);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (6,389459284);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460444,250000,120,'2017-09-13',18 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460444);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389460444);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458944,80000,5180,'2017-09-13',19 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458944);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (3,389458944);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458604,240000,null,'2017-09-13',20 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458604);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389458604);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458529,35000,2680,'2017-09-13',21 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458529);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389458529);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389457982,200000,366,'2017-09-13',22 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389457982);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389457982);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389461312,1090,230,'2017-09-13',23 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389461312);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389461312);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459996,600,null,'2017-09-13',24 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459996);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (6,389459996);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 382770649,700,70,'2017-09-13',25 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=382770649);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (5,382770649);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460982,306000,60,'2017-09-13',26 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460982);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389460982);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460599,600,null,'2017-09-13',27 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460599);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (5,389460599);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459275,110000,9000,'2017-09-13',28 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459275);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389459275);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 383662650,240000,66,'2017-09-13',29 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=383662650);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,383662650);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459054,279900,null,'2017-09-13',30 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459054);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389459054);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458938,null,null,'2017-09-13',7 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458938);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (7,389458938);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460135,null,null,'2017-09-13',7 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460135);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (8,389460135);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 315829023,450000,360,'2017-09-13',31 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=315829023);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,315829023);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459903,145000,70,'2017-09-13',32 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459903);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389459903);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459768,295000,85,'2017-09-13',33 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459768);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389459768);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389457993,48000,1000,'2017-09-13',34 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389457993);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (3,389457993);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389457727,120000,null,'2017-09-13',35 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389457727);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (3,389457727);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458840,165000,1000,'2017-09-13',36 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458840);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (3,389458840);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458508,null,null,'2017-09-13',37 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458508);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (3,389458508);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389456562,118000,47,'2017-09-13',38 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389456562);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389456562);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 325377224,20000,360,'2017-09-13',39 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=325377224);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (3,325377224);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389457056,null,12,'2017-09-13',40 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389457056);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389457056);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389456698,350000,100,'2017-09-13',41 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389456698);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389456698);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389454876,22000,200,'2017-09-13',42 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389454876);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (3,389454876);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389456065,null,null,'2017-09-13',43 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389456065);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (3,389456065);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 342651343,76500,479,'2017-09-13',44 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=342651343);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (3,342651343);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 385955330,120000,600,'2017-09-13',45 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=385955330);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (3,385955330);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389461285,189000,62,'2017-09-13',46 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389461285);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389461285);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460011,300,null,'2017-09-13',47 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460011);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (10,389460011);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459931,100000,49,'2017-09-13',48 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459931);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389459931);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389461136,2500,null,'2017-09-13',49 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389461136);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (6,389461136);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389461128,null,70,'2017-09-13',50 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389461128);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389461128);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389461079,179900,68,'2017-09-13',51 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389461079);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389461079);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 369123150,285000,80,'2017-09-13',52 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=369123150);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,369123150);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459714,null,null,'2017-09-13',53 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459714);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (4,389459714);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459638,275000,49,'2017-09-13',54 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459638);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389459638);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459461,600000,null,'2017-09-13',55 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459461);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389459461);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459321,119000,null,'2017-09-13',56 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459321);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (11,389459321);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459288,600000,230,'2017-09-13',57 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459288);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389459288);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459197,20000,287,'2017-09-13',58 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459197);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (3,389459197);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459059,null,450,'2017-09-13',59 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459059);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (3,389459059);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460268,235000,45,'2017-09-13',60 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460268);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389460268);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458735,355000,55,'2017-09-13',61 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458735);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389458735);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 328537529,230000,50,'2017-09-13',62 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=328537529);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,328537529);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458548,179900,null,'2017-09-13',63 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458548);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389458548);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459682,35000,1000,'2017-09-13',64 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459682);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (3,389459682);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458346,null,172,'2017-09-13',65 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458346);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389458346);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460705,320000,null,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460705);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389460705);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460689,990000,250,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460689);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389460689);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389461902,90000,60,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389461902);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389461902);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460659,949000,null,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460659);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389460659);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460547,160000,68,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460547);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389460547);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459206,35000,30,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459206);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389459206);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460327,250000,60,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460327);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389460327);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458376,600,65,'2017-09-13',17 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458376);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (6,389458376);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459603,159000,115,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459603);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389459603);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459542,1199.99,235,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459542);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389459542);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459523,595000,160,'2017-09-13',18 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459523);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389459523);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459259,550,50,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459259);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (5,389459259);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459168,600,null,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459168);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (5,389459168);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389457843,349000,82,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389457843);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389457843);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459115,700,50,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459115);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (5,389459115);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 366868982,1150,194,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=366868982);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,366868982);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 366868151,895000,139,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=366868151);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,366868151);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 366868606,870000,111,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=366868606);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,366868606);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 366866791,738000,116,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=366866791);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,366866791);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 366866711,498150,69,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=366866711);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,366866711);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 366867720,650000,96,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=366867720);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,366867720);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 366866658,650000,144,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=366866658);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,366866658);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 366866491,900000,154,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=366866491);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,366866491);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 366867629,1200,164,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=366867629);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,366867629);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 366867241,670000,103,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=366867241);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,366867241);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 366867536,670000,109,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=366867536);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,366867536);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 366865918,700000,90,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=366865918);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,366865918);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 366867428,750000,109,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=366867428);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,366867428);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 366867103,900000,103,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=366867103);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,366867103);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 366866823,630000,94,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=366866823);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,366866823);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 366866458,700000,144,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=366866458);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,366866458);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 387702974,660000,82,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=387702974);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,387702974);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 366865540,799000,114,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=366865540);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,366865540);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 366866289,850000,113,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=366866289);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,366866289);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 366866618,610000,89,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=366866618);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,366866618);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 334365385,130000,125,'2017-09-13',21 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=334365385);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,334365385);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460166,350000,93,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460166);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389460166);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 387050388,730000,89,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=387050388);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,387050388);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 382128228,1300,55,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=382128228);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (5,382128228);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458519,680000,160,'2017-09-13',18 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458519);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389458519);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458432,1350,80,'2017-09-13',16 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458432);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (6,389458432);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460137,null,null,'2017-09-13',23 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460137);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (3,389460137);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459790,490000,98,'2017-09-13',26 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459790);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389459790);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460875,800,null,'2017-09-13',26 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460875);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (5,389460875);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458095,75000,202,'2017-09-13',32 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458095);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (3,389458095);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458000,230000,65,'2017-09-13',34 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458000);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389458000);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458571,90000,500,'2017-09-13',23 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458571);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (3,389458571);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458292,45000,360,'2017-09-13',36 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458292);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (3,389458292);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458152,170000,null,'2017-09-13',26 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458152);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389458152);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458024,371000,75,'2017-09-13',26 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458024);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389458024);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 374817677,218000,75,'2017-09-13',36 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=374817677);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,374817677);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389457533,210000,null,'2017-09-13',26 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389457533);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389457533);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458621,400,null,'2017-09-13',26 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458621);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (5,389458621);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 387908250,175000,80,'2017-09-13',26 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=387908250);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,387908250);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389454902,128000,45,'2017-09-13',32 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389454902);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389454902);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389456024,230000,58,'2017-09-13',33 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389456024);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389456024);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389454299,135000,347,'2017-09-13',34 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389454299);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (3,389454299);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389461354,2300,150,'2017-09-13',11 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389461354);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (5,389461354);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389461182,170000,null,'2017-09-13',11 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389461182);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389461182);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389461135,158000,null,'2017-09-13',46 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389461135);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389461135);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389462373,138000,null,'2017-09-13',46 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389462373);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389462373);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389461057,360000,91,'2017-09-13',46 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389461057);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389461057);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459656,75000,90,'2017-09-13',48 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459656);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389459656);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460380,245000,70,'2017-09-13',50 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460380);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389460380);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459078,2600,86,'2017-09-13',48 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459078);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (5,389459078);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460366,null,40,'2017-09-13',48 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460366);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389460366);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460307,373770,81,'2017-09-13',48 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460307);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389460307);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 384484399,12000,220,'2017-09-13',48 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=384484399);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (8,384484399);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 384484370,130000,1300,'2017-09-13',48 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=384484370);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (8,384484370);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 384484294,2700,69,'2017-09-13',48 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=384484294);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (5,384484294);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389460279,160000,null,'2017-09-13',54 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389460279);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389460279);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 384484319,3300,80,'2017-09-13',48 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=384484319);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (5,384484319);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458580,75000,null,'2017-09-13',58 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458580);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (3,389458580);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389459842,22000,125,'2017-09-13',60 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389459842);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (1,389459842);
INSERT INTO imovel (id, preco, area, data_publicacao, fk_cidade_id) SELECT 389458537,623000,154,'2017-09-13',46 WHERE NOT EXISTS (SELECT * FROM imovel WHERE imovel.id=389458537);
INSERT INTO cat_imo (fk_categoria_id, fk_imovel_id) VALUES (2,389458537);
