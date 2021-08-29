Rails.application.routes.draw do
  root 'giveaways#index'
  resources :giveaways do
    resources :comments
  end
end
