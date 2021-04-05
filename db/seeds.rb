# User
FactoryBot.create(:user, { first_name: 'Bill', last_name: 'Jobs', email: 'bill.jobs@smartflix.com.br', password:'123456'}) 
FactoryBot.create(:user, { first_name: 'Roberto', last_name: 'Silva', email: 'roberto@smartflix.com.br', password: '123456'})

# Payment_methods
FactoryBot.create(:payment_method)
FactoryBot.create(:payment_method, { name: 'Boleto', 
                                      code: 'BOLET', 
                                      max_installments: 1,
                                      status: 'active' })

FactoryBot.create(:payment_method, { name: 'Pix',
                                      code: 'PIX',
                                      max_installments: 1,
                                      status: 'active' })

# Payment
FactoryBot.create(:payment)
FactoryBot.create(:payment, { status: 5 })
FactoryBot.create(:payment, { status:  10 })

# FraudEvent
3.times do
  FactoryBot.create(:fraud_event, {
      cpf: '50797753001',
      event_severity: 0,
      description: 'Descrição da fraude1'
  })
end

FactoryBot.create(:fraud_event, {
    cpf: '02299118039',
    event_severity: 1,
    description: 'Descrição da fraude de nível alto'
})

# NegativeList
FactoryBot.create(:negative_list, {
    cpf: '24779779030',
    expiration_date: 1.month.from_now,
})

FactoryBot.create(:negative_list, {
    cpf: '39563911016',
    expiration_date: 1.month.from_now,
})
