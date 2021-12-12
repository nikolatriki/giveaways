Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get 'users/:id', to: 'users#show', as: :user
  get 'contacts/new', to: 'contacts#new', as: :new_contact
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
