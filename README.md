# PrizeDraw

## Rota para criar usuário
`/api/user/`
### Exemplo de payload:
```
{
  "user": {
	  "email": "jose@email.com",
	  "name": "José"
  }
}
```
## Rota para criar sorteio
`/api/draw/`
### Exemplo de payload
```
{
	"draw": {
		"name": "Novo sorteio",
		 "date": "2023-01-14"
	}
}
```
## Rota para participar de um sorteio
`/api/user/assign_to_draw`
### Exemplo de payload
```
{
	"user": {
		"draw_id": 4,
		"id": 10
	}
}
```
## Rota para consultar o resultado de um sorteio
`/api/draw/execute_draw/:draw_id`
### Exemplo de chamada para api
`api/draw/execute_draw/4`

