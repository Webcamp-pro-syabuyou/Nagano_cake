class OrdersController < ApplicationController
  before_action :confirm_params, only: [:confirm]
  before_action :authenticate_customer!

  def index
    @orders = current_customer.orders.all
  end

  def new
    if current_customer.cart_products.empty?
      flash[:notice] = "カートに商品がありません"
      redirect_to products_path
    else
       @order = Order.new
       @customer = current_customer
       @addresses = current_customer.addresses
    end
  end

  def confirm
    @cart_products = current_customer.cart_products
    @cart_product = CartProduct.new
    array = []
    current_customer.cart_products.all.each do |cart_product|
      array << cart_product.product.price * cart_product.quantity
    end
    @cart_price = (array.sum * 1.1).floor
    @total_price = (array.sum * 1.1).floor + 800
    return if @order.valid?
    @payment_method = params[:order][:payment_method]
    if params[:order][:address_option] == "0"
      @order.postalcode = current_customer.postalcode
      @order.delivery_address = current_customer.address
      @order.delivery_name = current_customer.family_name + " " + current_customer.first_name
    elsif params[:order][:address_option] == "1"
      address = Address.find(params[:order][:id])
      @order.postalcode = address.postalcode
      @order.delivery_address = address.address
      @order.delivery_name = address.delivery_name
    end
    render 'confirm'
  end

  def thanks
  end

  def create
    array = []
    current_customer.cart_products.all.each do |cart_product|
      array << cart_product.product.price * cart_product.quantity
    end

    @order = Order.new(
      postalcode: params[:order][:postalcode],
      customer_id: current_customer.id,
      delivery_address: params[:order][:delivery_address],
      delivery_name: params[:order][:delivery_name],
      payment_method: params[:order][:payment_method],
      order_status: params[:order][:order_status],
      postage: params[:order][:postage],
      total_price: params[:order][:total_price])
    @order.save

    if current_customer.address != @order.delivery_address && current_customer.addresses.where(address: @order.delivery_address).empty?
      postalcode = @order.postalcode
      address = @order.delivery_address
      delivery_name = @order.delivery_name
      Address.new(customer_id: current_customer.id,postalcode: postalcode, address: address, delivery_name: delivery_name).save
    end

    @carts = current_customer.cart_products
    @carts.each do |cart_product|
      @cart_product = @order.order_products.new
      @cart_product.order_id = @order.id
      @cart_product.quantity = cart_product.quantity
      @cart_product.product_id = cart_product.product_id
      @cart_product.product_price = cart_product.quantity * cart_product.product.price
      @cart_product.save
    end
    current_customer.cart_products.destroy_all
    redirect_to orders_thanks_path
  end

  def show
    @order = Order.find(params[:id])
    @order_products = @order.order_products
  end

  def edit
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postalcode, :delivery_address, :delivery_name, :payment_method, :total_price, :order_status, :postage)
  end

  def confirm_params
    @order = Order.new(params.require(:order).permit(:customer_id, :postalcode, :delivery_address, :delivery_name, :payment_method, :total_price, :order_status, :postage))
  end
end