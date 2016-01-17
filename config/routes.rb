Rails.application.routes.draw do

  root to: "search_results#new"

  get "/result",  to: "drugs#show"
  get "/profile", to: "users#show"
  get "/about",   to: "about#show"

  get "/login",                  to: "sessions#new"
  get "/logout",                 to: "sessions#destroy"
  get "auth/:provider/callback", to: "sessions#create"

  resources :search_results, only: [:create]

end
