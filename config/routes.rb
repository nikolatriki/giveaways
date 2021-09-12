Rails.application.routes.draw do
  root 'giveaways#index'
  resources :giveaways do
    resources :comments
  end
  get 'users/signup', to: 'users#new'
  resources :users, except: :new
end
