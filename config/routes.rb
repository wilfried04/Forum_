Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #get 'sessions/new'
  get 'comments/create'
  root 'topics#index'
  resources :topics
  resources :topics do
    resources :comments
  end
 

end
