Rails.application.routes.draw do
  get '/giveaways', to: 'giveaways#index'
  get 'giveaways/:id', to: 'giveaways#show', as: :giveaway

  root 'giveaways#index'
end
