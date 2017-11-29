# TRABALHO 01 : Casa-Valor
Trabalho desenvolvido durante a disciplina de BD

    O referido projeto poderá ser:
        a) Um novo sistema/projeto 
        b) Uma expansão de sistema/projeto previamente desenvolvido em disciplinas anteriores 
        (ex: Expansão dos módulos do sistema desenvolvidos em BD1 - incremento mínimo de 50% nos 
        requisitos/complexidade)
    
    OBS Importantes: 
        a) Os projetos/sistemas propostos serão validados pelo professor e pela turma
        b) Se possível é interessante que os novos sistemas estejam correlacionados com alguma área 
        previamente estudada pelo aluno
        c) Caso dependa de alguma instituição/parceiro externo, a base de dados e informações pertinentes 
        a esta devem ser obtidas no prazo de até 15 dias apos aprovação da proposta do trabalho 
        (caso contrário, nova proposta deverá ser apresentada a turma implicando logicamente em um prazo 
        mais curto para realização das atividades e conclusão do trabalho)
    
DICA: 
    O kickstart normalmente lança inovaçôes em termos de Sofwares e Apps, portanto pode ser interessante 
    olhar os lançamentos recentes para incrementar as possibilidades e aguçar a criatividade, o que pode 
    auxiliar o grupo com novas ideias na solução proposta. Acesse os links abaixo do para explorar sobre apps e softwares no Kickstarter.
    <br>
    https://www.kickstarter.com/discover/categories/technology/software
    <br>
    https://www.kickstarter.com/discover/categories/technology/apps
# Sumário

### 1	COMPONENTES

* David Vilaça - vilacapdavid@gmail.com
* Icaro Gavazza - icarodgl@gmail.com

### 2	INTRODUÇÃO E MOTIVAÇAO

Casa & Valor é uma aplicação que visa fornecer informaçes estatísticas sobre valorizaço de imóveis de acordo com a região, ajudando a tomada de decisão de compra/venda de casas, apartamentos, terrenos, etc..
      
### 3	MINI-MUNDO

Casa & Valor é uma aplicação voltada para a população geral que fornece informações estatsticas do ramo imobiliário de uma determinada região a ser escolhida pelo usuário. A utilização da aplicação é totalmente feita pelo navegador web, sendo acessível a qualquer dispositivo com um navegador Chrome ou Firefox.

Ao acessar o site pela primeira vez, o usuário visualizará um texto de boas vindas e um breve resumo sobre o que se trata a aplicação e logo após deverá ter opções para escolher qual o local que deseja obter as informações imobiliárias. As informações deverão ser apresentadas ao usuário tanto em gráficos quanto texto. As informações são:
* Região em valorização (Mapa, Gráfico)
* Região em desvalorizaço (Mapa, Gráfico)
* Maior valor da região (Texto)
* Menor valor da região (Texto)
* Histórico anual da média de preços da região (Gráfico)
* Listagem das ruas da região com suas respectivas médias de preos atuais e índice de crescimento

### 4	RASCUNHOS BÁSICOS DA INTERFACE (MOCKUPS)


### [Mokup do projeto](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/Casa-Valor.pdf)

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/mokup.png "Title")


### 5	MODELO CONCEITUAL


#### 5.1 NOTACAO ENTIDADE RELACIONAMENTO

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/conceitual.png?raw=true "Modelo Conceitual")


#### 5.3 DECISÕES DE PROJETO

Identificador: Cada entidade do projeto foi optado por normalizar com identificador `id` para facilitar o campo destinado ao mesmo. Exceto a relação n:n **Cat_imo**, pois é desnecessário.

Endereço: Foi acordado que para fins de melhor aproveitamento de espaço em disco e desempenho, o endereço será quebrado em entidades básicas em um relacionamento em cascata.

Campo preco (Imovel): Em nosso projeto optamos pelo tipo `int` para o preço, pois é improvável imóveis possuir preço não inteiro, além desse tipo satisfazer com fartura a faixa de preço dos imóveis.

Campo area: Optamos também pelo tipo `int` para a área, pois é improvável este campo não ser inteiro e esse tipo satisfaz.

Campo categoria (Imovel): Optamos por uma relação através de uma entidade formada apenas de chaves estrangeiras, pois uma categoria pode se relacionar com nenhum ou vários imóveis e um imóvel pode estar ou não relacionado a uma categoria (raramente, mas aparecem alguns registros no OLX sem categoria).

Campo tipo (Categoria): Optamos por um campo simples do tipo `varchar` por ser extremamente limitado o número de variações.

#### 5.4 DESCRIÇÃO DOS DADOS 
   - Categoria.nome : Possui a nome do lugar a ser negóciado podendo ser terreno, edificações, etc.
   - Categoria.tipo : Possui o tipo do negócio quer será realizado.
   - Imovel.preco : Possui o preço estabelecido pelo anunciante.
   - Imovel.area : Possui a área anunciada do lugar.
   - Imovel.data_publicacao : Data de publicação do anuncio.
   - Imovel.data_insercao : Data que foi capturado por nossa aplicação.
   - Cidade.nome : Nome da cidade usado para colher as estatisticas da região.
   - Estado.nome : Nome do estado usado para Agrupar as cidades.
   - Pais.nome : Pai por enquanto guarda apenas o Brasil, mas caso haja expansão já está feito.

### 6	MODELO LÓGICO

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/logico.png "Modelo Lógico")

### 7	MODELO FÍSICO

[SQL](https://github.com/casa-valor/Casa-Valor/blob/master/sql/casa-valor-bd.sql)

### 8	INSERT APLICADO NAS TABELAS DO BANCO DE DADOS


#### 8.1 DETALHAMENTO DAS INFORMAÇÕES

Os dados estão sendo obtidos através de um **web scraping** que vasculha o site `olx.com.br` e obtém os dados referente aos imóveis que estão sendo anunciados por lá. Para saber mais [clique aqui](scraping-node).

Para desenvolver a ferramenta que obtém os dados nos baseamos nos seguintes artigos:
* [Scoth.io - Scraping the web with nodejs](https://scotch.io/tutorials/scraping-the-web-with-node-js)
* [Tableless - Raspagem de dados com Node.js](https://tableless.com.br/raspagem-de-dados-com-node-js/)

#### 8.2 INCLUSÃO DO SCRIPT PARA CRIAÇÃO DE TABELAS E INSERÇÃO DOS DADOS (ARQUIVO ÚNICO COM):

[Arquivo create and insert](https://github.com/casa-valor/Casa-Valor/blob/master/sql/create-and-insert.sql)

### 9	TABELAS E PRINCIPAIS CONSULTAS


#### 9.1	GERACAO DE DADOS (MÍNIMO DE 10 REGISTROS PARA CADA TABELA NO BANCO DE DADOS)

Data de Entrega: (18/09/2017)

OBS: Incluir para os tópicos 9.2 e 9.3 as instruções SQL + imagens (print da tela) mostrando os resultados.

#### 9.2	SELECT DAS TABELAS COM PRIMEIROS 10 REGISTROS INSERIDOS

```sql
SELECT * FROM pais LIMIT 10;
```

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/select-pais.png "Select País")

```sql
SELECT * FROM estado LIMIT 10;
```

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/select-estado.png "Select Estado")

```sql
SELECT * FROM cidade LIMIT 10;
```

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/select-cidade.png "Select Cidade")

```sql
SELECT * FROM categoria LIMIT 10;
```

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/select-categoria.png "Select Categoria")

```sql
SELECT * FROM imovel LIMIT 10;
```

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/select-imovel.png "Select Imóvel")

```sql
SELECT * FROM endereco LIMIT 10;
```

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/select-endereco.png "Select Endereço")

#### 9.3	SELECT DAS VISÕES COM PRIMEIROS 10 REGISTROS DA VIEW

```sql
SELECT * FROM all_imoveis LIMIT 10;
```

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/select-all-imoveis.png "Select Endereço")

a) View criada para ser utilizada somente pelo site para exibir informações aos usuários, não exatamente sozinho (sendo refinado por estado por exemplo).

b) Permissão apenas de *SELECT* para o usuário do site.

```sql
SELECT * FROM top_5_cidades_caras;
```

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/select-cidades-caras.png "Select Top 5 Cidades Caras")

a) View criada para ser utilizada somente pelo site para exibir informações aos usuários.

b) Permissão apenas de *SELECT* para o usuário do site.

```sql
SELECT * FROM media_preco_estado LIMIT 10;
```

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/select-media-preco-estado.png "Select Top 5 Cidades Caras")

a) View criada para ser utilizada somente pelo site para exibir informações aos usuários.

b) Permissão apenas de *SELECT* para o usuário do site.

#### 9.4	LISTA DE CODIGOS DAS FUNÇÕES, ASSERÇOES E TRIGGERS

##### Adicionar um imóvel já com endereço

Objetivo: Adicionar imóvel de forma facilitada e retornar imóvel salvo para o scraping para realizar as ações automáticas sem precisar executar várias queries.

```sql
CREATE FUNCTION addImovel(id_p integer, preco_p integer, area_p integer, data_pub_p date, cep_p integer, bairro_p varchar, fk_cidade_id_p integer, fk_categoria_id_p integer)
RETURNS imovel
AS $$
DECLARE
  categoria integer;
  im imovel;
BEGIN
  INSERT INTO endereco (cep, bairro, FK_Cidade_id) VALUES ($5, $6, $7) RETURNING id INTO categoria;
  INSERT INTO imovel (
      id, preco, area, data_publicacao,
      FK_Endereco_id,
      FK_Categoria_id)
    VALUES (
      $1, $2, $3, $4, categoria, $8
    ) RETURNING * INTO im;
    RETURN im;
END;
$$ LANGUAGE plpgsql;
```

Teste:
```sql
SELECT * FROM addImovel(999999995, 250000, 100, '2017-08-15', 29836421, 'Manguinhos', 22, 1);
```

Resultado:

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/resultadoaddimovel.png "Resultado addImovel")

##### Verificação de preço negativo

a) Evitar preços negativos

```sql
CREATE OR REPLACE FUNCTION checkPrecoNegativo() RETURNS TRIGGER
AS $$

BEGIN
  IF ( NEW.preco < 0 ) THEN
    RAISE EXCEPTION 'Erro: Preço não pode ser negativo!';
  END IF;
  RETURN NULL;
END;

$$ LANGUAGE plpgsql;

CREATE TRIGGER checkPrecoNegativoTrigger
 BEFORE INSERT OR UPDATE
ON Imovel
 FOR EACH ROW
 EXECUTE PROCEDURE checkPrecoNegativo();
```

Teste:

```sql
INSERT INTO Imovel (preco, area, data_publicacao, FK_Endereco_id, FK_Categoria_id) VALUES
(-1,107,'2017-10-30',19117,9)
```
Resultado:

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/erropreconegativo.png "erro preco negativo")

##### Média ponderada por bairro

Objetivo: Obter a média ponderada de preço dado um bairro aliviando o processamento do site, transferindo para o servidor.

```sql
CREATE FUNCTION mediaPonderadaBairro (NOMEBAIRRO VARCHAR)
RETURNS TABLE(MEDIA BIGINT)
AS $$
SELECT SUM(I.PRECO*I.AREA)/SUM(I.AREA) AS media_preco FROM IMOVEL AS I
	INNER JOIN ENDERECO AS E ON (I.FK_ENDERECO_ID =  E.ID)
	WHERE E.BAIRRO ILIKE NOMEBAIRRO;
$$ LANGUAGE SQL
```

Teste:

```sql
select * from mediaPonderadaBairro ('langan')
```

Resultado:

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/funcaomediabairro.png "resultado")


#### 9.5	Administração do banco de dados

- Criamos os usuários para acesso as tabelas:

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/users%20postgre.png "select usuarios")

- Criamos os grupos e demos privilegios adequados aos mesmos:

```sql
grant all privileges on database casavalor to adms

grant select on database casavalor to convidados
```

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/grupos%20postgre.png "select grupos")


- A principio o projeto necessitará de um servidor basico para conseguir rodar pois o sistema recebe grande esforço apenas quando rodamos as inserções de dados realizadas pelo scrap, após isso poucas consultas são realizadas, o que será exigido em maior quantidade será armazenamento de dados, pois a cada semana será inserido informações de todo o Brasil, assim uma configuração sugerida seria:

|recurso|quantidade|
|---|---|
|CPU|4 Core|
|RAM|4 GB|
|HDD|1TB|

- As rotinas de manutenção serão executadas durante as terças, após coletar os dados com o sistema, realizaremos o comando:

```sql
analyze;
```
Outros não serão necessáros pois o sistema não receberá deleções.

#### 9.6    GERACAO DE DADOS (MÍNIMO DE 1,5 MILHÃO DE REGISTROS PARA PRINCIPAL RELAÇAO)

Local dos dados no projeto:
    https://github.com/casa-valor/Casa-Valor/tree/master/randados

#### 9.7	Backup do Banco de Dados

|Tipo|Tamanho|Tempo backup|Tempo restore|
|---|---|---|---|
|Fc|58.4|24|50|
|sql|309.8|22|56|

```shell
ini=$(date +%s)

#para fazer o backup descomente esta linha:
#pg_dump -h localhost -Fc -U postgres -w -d casavalor > casavalor.bkp

#para restaurar descomente esta linha:
pg_restore -h localhost -U postgres -w -d casavalor2 < casavalor.bkp

fim=$(date +%s)
dif=$((fim - ini))
echo "tempo: $dif"
```

#### 9.8	APLICAÇAO DE ÍNDICES E TESTES DE PERFORMANCE

Nos aplicamos índices na tabela `imovel` e `endereco` pois serão as tabelas mais importantes do sistemas.
Em `imovel` nos aplicamos o índice no campo `preco` e `area` pois so os campos que mais importantes do sistema.
Na tabela `endereco`, nós aplicamos  índice no `bairro`, pois assim lacalizaremos e agruparemos os bairros mais rapidamente.

##### CONFIGURAÇÕES DA MÁQUINA

Todos os testes foram executados em um Macbook Air 13, modelo 2015 com 8gb de memória ram, processador intel core i5 e com sistema operacional MacOS High Sierra (10.13.1) sem configurações de economia de energia.

```Obs: O postgres foi instanciado com Docker (17.09.0-ce, build afdb6d4)```

##### CONFIGURAÇÕES DO BANCO

```sql
-- Função para copiar criar tabela identica
CREATE OR REPLACE FUNCTION create_table_like(source_table text, new_table text)
RETURNS void LANGUAGE plpgsql
AS $$
DECLARE
    rec record;
BEGIN
    EXECUTE format(
        'create table %s (like %s including all)',
        new_table, source_table);
    FOR rec IN
        SELECT oid, conname
        FROM pg_constraint
        WHERE contype = 'f' 
        AND conrelid = source_table::regclass
    LOOP
        execute format(
            'alter table %s add constraint %s %s',
            new_table,
            replace(rec.conname, source_table, new_table),
            pg_get_constraintdef(rec.oid));
    END LOOP;
END $$;

-- Criando nova tabela de imóvel e adicionando os mesmos dados
SELECT create_table_like('imovel', 'imovel2');
INSERT INTO imovel2 SELECT * FROM imovel;

-- Criando nova tabela de endereço e adicionando os mesmos dados
SELECT create_table_like('endereco', 'endereco2');
INSERT INTO endereco2 SELECT * FROM endereco;


-- Adicionando índices na tabela imovel2
CREATE INDEX precoBtree ON imovel2 (preco);
CREATE INDEX areaBtree ON imovel2 (area);

-- Adicionando índice na tabela endereco2
CREATE INDEX bairroBtree ON endereco2 USING hash (bairro);
-- Correção: O nome do índice deveria se chamar bairroHash (falha nossa)

-- OBS: APROXIMADAMENTE 1m A EXECUÇÃO
```

##### QUERIES

Sem índice

```sql
-- A
SELECT E.BAIRRO, AVG(I.PRECO) FROM IMOVEL I
  INNER JOIN ENDERECO E ON (E.ID = I.FK_ENDERECO_ID)
  WHERE I.PRECO < 200000 AND (E.BAIRRO = 'Kings' OR E.BAIRRO = 'Wogan')
  GROUP BY E.BAIRRO;

-- B
SELECT BAIRRO, COUNT(E.ID) 
  FROM ENDERECO E 
  WHERE E.BAIRRO = 'Kings'
  GROUP BY BAIRRO

-- C
SELECT * FROM IMOVEL I
  WHERE I.PRECO <= 300000;
```

Com índice

```sql
-- A
SELECT E.BAIRRO, AVG(I.PRECO) FROM IMOVEL2 I
  INNER JOIN ENDERECO2 E ON (E.ID = I.FK_ENDERECO_ID)
  WHERE I.PRECO < 200000 AND (E.BAIRRO = 'Kings' OR E.BAIRRO = 'Wogan')
  GROUP BY E.BAIRRO;

-- B
SELECT BAIRRO, COUNT(E.ID) 
  FROM ENDERECO2 E 
  WHERE E.BAIRRO = 'Kings'
  GROUP BY BAIRRO

-- C
SELECT * FROM IMOVEL2 I
  WHERE I.PRECO <= 300000;
```

##### RESULTADOS

|Tabela|Com Indice|Sem Indice|
|---|---|---|
|A ESPERADO|1318ms|2417ms|
|A REAL|140ms|258ms|
|B ESPERADO|1ms|18ms|
|B REAL|23ms|35ms|
|C ESPERADO|3376ms|3440ms|
|C REAL|3200ms|3145ms|

IMAGENS:

***RESULTADOS ESPERADOS**

***A (SEM ÍNDICE):***

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/resultado-esperado-a-semindex.png "resultado a sem index")

***A (COM ÍNDICE):***

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/resultado-esperado-a-comindex.png "resultado a com index")

***B (SEM ÍNDICE):***

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/resultado-esperado-b-semindex.png "resultado b sem index")

***B (COM ÍNDICE):***

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/resultado-esperado-b-comindex.png "resultado b com index")

***C (SEM ÍNDICE):***

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/resultado-esperado-c-semindex.png "resultado c sem index")

***C (COM ÍNDICE):***

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/resultado-esperado-c-comindex.png "resultado c com index")

***RESULTADOS REAIS***

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/resultados-reais.png "RESULTADOS REAIS")
    
Data de Entrega: (27/11)

#### 9.9	ANÁLISE DOS DADOS COM ORANGE

    a) aplicação de algoritmos e interpretação dos resultados

    Data de Entrega: (Data a ser definida)

### 10	ATUALIZAÇÃO DA DOCUMENTAÇÃO/ SLIDES E ENTREGA FINAL

    Data de Entrega: (Data a ser definida)

### 11	DIFICULDADES ENCONTRADAS PELO GRUPO

### 12  FORMATACAO NO GIT: https://help.github.com/articles/basic-writing-and-formatting-syntax/
