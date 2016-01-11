Rails.application.routes.draw do
  root to: "search#new"

  get "/result", to: "results#show"
  get "/profile", to: "users#show"
end
