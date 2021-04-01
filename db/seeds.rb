# Usuário admin
user =  User.create!(first_name: 'Bill', last_name: 'Jobs', email: 'bill.jobs@smartflix.com.br', password:'123456') 

# Payment_methods
ccard_pm = FactoryBot.create(:payment_method, status: :active)
ccard_pm.icon.attach(
  io: File.open(Rails.root.join('spec/support/storage/mastercard_icon.svg')),
  filename: 'mastercard_icon.svg'
)

ticket_pm = FactoryBot.create(:payment_method, name: 'Boleto', 
                              code: 'BOLET', 
                              max_installments: 1, status: :active)
ticket_pm.icon.attach(
  io: File.open(Rails.root.join('spec/support/storage/boleto.svg')),
  filename: 'boleto.svg'
)

pix_pm = FactoryBot.create(:payment_method, name: 'Pix',
                           code: 'PIX',
                           max_installments: 1, status: :active)
pix_pm.icon.attach(
  io: File.open(Rails.root.join('spec/support/storage/pix.svg')),
  filename: 'pix.svg'
)


# Payment
FactoryBot.create(:payment)
FactoryBot.create(:payment, { status: 5 })
FactoryBot.create(:payment, { status:  10 })

# FraudEvent
3.times do
  FactoryBot.create(:fraud_event, {
      cpf: '12345678922',
      event_severity: 0,
      description: 'Descrição da fraude1'
  })
end

FactoryBot.create(:fraud_event, {
    cpf: '12345678933',
    event_severity: 1,
    description: 'Descrição da fraude de nível alto'
})

# NegativeList
FactoryBot.create(:negative_list, {
    cpf: '12345678933',
    expiration_date: 1.month.from_now,
})

FactoryBot.create(:negative_list, {
    cpf: '12345678922',
    expiration_date: 1.month.from_now,
})

# User
FactoryBot.create(:user, { email: 'roberto@smartflix.com.br', password: '123456' })

3.times do
  FactoryBot.create(:user)
end
