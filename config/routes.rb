Rails.application.routes.draw do
  devise_for :users
  get 'users/:id', to: 'users#show', as: :user
  
  root 'giveaways#index'

  resources :giveaways do
    resources :comments, :pictures
    resources :claims, only: [:create]
  end
end
