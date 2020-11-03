Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'homes#top'
  get 'homes/about' => 'homes#about'

  devise_for :admins
  devise_for :customers 

  delete 'cart_products/destroy_all' => 'cart_products#destroy_all'
  get 'customers/resign' => 'custmers#resign'
  get 'orders/thanks' => 'orders#thanks'
  post 'orders/confirm' => 'orders#confirm'
  
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
 
 resources :orders do
   collection do 
     post :confirm
  end
end
 resources :products
 resources :order_products
 resources :cart_products
end

