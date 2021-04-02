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
|Bill|bill.jobs@smartflix.com.br|123456|


## Rotas da API 

| Resource | Ação | Método | URL |
| ----- | ------ | ------ | ------ |
| CPF | Retorna situação de um CPF | GET | /api/v1/cpfs/:cpf |
| Cobrança | Consulta dados de determinada cobrança através do :token único | GET | /api/v1/payments/:token  |
| Cobrança | Cria nova cobrança | POST | /api/v1/payments |
| Meios de pagamento | Retorna lista dos meios de pagamentos ativos | GET | /api/v1/payment_methods |
| Fraude | Recebe informações de fraude envolvendo um determinado CPF | POST | /api/v1/fraud_events |

## CPF

### ``GET /api/v1/cpfs/:cpf``

#### Parâmetros: 

``:cpf  (obrigatório)``

##### Sucesso:

``status:  200``

```json
// CPF bloqueado
{
  "blocked": true 
}

// CPF aprovado
{
  "blocked": false 
}
```

##### Erros:

``status:  400``

```json
{
  "error_message": 'CPF inválido' 
}
```

## Cobrança

### ``GET /api/v1/payments/:token``

#### Parâmetros: 

``:token  (obrigatório token único da cobrança)``

##### Sucesso:

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

##### Erros:

``status:  404``

```JSON
{
  "message": "não encontrado"
}
```

### ``POST /api/v1/payments``

#### Parâmetros (todos obrigatórios, exceto ``:discount_price`` ): 

```json
{
  "payment":
    { 
      "payment_method_id": 1,
      "customer_token": 'a1s2d3f4',
      "cpf": '12312312312',
      "plan_id": '1',
      "plan_price": 100.00,
      "discount_price": 90.00 // opcional
    }
}
```

##### Sucesso:

``status:  201``

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

##### Erros:

``status:  422``

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


##### Sucesso:

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

## Fraude

### ``POST /api/v1/fraud_events``

#### Parâmetros (todos são obrigatórios)

- cpf: string

- description: string

- event_severity: string ou number

  Valor aceito para **event_severity** pode ser uma string ou número de acordo com a tabela abaixo:

  | Chave  | Valor |
  | ------ | ----- |
  | "low"  | 0     |
  | "high" | 10    |

  

```json
{
  "fraud_event":
    { 
      "cpf": "45113083577",
      "description": "Descrição de teste",
      "event_severity": "low"
    }
}
```


##### Sucesso:

``status:  201``

```json
{
    "id": 5,
    "cpf": "45113083577",
    "event_severity": "low",
    "description": "Descrição de teste"
}
```

##### Erros

###### CPF inválido

```status: 422```

```json
{
    "error_message": [
        "CPF deve ser válido"
    ]
}
```

###### Atributo ausente 

* Nesse exemplo o atributo ```description``` não foi enviado

```status: 422```

```json
{
    "error_message": [
        "Descrição não pode ficar em branco"
    ]
}
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