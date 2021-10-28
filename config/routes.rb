Rails.application.routes.draw do
  devise_for :users
  
  root 'giveaways#index'

  resources :giveaways do
    resources :comments, :pictures
  end
end
