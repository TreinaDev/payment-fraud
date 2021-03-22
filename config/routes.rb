Rails.application.routes.draw do
  devise_for :users
  
  namespace 'api', defaults: { format: :json } do
    namespace 'v1' do
      resources :payment_methods, only: [:index]
      resources :cpfs, only: [:show], param: :cpf
      resources :payments, only: %i[ show create ]
    end 
  end
end

