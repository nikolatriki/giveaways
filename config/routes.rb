Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get 'users/:id', to: 'users#show', as: :user
  
  root 'giveaways#index'

  resources :giveaways, only: %i[index show] do
    resources :comments, :pictures
    resources :claims, only: [:create]
  end
  namespace :dashboard do
    resources :claims, only: [:index]
    resources :giveaways do
      resources :pitures
    end 
    get 'pages', to: 'pages#home'
    get 'pages/tables', to: 'pages#tables'
    root 'pages#home'
  end
  

end
