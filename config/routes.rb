Rails.application.routes.draw do
  resources :products
  resources :orders, only: [:index, :show, :create, :destroy]

  root 'static_pages#landing_page'

  get 'landing', to: 'static_pages#landing_page'

  get '/products', to:'products#index'

  get  '/about',   to: 'static_pages#about'


  get  '/contact', to: 'static_pages#contact'

  get  'index',    to: 'static_pages#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end 
