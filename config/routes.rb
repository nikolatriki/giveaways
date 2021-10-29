Rails.application.routes.draw do
  get 'users/:id', to: 'users#show', as: :user
  devise_for :users
  
  root 'giveaways#index'

  resources :giveaways do
    resources :comments, :pictures
  end
end
