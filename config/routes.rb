Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  namespace :api do
    namespace :v1 do
      devise_for :users
      resources :organisations
      get '/rooms', to: 'daily_co#rooms'
      get '/room/:name', to: 'daily_co#room'
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
