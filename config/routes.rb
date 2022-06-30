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
        resources :meetings do
          resources :videos
          post '/videos/render', to: 'videos#render_meeting'
          post '/videos/:id/status', to: 'videos#render_status'
        end
        post '/meetings/:id/invite', to: 'meetings#send_invite'
        get '/meetings/:id/participants', to: 'meetings#show_participants'
      end

      # Third-party APIs
      get '/daily_co/rooms', to: 'daily_co#rooms'
      get '/daily_co/room/:name', to: 'daily_co#room'
      get '/api_video/videos', to: 'api_video#videos'
      get '/api_video/video', to: 'api_video#video'
      get '/api_video/video/status', to: 'api_video#status'
      post '/api_video/upload', to: 'api_video#upload'
      delete '/api_video/delete', to: 'api_video#delete'
      get '/shotstack/templates', to: 'shotstack#templates'
      get '/shotstack/template', to: 'shotstack#template'
      post '/shotstack/create_template', to: 'shotstack#create_template'
      post '/shotstack/render', to: 'shotstack#render_meeting'
      get '/shotstack/render', to: 'shotstack#render_status'
      post '/shotstack/webhook', to: 'shotstack#webhook'
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
