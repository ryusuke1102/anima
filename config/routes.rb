Rails.application.routes.draw do
  post "likes/:post_id/destroy" => "likes#destroy"
  post "likes/:post_id/create" => "likes#create"

  post "logout" => "users#logout"
  get "login" => "users#login_form"
  post "login" => "users#login"
  
  get '/users',to:'users#index'
  post "users/create" => "users#create"
  get "users/:id/edit" => "users#edit"
  post "users/:id/update" => "users#update"
  post "users/:id/destroy" => "users#destroy"
  get "users/:id" => "users#show"
  get "signup" => "users#new"

  get "posts/new"
  get "posts/:id" => "posts#show"
  post 'posts/create'
  get 'posts/:id/edit' => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" =>"posts#destroy"
  get "login" => "users#login_form"
  get '/posts',to:'posts#index'
  root 'home#top'

  resources :users
  resources :posts
end
