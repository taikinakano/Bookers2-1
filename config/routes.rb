Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  resources :users,only: [:show,:index,:edit,:update]
  resources :users do
   resource :relationships, only: %i[create destroy]
    member do
      get :followings, :followers
    end
  end
  resources :messages, only: [:create]
  resources :rooms, only: [:create,:show]
  get '/search' => 'search#search'


  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

end