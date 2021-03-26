FactoryBot.define do
  factory :payment do
    payment_method { nil }
    cpf { 'MyString' }
    customer_token { 'MyString' }
    plan_id { 'MyString' }
    status { 'pending' }
  end
end
