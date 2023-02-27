Rails.application.routes.default_url_options[:host] = "localhost:3000"
Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    root 'home#index'
    resources :employees
    get '/employee/:id/partners', to: 'partners#show', as: 'partners'
    get '/home', to: 'home#index', as: 'filter'
    get '/login', to: 'login#index', as: 'login'
    post 'login/index'
    get 'home/signout'
end
