Rails.application.routes.draw do
  root to: "search#new"

  get "/result", to: "results#show"
  post "/result", to: "results#create"

  get "/profile", to: "users#show"
end
