class CartProductsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @cart_product = CartProduct.new(cart_product_params)
    @cart_product.customer_id = current_customer.id
    if current_customer.cart_products.find_by(product_id: params[:cart_product][:product_id]).present?
      cart_product = current_customer.cart_products.find_by(product_id: params[:cart_product][:product_id])
      cart_product.quantity += params[:cart_product][:quantity].to_i
      cart_product.save
      flash[:notice] = "商品をカートに入れました"
      redirect_to cart_products_path
    elsif @cart_product.save
      flash[:notice] = "商品をカートに入れました"
      redirect_to cart_products_path
    end
  end

  def index
    @cart_products = current_customer.cart_products
    @cart_product = CartProduct.new
    @total_price = current_customer.cart_products.cart_products_total_price(@cart_products)
  end

  def update
    id = params[:cart_product][:id]
    @cart_product = CartProduct.find(params[:id])
    if params[:cart_product][:quantity] == "0"
      @cart_product.destroy
      flash[:notice] = "商品を削除しました"
      redirect_to cart_products_path
    elsif @cart_product.update(quantity: params[:cart_product][:quantity])
      flash[:notice] = "商品数を変更しました"
      redirect_to cart_products_path
    else
      @cart_products = current_customer.cart_products
      @total_price = current_customer.cart_products.cart_products_total_price(@cart_products)
      render "cart_products/index"
    end
  end

  def destroy
    current_customer.cart_products.find(params[:id]).destroy
    flash[:notice] = "商品を削除しました"
    redirect_to cart_products_path
  end

  def destroy_all
    current_customer.cart_products.destroy_all
    flash[:notice] = "カート内全商品を削除しました"
    redirect_to cart_products_path
  end

  private
  def cart_product_params
    params.require(:cart_product).permit(:product_id, :quantity)
  end

end