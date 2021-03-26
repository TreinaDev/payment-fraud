FactoryBot.define do
  factory :payment do
    payment_method { PaymentMethod.last || association(:payment_method) }
    cpf { '12345678900' }
    customer_token { 'a1s2d3' }
    plan_id { '1' }
    status { :pending }
  end
end
