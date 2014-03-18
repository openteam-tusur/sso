require 'sidekiq/web'

Sso::Application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'

  devise_for :users, :controllers => { :registrations => 'registrations',
                                       :sessions      => 'sessions',
                                       :passwords     => 'passwords' }
  devise_scope :user do
    get '/sign_out' => 'sessions#destroy', :as => :sign_out
  end

  # omniauth client stuff
  #get '/auth/:provider/callback', :to => 'authentications#create'
  #get '/auth/failure',            :to => 'authentications#failure'

  # Provider stuff
  get  '/oauth/user'      => 'auth#user'
  post '/oauth/token'     => 'auth#access_token'
  get  '/oauth/authorize' => 'auth#authorize'

  root :to => 'auth#welcome'
end
