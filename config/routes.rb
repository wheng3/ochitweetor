Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "pages#home"
  get '/login_with_twitter', to: redirect('/auth/twitter')
  get '/auth/twitter/callback', to: "sessions#create"
  get '/logout', to: "sessions#destroy"
  resource :session, only: [:create, :destroy]
end
