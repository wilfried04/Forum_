Rails.application.routes.draw do

  devise_for :users, controllers: {
   omniauth_callbacks: 'users/omniauth_callbacks'
   }

  resources :users, only: %i[show index]

  root 'topics#index'
  resources :topics do
    resources :comments
  end


end
