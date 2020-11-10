Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'homes#top'
  get 'homes/about' => 'homes#about'
  delete 'cart_products/destroy_all' => 'cart_products#destroy_all'
  get 'customers/resign' => 'custmers#resign'
  patch 'customers/resign' => 'customers#resign_update'
  get 'orders/thanks' => 'orders#thanks' 
  
  resource :customers,except: :create do
  resources :addresses
   end
  resources :products, only: [:index,:show]
  resources :genres, only: [:index] do
  end
  resources :order_products
  resources :cart_products, only:[:create, :index, :update, :destroy]
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
 
  namespace :admins do
    resources :orders, only:[:index, :show, :update]
    resources :customers
    resources :products, only: [:index,:new,:create,:show,:edit,:update]
    resources :order_products, only: [:update]
    resources :genres, only: [:index,:edit,:create,:update]
    get 'orders/number' => 'orders#number'
  end
end