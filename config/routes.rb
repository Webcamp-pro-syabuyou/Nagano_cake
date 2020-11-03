Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


   get "cart_products/put_in_cart" => "cart_products#put_in_cart"
  # push前に削除

    root 'homes#top'
    get 'homes/about' => 'homes#about'

    devise_for :customers
    devise_for :admins


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
