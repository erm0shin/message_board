Rails.application.routes.draw do
  devise_for :users
  get 'persons/profile'

  get 'posts/:id/show', :to => 'posts#show'

  #get '/bundesliga.jpg', :to => 'app/views/layouts/bundesliga.jpg'
  get 'posts/index', :to => 'posts#index'

  mount Ckeditor::Engine => '/ckeditor'
  root to: "posts#index"
  get 'posts/:id/destroy', :to => 'posts#destroy'
  resources :posts
end
