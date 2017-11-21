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

```sql SELECT * FROM pais LIMIT 10;```

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/select-pais.png "Select País")

```sql SELECT * FROM estado LIMIT 10;```

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/select-estado.png "Select Estado")

```sql SELECT * FROM cidade LIMIT 10;```

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/select-cidade.png "Select Cidade")

```sql SELECT * FROM categoria LIMIT 10;```

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/select-categoria.png "Select Categoria")

```sql SELECT * FROM imovel LIMIT 10;```

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/select-imovel.png "Select Imóvel")

```sql SELECT * FROM endereco LIMIT 10;```

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/select-endereco.png "Select Endereço")

#### 9.3	SELECT DAS VISÕES COM PRIMEIROS 10 REGISTROS DA VIEW

```sql SELECT * FROM all_imoveis LIMIT 10; ```

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/select-all_imoveis.png "Select Endereço")

a) View criada para ser utilizada somente pelo site para exibir informações aos usuários, não exatamente sozinho (sendo refinado por estado por exemplo).

b) Permissão apenas de *SELECT* para o usuário do site.

```sql SELECT * FROM top_5_cidades_caras; ```

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/select-cidades-caras.png "Select Top 5 Cidades Caras")

a) View criada para ser utilizada somente pelo site para exibir informações aos usuários.

b) Permissão apenas de *SELECT* para o usuário do site.

```sql SELECT * FROM media_preco_estado LIMIT 10; ```

![Alt text](https://github.com/casa-valor/Casa-Valor/blob/master/documentos/select-media-preco-estado.png "Select Top 5 Cidades Caras")

a) View criada para ser utilizada somente pelo site para exibir informações aos usuários.

b) Permissão apenas de *SELECT* para o usuário do site.

#### 9.4	LISTA DE CODIGOS DAS FUNÇÕES, ASSERÇOES E TRIGGERS

        Detalhamento sobre funcionalidade de cada código.
        a) Objetivo
        b) Código do objeto (função/trigger/asserção)
        c) exemplo de dados para aplicação
        d) resultados em forma de tabela/imagem

#### 9.5	Administração do banco de dados

        Descrição detalhada sobre como serão executadas no banco de dados as <br>
        seguintes atividades.
        a) Segurança e autorização de acesso:
        b) Estimativas de aquisição de recursos para armazenamento e processamento da informação
        c) Planejamento de rotinas de manutenção e monitoramento do banco
        d) Plano com frequencia de análises visando otimização de performance

#### 9.6    GERACAO DE DADOS (MÍNIMO DE 1,5 MILHÃO DE REGISTROS PARA PRINCIPAL RELAÇAO)

    a) principal tabela do sistema deve ter no mínimo 1,5 milhão de registros
    b) tabelas diretamente relacionadas a tabela principal 100 mil registros
    c) tabelas auxiliares de relacao multivalorada mínimo de 10 registros
    d) registrar o tempo de inserção em cada uma das tabelas do banco de dados
    e) especificar a quantidade de registros inseridos em cada tabela
    Para melhor compreensão verifiquem o exemplo na base de testes:
    https://github.com/discipbd2/base-de-testes-locadora

#### 9.7	Backup do Banco de Dados

        Detalhamento do backup.
        a) Tempo
        b) Tamanho
        c) Teste de restauração (backup)
        d) Tempo para restauração
        e) Teste de restauração (script sql)
        f) Tempo para restauração (script sql)

Data de Entrega: (Data a ser definida)

#### 9.8	APLICAÇAO DE ÍNDICES E TESTES DE PERFORMANCE

    a) Lista de índices, tipos de índices com explicação de porque foram implementados
    b) Performance esperada VS Resultados obtidos
    c) Tabela de resultados comparando velocidades antes e depois da aplicação dos índices.
    
Data de Entrega: (Data a ser definida)

#### 9.9	ANÁLISE DOS DADOS COM ORANGE

    a) aplicação de algoritmos e interpretação dos resultados

    Data de Entrega: (Data a ser definida)

### 10	ATUALIZAÇÃO DA DOCUMENTAÇÃO/ SLIDES E ENTREGA FINAL

    Data de Entrega: (Data a ser definida)

### 11	DIFICULDADES ENCONTRADAS PELO GRUPO

### 12  FORMATACAO NO GIT: https://help.github.com/articles/basic-writing-and-formatting-syntax/
