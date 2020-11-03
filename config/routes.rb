Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'homes#top'
  get 'homes/about' => 'homes#about'
  
  # 11/3 追記=========================================================================================
  # devise_for :customers ,skip: :all
  # devise_scope :customers do
  #   get 'customers/sign_in' => 'customers/sessions#new', as: :new_customers_session
  #   post 'customers/sign_in' => 'customers/sessions#create', as: :customers_session
  #   get 'customers/sign_up' => 'customers/registrations#new' ,as: :new_customers_registration
  # end
  
  # devise_for :admins ,skip: :all
  # devise_scope :admins do
  #   get 'admins/sign_in' => 'admins/sessions#new', as: :new_admins_session
  #   post 'admins/sign_in' => 'admins/sessions#create', as: :admins_session
  # end
  # ===================================================================================================
  

  devise_for :admins ,controllers: {
    sessions: 'admins/sessions'
  }
  
  devise_for :customers ,controllers: {
    sessions: 'customers/sessions',
    registrations: 'customers/registrations'
  }

  
  delete 'cart_products/destroy_all' => 'cart_products#destroy_all'
  get 'customers/resign' => 'custmers#resign'
  get 'orders/thanks' => 'orders#thanks'

  namespace :admins do
    resources :orders
    resource :customers
    resources :products
    resources :order_products do
      resources :genres
    end
    get 'orders/number' => 'orders#number'
  end

   resource :custmers do
     resources :address
   end
   resources :orders
   resources :products
   resources :order_products
   resources :cart_products

end

