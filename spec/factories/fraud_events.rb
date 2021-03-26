FactoryBot.define do
  factory :fraud_event do
    cpf { 'MyString' }
    event_severity { 1 }
  end
end
