FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@smartflix.com.br" }
    password { '123456789' }
  end
end
