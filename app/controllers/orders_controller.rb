class OrdersController < ApplicationController
  before_action :order_params, only: [:confirm]
  
  def index
  end

  def new
   @order = Order.new
  end
  
  
  def confiem
  
     return if @order.valid?
     render 'new'
  end  

  
  def thanks
  
  end

  def create 
    @order = Order(order_params)
  end

  def show
  end

  def edit
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postalcode, :delivery_address, :delivery_name, :postage, :total_price, :payment_method, :order_status)
    @order = Order.new(params.require(:order).permit(:postalcode, :delivery_address, :delivery_name, :payment_method))
  end
  
end
