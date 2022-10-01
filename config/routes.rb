Rails.application.routes.draw do
 
 
  get 'searches/search'
  get 'relationships/followings'
  get 'relationships/followers'
   devise_for :users
  root to: 'homes#top'
   get "home/about" => "homes#about" , as: "about"
   get "search" => "searches#search"
  
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resources :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update, :create, :destroy]
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
end
