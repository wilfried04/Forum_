Rails.application.routes.draw do
  resources :favorites, only: [:create, :destroy, :show]
  devise_for :users, controllers: {
   omniauth_callbacks: 'users/omniauth_callbacks'
   }

  resources :users, only: %i[show index]

  root 'topics#index'
  resources :topics do
    resources :comments
  end

  resources :favorites, only: [:create, :destroy, :index]

end
