FactoryBot.define do
  factory :receipt do
    token_receipt { 1 }
    number_installments { 1 }
    payment { nil }
  end
end
