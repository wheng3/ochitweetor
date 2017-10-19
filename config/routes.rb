Rails.application.routes.draw do
  get 'users/new'

  get 'users/create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "pages#home"

  #Twitter user
  get '/login_with_twitter', to: redirect('/auth/twitter')
  get '/auth/twitter/callback', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  #Site user
  resources :users, only: [:new, :create, :edit, :update]
  resources :sessions, only: [:create, :new]

  #Twilio
  post 'twilio/sms' => 'twilio#sms'

end
