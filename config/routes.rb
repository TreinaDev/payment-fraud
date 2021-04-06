Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords' }

  resources :payment_methods, only: %i[index new create show edit update] do
      post 'disable', on: :member
      post 'activate', on: :member
  end


  namespace 'api', defaults: { format: :json } do
    namespace 'v1' do
      resources :payment_methods, only: [:index]
      resources :cpfs, only: [:show], param: :cpf
      resources :payments, only: %i[ show create update ], param: :token
      resources :fraud_events, only: %i[create]
    end
  end

  resources :receipts, only: %i[ show ], param: :token
end
