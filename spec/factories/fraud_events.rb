FactoryBot.define do
  factory :fraud_event do
    cpf { '53282085796' }
    event_severity { 1 }
    description { 'Fraud Event' }
  end
end
