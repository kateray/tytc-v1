Tytc::Application.routes.draw do
  match "/signup" => "users#new"
  match "/login" => "user_sessions#new"
  match "/logout" => "user_sessions#destroy"
  match "/auth/:provider/callback" => "user_sessions#callback"
  match "/save" => "users#update"
  # match "/about" => "user_sessions#about"
  resources :users
  resources :links
  resources :comments
  resources :votes
  resources :taggings
  resources :tags
  resources :user_sessions
  match "/:username" => "users#show"
  root :to => "links#index"
end
