# README

Antes de executa o projeto, abiaxo se emcontra os dados/requisitos que foram necessário 
para o desenvolvimento deste software.

1. - [x] Cria um CRUD de municipios.
2. - [x] Não deleta.
3. - [x] Status ativo e inativo.
5. - [x] Duas paginas de listagem.
6. - [x] Tela de cadastro.
7. - [x] Opções para navegar;
8. - [x] Ter uma entidade relacionada a municipio cidadãos
9. - [x] Nome completo.
10. - [x] Cpf 
11. - [x] Dmail
12. - [x] Cns
13. - [x] Data de nascimento
14. - [x] Telefone
15. - [x] Data de nascimento
16. - [x] Foto 
17. - [x] Status 
18. - [x] Todos campos do municipo são obrigatorio e cidadao.
19. - [x] Cpf cns email devem ser validos  
20. - [x] Status
21. - [x] Data de nascimento 
22. - [x] Valide os campos impossiveis e improvaveis de serem válidos. 
23. - [x] Foto da pessoa deve ser tamanho difrente para servi varios casos.
24. - [x] Ter uma entidade chamada endereço.
25. - [x] Salva o endereço ao municipo.
25. - [x] Cep logradour complemento bairro cidade uf codigo ibge.
25. - [x] Todos são obrigatorios exceto complemento e codigo ibge.
25. - [x] Após cria e atualiza um municipio salva o endereço ao municipo
25. - [x] deve manda um email e sms ao mesmo informado sobre o cadastro de suas informaçoes e quando o seu status sofre alteração.
25. - [ ] filtros por municipio por seus dados nele e endereço .
25. - [x] minimizar o maximo possivel a negegação do usuario.
25. - [x] Otimizar, setps edeploys com docker.
25. - [x] TESTE respec
25. - [x] Ruby
25. - [x] Ruby on rails e postgres.
25. - [ ] Elastic/kafka
25. - [x] Utliza uma abordagem spa.

## Como configura o projeto ?

Tecnologias utilizads:
- Ruby 3.0.2
- Rails 7
- React 18
- Javascript
- Docker
- docker-compose

Há duas maneiras de levanta o projeto
---
##### OBS: entre no projeto /backend-om30-flauzino
#### Com apenas o banco em docker
  * para subir o banco de dados execute
```shell
docker-compose build
docker-compose up db_om30
```
*  para executa o backend
  * dentro do projeto execute
```shell
bundle install 
rails db:drop db:create db:migrate db:seed 
rails s
```
* para executa o front-end entre no arquivo /front-end-om30-flauzino e rode
```shell
npm install && npm run start 
```
#### Com todos os serviços no docker
* Para levanta o banco de dados front-end e backend execute
```shell
docker-compose build
docker-compose up 
```
* para roda os testes em rspec execute
```shell
docker exec -it web bundle exec rspec
```
* para configura o projeto execute
    * o comando abaixo reseta, drop cria, migra tabelas e popula 
```shell
docker exec -it web bundle exec rails db:drop db:create db:migrate db:seed
```
##### Abra o navegador na url http://localhost:3000 ou http://0.0.0.0:3000
