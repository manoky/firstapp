Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout'},
  controllers: { registrations: "user_registrations" }
  
  resources :products do
    resources :comments
  end
  resources :users
  resources :orders, only: [:index, :show, :create, :destroy]
  resources :charges, only: [:new, :create]


  root 'static_pages#landing_page'

  get 'landing', to: 'static_pages#landing_page'

  get '/products', to:'products#index'

  get  '/about',   to: 'static_pages#about'

  get  '/contact', to: 'static_pages#contact'

  get  'index',    to: 'static_pages#index'
  
  post 'static_pages/thank_you'

  post 'charges/create'

  get 'charges/create'
  
  mount ActionCable.server => '/cable'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end 
