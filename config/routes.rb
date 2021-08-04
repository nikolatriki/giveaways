Rails.application.routes.draw do
  get '/giveaways', to: 'giveaways#index'

  root 'giveaways#index'
end
