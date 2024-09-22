Rails.application.routes.draw do
  resources :characters
  get "characters/:id/find", to: "characters#character_found?"
  get "users/login_anonymous", to: "users#login_anonymous"
  get "users/set_score", to: "users#set_score"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
