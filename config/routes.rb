ThirdApp::Application.routes.draw do

  resources :users do
    member do
      #creates following_user_path(@user) and followers_user_path(@user)
      get :following, :getfollowers #followers
    end
  end
  resources :sessions, :only => [:new, :create, :destroy]
  resources :microposts, :only => [:new ,:create, :destroy]
  #makes relationships controller create & destroy path
  resources :relationships, :only => [:create, :destroy]
  
  root :to => 'pages#home'
  match '/contact', :to => 'pages#contact'
  match '/about', :to => 'pages#about'
  match '/help', :to => 'pages#help'
  match '/signup', :to => 'users#new'
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
end
