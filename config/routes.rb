Truthpage::Application.routes.draw do 

  match '/:id', :to => 'users#show'
  match 'users/:id' => 'users#show'
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/signup', :to => 'identities#new'
  match '/contact', :to => 'pages#contact'
  match '/home',   :to => 'pages#home'
  match '/help',    :to => 'pages#help'
  match '/feedback',    :to => 'pages#feedback'
  match '/privacy',    :to => 'pages#privacy'
  match '/terms',    :to => 'pages#terms'
  match '/',        :to => 'pages#home'
  match '/tickertest', :to=>'pages#tickertest'
  match "/auth/:provider/callback" => "authentications#create"
  match "/auth/failure" => "authentications#auth_failure"
  
  resources :microposts
  resources :users do
      member do
        post :follow
        post :unfollow
        get :following, :followers
      end
  end
  resources :authentications
  resources :sessions,   :only => [:new, :create, :destroy]
  resources :microposts, :only => [:create, :destroy]
  resources :relationships, :only => [:create, :destroy]
  resources :identities

  namespace :admin do
    resources :users
  end

  root :to => 'pages#home'

 
end
