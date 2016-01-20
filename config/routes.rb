Rails.application.routes.draw do

  root to: "searches#new"

  get "/result",  to: "searches#show"
  get "/profile", to: "users#show"
  get "/about",   to: "about#show"

  get "/login",                  to: "sessions#new"
  get "/logout",                 to: "sessions#destroy"
  get "auth/:provider/callback", to: "sessions#create"

  resources :searches, only: [:create]

end
