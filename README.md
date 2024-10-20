# PrizeDraw
Este é o projeto PrizeDraw, uma aplicação Elixir Phoenix para criação de sorteios, onde usuários podem participar de sorteios e serem selecionados como vencedores.

## Funcionalidades
- Criação de sorteios: Qualquer usuário pode criar sorteios com um nome e uma data.
- Participação em sorteios: Usuários podem se inscrever em sorteios ativos.
- Execução de sorteios: No horário agendado, um sorteio é executado automaticamente para selecionar um vencedor.
- API Pública: A aplicação expõe uma API REST para interagir com sorteios e participações.

## Pré-requisitos
Antes de começar, certifique-se de ter as seguintes ferramentas instaladas em sua máquina:

- Elixir (versão recomendada: 1.12+)
- Phoenix Framework
- PostgreSQL
- Docker (opcional, mas recomendado para rodar em um ambiente containerizado)
- Oban para agendamento de tarefas em background

## Configuração do projeto
1. Clone este repositório:
```
git clone https://github.com/mingyar/prize_draw.git
```
2. Acesse o diretório do projeto:
```
cd prize_draw
```
3. Instale as dependências do projeto:
```
mix deps.get
```
4. Crie o banco de dados e execute as migrações:
```
mix ecto.setup
```
5. Inicie o servidor Phoenix:
```
mix phx.server
```
A aplicação estará disponível em http://localhost:4000.

## Usando a API
### Endpoints

- Criar sorteio
`/api/draw/` - `POST`
- Exemplo de payload
```
{
	"draw": {
		"name": "Novo sorteio",
		 "date": "2024-10-14"
	}
}
```

- Participar de sorteio
`/api/entrant/` - `POST`
- Exemplo de payload
```
{
  "entrant": {
    "user_id": 1,
    "draw_id": 1
  }
}
```

- Registrar usuário
`/api/user/` - `POST`
- Exemplo de payload:
```
{
  "user": {
	  "email": "jose@email.com",
	  "name": "José"
  }
}
```

- Consultar resultado do sorteio
`/api/draw/:draw_id/winner` - `GET`
- Exemplo de chamada para api
`/api/draw/6/winner/`

## Rodando no Docker
1. Crie a imagem do Docker:
```
docker build -t prize_draw .
```
2. Execute o container:
```
docker run -p 4000:4000 prize_draw
```
A aplicação estará disponível em http://localhost:4000.
