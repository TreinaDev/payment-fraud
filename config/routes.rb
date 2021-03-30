Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :payment_methods, only: %i[index new create show edit update] do
      post 'disable', on: :member
      post 'activate', on: :member
  end

  namespace 'api', defaults: { format: :json } do
    namespace 'v1' do
      resources :payment_methods, only: [:index]
      resources :cpfs, only: [:show], param: :cpf
      resources :payments, only: %i[ show create update ], param: :token
    end
  end
end
