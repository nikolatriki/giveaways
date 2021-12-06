Rails.application.routes.draw do
  devise_for :users
  get 'users/:id', to: 'users#show', as: :user
  
  root 'giveaways#index'

  resources :giveaways, only: %i[index show] do
    resources :comments, :pictures
    resources :claims, only: [:create]
  end

  namespace :dashboard do
    get 'pages', to: 'pages#home'
    root 'pages#home'
    resources :giveaways
    resources :claims, only: [:index]
  end
end
