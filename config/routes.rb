Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }
  get 'users/:id', to: 'users#show', as: :user
  get 'contacts', to: 'contacts#new'
  post 'contacts', to: 'contacts#create'

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
