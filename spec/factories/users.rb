FactoryBot.define do
  factory :user do
    first_name { 'Steve' }
    last_name { 'Gates' }
    email { 'steve.gates@smartflix.com.br' }
    password { '123456' }
  end
end
