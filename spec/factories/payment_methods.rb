FactoryBot.define do
  factory :payment_method do
    name { "Cartão de crédito" }
    code { "CCRED"}
    max_installments { 10 }
  end
end
