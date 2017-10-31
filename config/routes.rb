Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "user_registrations" }
  resources :users

  resources :products do
    resources :comments
  end
  
  resources :orders, only: [:index, :show, :create, :destroy]
  resources :charges, only: [:new, :create]


  root 'static_pages#landing_page'

  get 'landing', to: 'static_pages#landing_page'

 

  get  '/about',   to: 'static_pages#about'

  get  '/contact', to: 'static_pages#contact'

  get  'index',    to: 'static_pages#index'
  
  post 'static_pages/thank_you'

  post 'charges/create'

  get 'charges/create'
  
  mount ActionCable.server => '/cable'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end 
