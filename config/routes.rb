Rails.application.routes.draw do
  root to: "search#new"

  get "/result", to: "drugs#show"
  get "/profile", to: "users#show"

  get "/about", to: "about#show"
end
