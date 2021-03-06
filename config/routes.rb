Pochipochi::Application.routes.draw do
  get 'log_in' => 'sessions#new', :as => 'log_in'
  get 'log_out' => 'sessions#destroy', :as => 'log_out'
  get 'sign_up' => 'users#new', :as => 'sign_up'

  match "/auth/:provider/callback" => 'sessions#create'
  resources :users
  resources :sessions
  resources :bookmarks

  root :to => "bookmarks#index"
end

