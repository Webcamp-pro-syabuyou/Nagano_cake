class OrdersController < ApplicationController
  before_action :order_params, only: [:confirm]
  
  def index
  end

  def new
   @order = Order.new
  end
  
  
  def confirm

       
     return if @order.valid?
     render 'confirm'
  end  

  
  def thanks
  
  end

  def create 
    @order = Order.new(order_params)
    @order.save
    redirect_to 'thanks'
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
