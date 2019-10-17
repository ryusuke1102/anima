Rails.application.routes.draw do
  post "likes/:post_id/destroy" => "likes#destroy"
  post "likes/:post_id/create" => "likes#create"

  post "logout" => "users#logout"
  get "login" => "users#login_form"
  post "login" => "users#login"

  post "users/create" => "users#create"
  get "users/:id/edit" => "users#edit"
  post "users/:id/update" => "users#update"
  post "users/:id/destroy" => "users#destroy"
  get 'users/index'
  get "users/:id" => "users#show"
  get "signup" => "users#new"


  get "login" => "users#login_form"
  get '/users',to:'users#index'
  get '/posts',to:'posts#index'
  root 'home#top'

  resources :users
  resources :posts
end
