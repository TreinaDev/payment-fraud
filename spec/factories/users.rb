FactoryBot.define do
  factory :user do
    first_name { 'Steve' }
    last_name { 'Gates' }
    sequence(:email) { |n| "steve.gates#{n}@smartflix.com.br" }
    password { '123456' }
  end
end
