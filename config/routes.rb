Rails.application.routes.draw do
  resources :organisations
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  namespace :api do
    get '/rooms', to: 'daily_co#rooms'
    get '/room/:name', to: 'daily_co#room'
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
