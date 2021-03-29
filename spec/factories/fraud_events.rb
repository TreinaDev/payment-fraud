FactoryBot.define do
  factory :fraud_event do
    cpf { '12345678900' }
    event_severity { 1 }
    description { 'Fraud Event' }
  end
end
