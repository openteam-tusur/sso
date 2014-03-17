Sso::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'registrations',
                                       :sessions      => 'sessions',
                                       :passwords     => 'passwords' }

  # omniauth client stuff
  #get '/auth/:provider/callback', :to => 'authentications#create'
  #get '/auth/failure',            :to => 'authentications#failure'

  # Provider stuff
  get  '/oauth/user'      => 'auth#user'
  post '/oauth/token'     => 'auth#access_token'
  get  '/oauth/authorize' => 'auth#authorize'

  root :to => 'auth#welcome'
end
