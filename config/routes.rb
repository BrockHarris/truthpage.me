Truthpage::Application.routes.draw do 
  
 




  resources :users do
      member do
        get :following, :followers
      end
  end
  resources :sessions,   :only => [:new, :create, :destroy]
  resources :microposts, :only => [:create, :destroy]
  resources :relationships, :only => [:create, :destroy]
 
  
  
  
  get "sessions/new"

  get "users/new"

  get "pages/home"

  get "pages/contact"

  get "pages/feedback"

  get "pages/privacy"

  get "pages/terms"
  
  get "pages/help"

  
  match '/signup',  :to => 'users#new'
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/contact', :to => 'pages#contact'
  match '/home',   :to => 'pages#home'
  match '/help',    :to => 'pages#help'
  match '/feedback',    :to => 'pages#feedback'
  match '/privacy',    :to => 'pages#privacy'
  match '/terms',    :to => 'pages#terms'
  match '/',        :to => 'pages#home'
  match "/auth/:provider/callback" => "sessions#omnicreate"
  resources :microposts

  resources :users
  resources :sessions, :only => [:new, :create, :destroy]

  
  
  root :to => 'pages#home'
  

 
end
