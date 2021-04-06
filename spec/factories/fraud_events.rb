FactoryBot.define do
  factory :fraud_event do
    cpf { '53282085796' }
    event_severity { :high }
    description { 'Fraud Event' }
  end
end
