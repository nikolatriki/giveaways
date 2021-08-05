Rails.application.routes.draw do
  get '/giveaways', to: 'giveaways#index'
  get 'giveaways/new', to: 'giveaways#new', as: :new_giveaway
  get 'giveaways/:id', to: 'giveaways#show', as: :giveaway
  post '/giveaways', to: 'giveaways#create'

  root 'giveaways#index'
end
