Rails.application.routes.draw do
  get '/giveaways', to: 'giveaways#index'
  get 'giveaways/new', to: 'giveaways#new', as: :new_giveaway
  get 'giveaways/:id', to: 'giveaways#show', as: :giveaway
  post '/giveaways', to: 'giveaways#create'
  get 'giveaways/:id/edit', to: 'giveaways#edit', as: :edit_giveaway
  patch 'giveaways/:id', to: 'giveaways#update'

  root 'giveaways#index'
end
