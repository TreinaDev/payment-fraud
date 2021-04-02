# gem
require 'cpf_cnpj'
# Usuário admin
User.create!(first_name: 'Bill',
              last_name: 'Jobs',
              email: 'bill.jobs@smartflix.com.br', 
              password:'123456') 

# Payment_methods
FactoryBot.create(:payment_method, { status: :active })
FactoryBot.create(:payment_method, { name: 'Boleto', 
                                      code: 'BOLET', 
                                      max_installments: 1,
                                      status: :active })

FactoryBot.create(:payment_method, { name: 'Pix',
                                      code: 'PIX',
                                      max_installments: 1,
                                      status: :active })


# Payment
FactoryBot.create(:payment)
FactoryBot.create(:payment, { status: 5 })
FactoryBot.create(:payment, { status:  10 })

# FraudEvent
3.times do
  FactoryBot.create(:fraud_event, {
      cpf: CPF.generate,
      event_severity: :low,
      description: 'Descrição da fraude1'
  })
end

FactoryBot.create(:fraud_event, {
    cpf: CPF.generate,
    event_severity: :high,
    description: 'Descrição da fraude de nível alto'
})

# NegativeList
FactoryBot.create(:negative_list, {
    cpf: CPF.generate,
    expiration_date: 1.month.from_now,
})

FactoryBot.create(:negative_list, {
    cpf: CPF.generate,
    expiration_date: 1.month.from_now,
})

# User
3.times do
  FactoryBot.create(:user)
end
