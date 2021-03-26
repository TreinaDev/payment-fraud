## Sistema de Pagamentos e Fraudes + API


## Features:



## Requisitos:
- Ruby 2.7.2
- Rails 6.1.3
- NodeJS
- Yarn

## Instalando:



## Dependências (Gems):
- devise (~> 4.7.3) 
- FactoryBots Rails (6.1.0)
- Faraday (1.3.0)
- CPF_CNPJ (0.5.0)

## Rotas da API 

| Resource | Ação | Método | URL |
| ----- | ------ | ------ | ------ |
| CPF | Retorna situação de um CPF | GET | /api/v1/cpfs/:cpf |
| Cobrança | Consulta dados de determinada cobrança através do :token único | GET | /api/v1/payments/:token  |
| Cobrança | Cria nova cobrança | POST | /api/v1/payments |
| Meios de pagamento | Retorna lista dos meios de pagamentos ativos | GET | /api/v1/payment_methods |



## CPF

### ``GET /api/v1/cpfs/:cpf``

Parâmetros: 

``:cpf  (obrigatório)``

Sucesso:

``status:  200``

```javascript
// CPF bloqueado
{
  blocked: true 
}

// CPF aprovado
{
  blocked: false 
}
```

Erros:

``status:  400``

```javascript
{
  error_message: 'CPF inválido' 
}
```

## Cobrança

### ``GET /api/v1/payments/:token``

Parâmetros: 

``:token  (obrigatório token único da cobrança)``

Sucesso:

``status:  200``

```JSON
{
  "status": "approved",
  "cpf": "12312312312",
  "customer_token": "a1s2d3f4",
  "payment_token": "SC1t7ikkwreA1Fq9Xwcswnz1",
  "payment_method": "CRT CREDIT"
} 

```

Erros:

``status:  404``

```JSON
{
  "message": "não encontrado"
}
```


### ``POST /api/v1/payments``

Parâmetros(todos obrigatórios:): 

```javascript
{
  payment:
    { 
      payment_method_id: 1,
      customer_token: 'a1s2d3f4',
      cpf: '12312312312',
      plan_id: '1' 
    } 
}
```

Sucesso:

``status:  200``

```JSON
{
  "id": 1,
  "payment_method_id": 1,
  "cpf": "12312312312",
  "customer_token": "a1s2d3f4",
  "plan_id": "1",
  "created_at": "2021-03-25T21:11:37.891-03:00",
  "updated_at": "2021-03-25T21:11:37.891-03:00",
  "payment_token": "SC1t7ikkwreA1Fq9Xwcswnz1",
  "status": "pending"
} 
```

Erros:

``status:  404``

```JSON
{
  "errors": 
    [
      "Payment method é obrigatório(a)"
    ]
} 
```


## Meios de Pagamento
### ``GET /api/v1/payment_methods``


Sucesso:

``status:  200``

```JSON
[
  { 
    "id": 1, 
    "name": "Cartão de crédito", 
    "created_at": "2021-03-25 20:47:39.461725000 -0300", 
    "updated_at": "2021-03-25 20:47:39.461725000 -0300", 
    "max_installments": 4, 
    "code": "CRT CREDIT", 
    "status": "active" 
  },
  { 
    "id": 2, 
    "name": "Boleto", 
    "created_at": "2021-03-25 20:47:39.461725000 -0300", 
    "updated_at": "2021-03-25 20:47:39.461725000 -0300", 
    "max_installments": 1, 
    "code": "BOLET", 
    "status": "active" 
  }
]
```