class OrdersController < ApplicationController
  before_action :confirm_params, only: [:confirm]

  def index
  end

  def new
   @order = Order.new
   @customer = current_customer
   @addresses = current_customer.addresses
  end


  def confirm

   # @test = params[:order]

     return if @order.valid?
       @payment_method = params[:order][:payment_method]
      if params[:order][:address_option] == "0"
        @order.postalcode = current_customer.postalcode
        @order.delivery_address = current_customer.address
        @order.delivery_name = current_customer.family_name

      elsif params[:order][:address_option] == "1"
        address = Address.find(params[:order][:id])
        @order.postalcode = address.postalcode
        @order.delivery_address = address.address
        @order.delivery_name = address.delivery_name
      end
      render 'confirm'

      # else
      #   @order.postalcode = params[:order][:postalcode]
      #   @order.delivery_address = params[:order][:new_address]
      #   @order.delivery_name = params[:order][:delivery_name]

  end

  def thanks

  end

  def create
    @order = Order.new(order_params)
    @order.save
    redirect_to orders_thanks_path
  end

  def show
  end

  def edit
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postalcode, :delivery_address, :delivery_name, :postage, :total_price, :payment_method, :order_status)

  end

  def confirm_params
    @order = Order.new(params.require(:order).permit(:postalcode, :delivery_address, :delivery_name, :payment_method))
  end
end
