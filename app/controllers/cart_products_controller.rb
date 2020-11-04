class CartProductsController < ApplicationController
  before_action :authenticate_customer!


  def create
    @cart_product = CartProduct.new(cart_product_params)
    @cart_product.customer_id = current_customer.id
    if current_customer.cart_products.find_by(product_id: params[:cart_product][:product_id]).present?
      cart_product = current_customer.cart_products.find_by(product_id: params[:cart_product][:product_id])
      cart_product.quantity += params[:cart_product][:quantity].to_i
      cart_product.save
      redirect_to cart_products_path
    elsif @cart_product.save
      flash[:notice] = "New Product was successfully added to cart."
      redirect_to cart_products_path
    else
      # render 'show画面'
    end
  end

  def index
    @cart_products = current_customer.cart_products

    array = [] #空の配列を用意し、
    current_customer.cart_products.all.each do |cart_product|
      array << cart_product.product.price * cart_product.quantity
    #in_cart_productのpriceを１件ずつ取り出したものと、cart_productsのpriceカラムのデータの積を配列に入れる
    end
    @total_price = (array.sum * 1.1).floor #ここで合計を求める
  end


  def update
    id = params[:cart_product][:id]
    cart_product = CartProduct.find(params[:id])
    if params[:cart_product][:quantity] == "0"
      cart_product.destroy
    else
      cart_product.update(quantity: params[:cart_product][:quantity])
    redirect_to cart_products_path
    end
  end

  def destroy
    current_customer.cart_products.find(params[:id]).destroy
    redirect_to cart_products_path
  end

  def destroy_all
    current_customer.cart_products.destroy_all
    redirect_to cart_products_path
  end

  private
  def cart_product_params
    params.require(:cart_product).permit(:product_id, :quantity)
  end

end
