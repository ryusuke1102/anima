Rails.application.routes.draw do
  #post "likes/:post_id/destroy" => "likes#destroy"
  #post "likes/:post_id/create" => "likes#create"

  post "logout" => "users#logout"
  get "login" => "users#login_form"
  post "login" => "users#login"

  get '/users',to:'users#index'
  post "users/:id/update" => "users#update"
  get "users/:id" => "users#show"
  get "signup" => "users#new"
  post '/signup',  to: 'users#create'

  get "posts/new"
  post 'posts/create'
  get 'posts/:id/edit' => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" =>"posts#destroy"
  get '/posts',to:'posts#index'
  root 'home#top'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :posts
  resources :account_activations, only: [:edit]
  resources :relationships,       only: [:create, :destroy]
  resources :likes,               only: [:create, :destroy]
end
