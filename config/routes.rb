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
        post '/meetings/:id/invite', to: 'meetings#send_invite'
        get '/meetings/:id/participants', to: 'meetings#show_participants'
      end

      # Third-party APIs
      get '/rooms', to: 'daily_co#rooms'
      get '/room/:name', to: 'daily_co#room'
      get '/videos', to: 'api_video#videos'
      get '/video', to: 'api_video#video'
      get '/video/status', to: 'api_video#status'
      post '/upload', to: 'api_video#upload'
      delete '/delete', to: 'api_video#delete'
      get '/templates', to: 'shotstack#templates'
      get '/template', to: 'shotstack#template'
      post '/create_template', to: 'shotstack#create_template'
      post '/render', to: 'shotstack#render_meeting'
      get '/render', to: 'shotstack#render_status'
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
