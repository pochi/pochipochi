Pochipochi::Application.routes.draw do
  get 'sign_up' => 'users#new', :as => 'sign_up'
  resources :users
  resources :bookmarks

  root :to => "bookmarks#index"
end
