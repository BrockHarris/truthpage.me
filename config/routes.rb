Truthpage::Application.routes.draw do 

  match '/signin',  :to => 'authentications#new'
  match '/signout', :to => 'sessions#destroy'
  match '/contact', :to => 'pages#contact'
  match '/home',   :to => 'pages#home'
  match '/help',    :to => 'pages#help'
  match '/feedback',    :to => 'pages#feedback'
  match '/privacy',    :to => 'pages#privacy'
  match '/terms',    :to => 'pages#terms'
  match '/',        :to => 'pages#home'
  match "/auth/:provider/callback" => "authentications#create"
  match "/auth/failure" => "authentications#auth_failure"
  
  resources :microposts
  resources :users do
      member do
        get :following, :followers
      end
  end
  resources :authentications
  resources :sessions,   :only => [:new, :create, :destroy]
  resources :microposts, :only => [:create, :destroy]
  resources :relationships, :only => [:create, :destroy]

  root :to => 'pages#home'
 
end
