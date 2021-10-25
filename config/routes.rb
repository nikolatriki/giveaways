Rails.application.routes.draw do
  root 'giveaways#index'

  get '/login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :giveaways do
    resources :comments, :pictures
  end
  get 'users/signup', to: 'users#new'
  resources :users, except: :new
end
