Rails.application.routes.draw do

  root to: "searches#new"

  get "/about",   to: "about#show"

  get "auth/:provider/callback", to: "sessions#create"

  resources :searches, only: [:create]

end
