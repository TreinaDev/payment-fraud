FactoryBot.define do
  factory :payment do
    payment_method { nil }
    cpf { "MyString" }
    customer_token { "MyString" }
    plan_id { "MyString" }
    status { :pending }
    sequence(:payment_token) { |n| "token-#{n}" }
  end
end
