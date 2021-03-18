Rails.application.routes.draw do
  devise_for :users

  namespace 'api' do
    namespace 'v1' do
      resources :payments, only: %i[ show create ]
    end
  end
end
