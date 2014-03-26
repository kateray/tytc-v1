Tytc::Application.routes.draw do




  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :links do
    get :autocomplete_tag_name, :on => :collection
  end

  resources :comments
  resources :votes
  resources :taggings
  resources :tags

  put "/save" => "users#update"
  get "/:username" => "users#show"

  root :to => "links#index"
end
