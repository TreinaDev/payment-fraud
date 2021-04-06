FactoryBot.define do
  factory :receipt do
    sequence(:token_receipt) { |n| "12345678#{n}" }
    number_installment { 1 }
    payment { association :payment }
  end
end
