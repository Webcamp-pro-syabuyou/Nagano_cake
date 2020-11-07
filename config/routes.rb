Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'homes#top'
  get 'homes/about' => 'homes#about'
  
     resource :customers,except: :create do
     resources :addresses
   end
   
   resources :products
   resources :order_products
   resources :cart_products
   
   resources :orders do
     collection do 
       post :confirm
    end
  end

  devise_for :customers ,controllers: {
    sessions: 'customers/sessions',
    registrations: 'customers/registrations'
  }

  devise_for :admins  ,controllers: {
    sessions: 'admins/sessions'
  }

  delete 'cart_products/destroy_all' => 'cart_products#destroy_all'
  get 'customers/resign' => 'customers#resign'
  get 'orders/thanks' => 'orders#thanks'
  post 'orders/confirm' => 'orders#confirm'
  
  patch 'customers/resign' => 'customers#resign_update'
  
  namespace :admins do
    resources :orders
    resources :customers
    resources :products
    resources :order_products do
      resources :genres
    end
    get 'orders/number' => 'orders#number'
  end
end




