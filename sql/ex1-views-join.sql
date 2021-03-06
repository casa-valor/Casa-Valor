
/*
* Imovel join
*/
SELECT imovel.id, imovel.preco, imovel.area, imovel.data, cidade.nome as cidade, estado.nome as estado, pais.nome as pais, categoria.nome as categoria FROM imovel
  INNER JOIN cidade ON (imovel.fk_cidade_id = cidade.id)
  INNER JOIN estado ON (cidade.fk_estado_id = estado.id)
  INNER JOIN pais ON (estado.fk_pais_id = pais.id)
  INNER JOIN cat_imo ON (imovel.id = cat_imo.fk_imovel_id)
  INNER JOIN categoria ON (cat_imo.fk_categoria_id = categoria.id);

/*
* Média de preços por cidade
*/
SELECT DISTINCT cidade.nome, AVG(imovel.preco) FROM imovel
  INNER JOIN cidade ON (cidade.id = imovel.fk_cidade_id) GROUP BY (cidade.nome);

/*
* Visão todos os imóveis
*/
CREATE VIEW all_imoveis AS
  SELECT imovel.id, imovel.preco, imovel.area, imovel.data_insercao, imovel.data_publicacao, endereco.bairro, cidade.nome as cidade, estado.nome as estado, pais.nome as pais, categoria.nome as categoria FROM imovel
    INNER JOIN endereco ON (imovel.fk_endereco_id = endereco.id)
    INNER JOIN cidade ON (endereco.fk_cidade_id = cidade.id)
    INNER JOIN estado ON (cidade.fk_estado_id = estado.id)
    INNER JOIN pais ON (estado.fk_pais_id = pais.id)
    INNER JOIN categoria ON (imovel.fk_categoria_id = categoria.id);


/*
* Top 5 cidades com a maior media de valor
*/
CREATE VIEW top_5_cidades_caras AS
  SELECT DISTINCT cidade.nome, estado.nome as estado, pais.nome as pais, AVG(imovel.preco) as preco FROM imovel
    INNER JOIN endereco ON (imovel.fk_endereco_id = endereco.id)
    INNER JOIN cidade ON (endereco.fk_cidade_id = cidade.id)
    INNER JOIN estado ON (estado.id = cidade.fk_estado_id)
    INNER JOIN pais ON (pais.id = estado.fk_pais_id)
    WHERE imovel.preco IS NOT NULL
    GROUP BY (cidade.nome, estado.nome, pais.nome)
    ORDER BY preco desc LIMIT 5;
 
 /*
 * Média de preços por categoria
 */
CREATE VIEW media_preco_categoria AS
  SELECT DISTINCT categoria.id, categoria.nome, categoria.tipo, AVG(imovel.preco) AS preco_medio FROM categoria
    INNER JOIN imovel ON (imovel.fk_categoria_id = categoria.id)
    GROUP BY (categoria.id);

/*
* Média de preços por estado
*/
CREATE VIEW media_preco_estado AS
  SELECT est.id, est.nome, AVG(imo.preco) AS preco_medio FROM estado as est
    INNER JOIN cidade AS cid ON (cid.fk_estado_id = est.id)
    INNER JOIN endereco AS en ON (en.fk_cidade_id = cid.id)
    INNER JOIN imovel AS imo ON (imo.fk_endereco_id = en.id)
    GROUP BY (est.id);

/*
* Check constraints
*/
 CREATE TABLE Categoria (
    id serial PRIMARY KEY,
    nome varchar(50),
    tipo varchar(50),
    check (tipo in ('à venda', 'para alugar'))
);
