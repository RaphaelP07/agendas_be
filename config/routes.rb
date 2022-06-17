Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  namespace :api do
    namespace :v1 do
      get '/current_user', to: 'current_user#index'
      devise_for :users, path: '', path_names: {
        sign_in: 'login',
        sign_out: 'logout',
        registration: 'signup'
        # confirmation: 'confirmation'
      },
      controllers: {
        sessions: 'api/v1/users/sessions',
        registrations: 'api/v1/users/registrations',
        confirmations: 'api/v1/users/confirmations',
        omniauth_callbacks: 'api/v1/users/omniauth'
      }
      
      resources :organisations
      post '/organisations/join', to: 'organisations#join'
      get '/rooms', to: 'daily_co#rooms'
      get '/room/:name', to: 'daily_co#room'
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
