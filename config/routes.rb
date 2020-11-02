Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'homes#top'
  get 'homes/about' => 'homes#about'

  devise_for :admins
  devise_for :customers do

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


 resource :custmers
 resources :address
 resources :orders
 resources :products
 resources :order_products
 resources :cart_products


end
end
