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
teste:
```sql
INSERT INTO Imovel (preco, area, data_publicacao, FK_Endereco_id, FK_Categoria_id) VALUES
(-1,107,'2017-10-30',19117,9)
```
resultado:

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/erropreconegativo.png "erro preco negativo")

```sql
CREATE OR REPLACE FUNCTION MEDIAPONDERADABAIRRO (NOMEBAIRRO VARCHAR)
RETURNS TABLE(MEDIA BIGINT)
AS $$
SELECT SUM(I.PRECO*I.AREA)/SUM(I.AREA) AS MEDIAMALUCA FROM IMOVEL AS I
	INNER JOIN ENDERECO AS E ON (I.FK_ENDERECO_ID =  E.ID)
	WHERE E.BAIRRO ILIKE NOMEBAIRRO;
$$ LANGUAGE SQL
```

teste:

```sql
select * from mediaPonderadaBairro ('langan')
```

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

Nos aplicamos indices na tabela Imovel e Endereco pois serão as tabelas mais importantes do sistemas.
Em Imovel nos aplicamos o indice no campo preco e area pois so os campos que mais importantes do sistema.
Na tabela Endereco, nós aplicamos  indice no bairro, pois assim lacalizaremos e agruparemos os bairros mais rapidamente.

|Tabela|Com Indice|Sem Indice|
|---|---|---|
|Imovel|sec|sec|
|Endereco|sec|sec|
    
Data de Entrega: (27/11)

#### 9.9	ANÁLISE DOS DADOS COM ORANGE

    a) aplicação de algoritmos e interpretação dos resultados

    Data de Entrega: (Data a ser definida)

### 10	ATUALIZAÇÃO DA DOCUMENTAÇÃO/ SLIDES E ENTREGA FINAL

    Data de Entrega: (Data a ser definida)

### 11	DIFICULDADES ENCONTRADAS PELO GRUPO

### 12  FORMATACAO NO GIT: https://help.github.com/articles/basic-writing-and-formatting-syntax/
