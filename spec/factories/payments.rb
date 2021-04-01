FactoryBot.define do
  factory :payment do
    payment_method { PaymentMethod.last || association(:payment_method) }
    sequence(:cpf) { |n| "1234567890#{n}" }
    sequence(:customer_token) { |n| "a1s2d3#{n}" }
    plan_id { '1' }
    plan_price { 100 }
    status { :pending }
  end
end
