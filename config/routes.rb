Rails.application.routes.draw do
<<<<<<< HEAD
  devise_for :users
  root 'home#index'

  resources :payment_methods, only: %i[index new create show edit update] do
      post 'disable', on: :member
      post 'activate', on: :member
  end
=======
  root 'home#index'

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
>>>>>>> 8ae71212b39f8e288e2728aefb18035d412a6683

  namespace 'api', defaults: { format: :json } do
    namespace 'v1' do
      resources :payment_methods, only: [:index]
      resources :cpfs, only: [:show], param: :cpf
      resources :payments, only: %i[ show create update ], param: :token
    end
  end
end
