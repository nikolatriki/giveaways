Rails.application.routes.draw do
  root 'giveaways#index'
  resources :giveaways
end
