Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'home#index'
  get '/auth/shopify/credentials', to: 'shopify_login#index'
  get '/auth/shopify/redirect', to: 'shopify_callback#callback'
  get '/redirect', to: 'shopify_redirect#index'
  get '/home', to: 'home#index'
end
