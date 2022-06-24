Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  default_url_options :host => "localhost:3000"
  namespace :api do
    namespace :v1 do
      get '/current_user', to: 'current_user#index'
      post '/users/name', to: 'current_user#name'
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
      
      get '/organisations/admin_of', to: 'organisations#admin_of'
      post '/organisations/join', to: 'organisations#join'
      post '/organisations/:id/invite', to: 'organisations#invite_to_org'
      delete '/organisations/:id/remove', to: 'organisations#remove_member'
      get '/organisations/:id/members', to: 'organisations#show_members'
      resources :organisations do
        resources :teams
        get '/teams/:id/members', to: 'teams#show_members'
        post '/teams/:id/add', to: 'teams#add_member'
        delete '/teams/:id/remove', to: 'teams#remove_member'
        resources :meetings
        post '/meetings/:id/send_invite', to: 'meetings#send_invite'
      end
      get '/rooms', to: 'daily_co#rooms'
      get '/room/:name', to: 'daily_co#room'
      post '/auth', to: 'api_video#auth'
      get '/videos', to: 'api_video#videos'
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
