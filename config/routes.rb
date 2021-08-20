Rails.application.routes.draw do
  root 'giveaways#home'
  get 'giveaways/home', to: 'giveaways#home'
  
  resources :giveaways
  
end
