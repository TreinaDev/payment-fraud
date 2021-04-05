## Sistema de Pagamentos e Fraudes + API

Este sistema é responsável pela gestão de pagamentos e fraudes na plataforma Smartflix. As informações podem ser acessadas por um usuário autenticado com o domínio @smartflix.com.br. Além disso o sistema fornece endpoints via API para que outros sistemas da plataforma possam acessar os dados cadastrados.

## Features:

:heavy_check_mark: Consulta de situação de um CPF

:heavy_check_mark: Bloqueio de CPF

:heavy_check_mark: Gestão dos meios de pagamentos

:heavy_check_mark: Emitir cobranças

:heavy_check_mark: Gestão de fraudes 

## Requisitos:

- [Ruby 2.7.2](https://www.ruby-lang.org/pt/)
- [Rails 6.1.3](https://rubyonrails.org/)
- [NodeJS](https://nodejs.org/en/docs/)
- [Yarn](https://yarnpkg.com/)


## Dependências (Gems):

- [devise (~> 4.7.3) ](https://github.com/heartcombo/devise)
- [FactoryBots Rails (6.1.0) ](https://github.com/thoughtbot/factory_bot_rails)
- [Faraday (1.3.0) ](https://github.com/lostisland/faraday)
- [CPF_CNPJ (0.5.0) ](https://github.com/fnando/cpf_cnpj)

## Como rodar a aplicação :arrow_forward:

No terminal, clone o projeto: 

```
git clone https://github.com/TreinaDev/payment-fraud
```

Abra o diretório pelo terminal

```bash
cd  payment-fraud
```

Rode o script bin setup para configurar o projeto

```bash
bin/setup
```

Para inicializar o servidor:

```bash
rails s
```

A aplicação estará disponível na porta: *http://localhost:5000*

## Configurando o banco de dados

Para popular o projeto, utilize o comando:
```
$ rails db:seed 
```

Teste a aplicação com o Usuário: 

|name|email|password|
| -------- |-------- |-------- |
|Roberto|roberto@smartflix.com.br|123456|


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
  "payment_method": "CRT CREDIT",
  "plan_price": "100.0",
  "discount_price": "90.0"
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

Parâmetros (todos obrigatórios, exceto ``:discount_price`` ): 

```javascript
{
  payment:
    { 
      payment_method_id: 1,
      customer_token: 'a1s2d3f4',
      cpf: '12312312312',
      plan_id: '1',
      plan_price: 100.00,
      discount_price: 90.00 // opcional
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
  "status": "pending",
  "plan_price": 100.00,
  "discount_price": 90.00
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
    "max_installments": 4, 
    "code": "CRT CREDIT", 
    "icon": {
      "id": 1,
      "blob": {
        "key": "8751nvuq66gtd9vfj8cl1lsdu1p2",
        "filename": "mastercardd_icon.svg"
      }
    }
  },
  { 
    "id": 2, 
    "name": "Boleto", 
    "max_installments": 1, 
    "code": "BOLET", 
    "icon": {
      "id": 1,
      "blob": {
        "key": "x8s2l0nyon8jrv32yo54e0tqox38",
        "filename": "boleto.svg"
      }
    }
  }
]
```

## Desenvolvedores

- https://github.com/crisaito
- https://github.com/chrisleo-usa
- https://github.com/le-santos
- https://github.com/mauroroc
- https://github.com/juniorivn
- https://github.com/RCOliveira98
- https://github.com/joaorsalmeida
- https://github.com/HenriqueMorato