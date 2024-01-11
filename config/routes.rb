Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # static_pages controller
  root 'static_pages#home'
  # Defines the root path route ("/")
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  # users controller
  # get 'users/new' => change to signup
  get '/signup', to: 'users#new'
end
