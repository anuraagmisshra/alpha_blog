# frozen_string_literal: true

Rails.application.routes.draw do
# Model Context Protocol
post "/mcp", to: "mcp#handle"
get  "/mcp", to: "mcp#handle"
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root to: 'pages#home'
  get 'pages/about'
  get 'feedbacks', to: 'feedback#new'
  post 'feedbacks', to: 'feedback#create'
  resources :articles
  resources :users, except: [:new]
  resources :categories
  resource :two_factor_settings, except: %i[show]
end
