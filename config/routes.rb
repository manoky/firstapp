Rails.application.routes.draw do
  resources :products

  root 'static_pages#index'

  get '/products', to:'products#index'

  get  '/about',   to: 'static_pages#about'


  get  '/contact', to: 'static_pages#contact'

  get  'index',    to: 'static_pages#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end 
