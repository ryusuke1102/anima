Rails.application.routes.draw do
  get '/posts',to:'posts#index'

  root 'home#top'

end
