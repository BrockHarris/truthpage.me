Truthpage::Application.routes.draw do 
  
  

  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/signup', :to => 'users#new'
  match '/contact', :to => 'pages#contact'
  match '/home',   :to => 'pages#home'
  match '/about',  :to => 'pages#about'
  match '/help',    :to => 'pages#help'
  match '/legal',    :to => 'pages#legal'
  match '/privacy',    :to => 'pages#privacy'
  match '/terms',    :to => 'pages#terms'
  match '/',        :to => 'pages#home'
  match '/tickertest', :to=>'pages#tickertest'
  match "/auth/:provider/callback" => "authentications#create"
  match "/auth/failure" => "authentications#auth_failure"
  match "/search", :to=> "users#index", :as=>"search" #this is the 'friends' link/path consider renaming.
  #user activation etc.
  match '/activate/:id/:activation_code', :to=>"users#activation", :as=>"activate"
  match "/assist", :to=>"users#assist", :as=>"assist"
  match "/reset/:id/:reset_code", :to=>"users#reset", :as=>"reset"
  match "/activate_user/:id", :to=>"users#activate", :as=>"activate_user"
  match "/welcome_user/:id", :to=>"users#welcome", :as=>"welcome_user"

  match "complete_session_authentication_path", :to=>"authentications#complete_session_authentication", :as=>:complete_session_authentication
  
  match ':id', :as => :username, 
                    :via => :get, 
                    :controller => :users, 
                    :action => :show
                  
                    
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

  namespace :admin do
    resources :users
  end
  root :to => 'pages#home'

end