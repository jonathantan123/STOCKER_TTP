Rails.application.routes.draw do

  Rails.application.routes.draw do
    namespace :api do
      namespace :v1 do
        resources :users
        resources :transactions
      end  
    end 
    
      post '/login', to: 'login#login'
      get '/find/:id', to: 'find#find'
      
    end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
