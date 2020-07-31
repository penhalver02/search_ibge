# Search IGE

## Descrição  do projeto

<p>Sistema consiste em um menu com três opções sendo elas: 1 buscar o ranking de nomes mais comuns em uma uf, 2 os nomes mais comuns em uma cidade e 3 busca a frequência de um nome digitado pelo usuário ao longo do tempo.</p>
<p>As opções 1 e 2 irão imprimir 3 tables referente a localização desejada e imprimir 3 tabelas uma para o ranking geral de todos os nomes mais utilizados na região e outras 2 tabelas com os rankings separado por sexo masculino e feminino,  a opção três o usuário digitará o nome desejado e uma tabela será impressa  mostrando o uso desse nome ao longo dos anos.</p>

## Requisitos
- Ruby 2.7.0
## Começando 

Para começar devemos fazer um  [ clone do projeto ](https://github.com/penhalver02/search_ibge), e em seguida mudar para a pasta do projeto e rodar o comando:
 ```
    bin/setup
```
que instalara as dependências e criar o banco de dados o que pode levar alguns minutos, para inicializar o sistema devemos rodar o comando:
```
    ruby lib/ibge.rb
```

## Teste

Para rodar os testes, utilize o comando abaixo:
 ```
    rspec
```

## Gem utilizadas

- gem 'activesupport'
- gem 'faraday'
- gem 'pry'
- gem 'rake'
- gem 'rspec'
- gem 'rubocop'
- gem 'sqlite3'
- gem 'webmock'

## TODO

- teste de sistema
- separar cidades e estados em tabelas de diferentes

