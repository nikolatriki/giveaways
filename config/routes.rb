Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  get 'users/:id', to: 'users#show', as: :user
  
  root 'giveaways#index'

  resources :giveaways do
    resources :comments, :pictures
    resources :claims, only: [:create]
  end
  namespace :dashboard do
    get 'pages', to: 'pages#home'
    root 'pages#home'
  end
  

end
