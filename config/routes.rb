Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  namespace :api do
    namespace :v1 do
      get '/current_user', to: 'current_user#index'
      devise_for :users, path: '', path_names: {
        sign_in: 'login',
        sign_out: 'logout',
        registration: 'signup'
      },
      controllers: {
        sessions: 'api/v1/users/sessions',
        registrations: 'api/v1/users/registrations',
        confirmations: 'api/v1/users/confirmations',
        omniauth_callbacks: 'api/v1/users/omniauth'
      }
      
      resources :organisations do
        resources :teams
        get '/teams/:id/members', to: 'teams#show_members'
        post '/teams/:id/add', to: 'teams#add_member'
        delete '/teams/:id/remove', to: 'teams#remove_member'
      end
      post '/organisations/join', to: 'organisations#join'
      delete '/organisations/:id/remove', to: 'organisations#remove_member'
      get '/rooms', to: 'daily_co#rooms'
      get '/room/:name', to: 'daily_co#room'
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
