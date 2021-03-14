Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post '/create', to: 'complains#create'
      get '/search', to: 'complains#search'
    end
  end
end
