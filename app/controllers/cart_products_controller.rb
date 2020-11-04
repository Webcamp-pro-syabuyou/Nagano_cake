class CartProductsController < ApplicationController
  before_action :authenticate_customer!
  def create
    @cart_product = CartItem.new(cart_item_params)
    @cart_product.customer_id = current_customer.id
    if current_customer.cart_products.find_by(product_id: params[:cart_product][:product_id]).present?
    # product_id: params[:cart_product][:product_id])[ ]が2つ続く記述はどんな意味？product_idを指定するのになぜ2つパラメーターが必要？
    #cart_productsテーブルにすでに同じproductがあった時に、個数をプラスさせるための記述
    current_customer.cart_products.find_by(product_id: params[:cart_product][:product_id]).quantity += params[:cart_product][:quantity]
    current_customer.cart_products.find_by(product_id: params[:cart_product][:product_id]).save
    #見本ではsaveになっているがupdateじゃないのか？


    elsif @cart_product.save
      flash[:notice] = "New Product was successfully added to cart."
      # redirect_to show画面
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
    # 商品詳細ページから受け取るもの
    #   ・cart_product.id(hidden_field)
    #   ・quantity(text_field)
    id = params[:cart_product][:id]
    cart_product = CartProduct.find(params[:id])
    if params[:cart_product][:quantity] == "0"
      cart_product.destroy
    # elsif params[:cart_product][:quantity].is_a?(String)
    #   @cart_products = current_customer.cart_products
    #   render 'cart_products/index'
    else
      cart_product.update(quantity: params[:cart_product][:quantity])
    redirect_to cart_products_path
    end
  end

  def destroy
    # CartProduct.find(params[:id]).destroy
    # 上記の記述だとcustomer_idの指定の指定ができずcustomerにかかわらず同じ商品全てのレコード持ってくる、ログイン機能実装後したの記述に入れ替え
    # current_customersを使わずに複数のレコードを持ってきた場合には、destroyでは挙動しない
    current_customer.cart_products.find(params[:id]).destroy
    redirect_to cart_products_path
  end

  def destroy_all
    # CartProduct.all.destroy_all
    current_customer.cart_products.destroy_all
    # current_customerのuser_idが入ったcart_productsテーブルのレコードを全て削除
    redirect_to cart_products_path
  end

  private
  def cart_item_params
    params.require(:cart_product).permit(:product_id, :quantity)
  end

end
