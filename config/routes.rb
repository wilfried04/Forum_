Rails.application.routes.draw do


  devise_for :users, controllers:{
    
  }
  resources :users, only: %i[show index]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #get 'sessions/new'

  root 'topics#index'
  resources :topics do
    resources :comments
  end

  resources :favorites, only:[:create, :destroy]


end
