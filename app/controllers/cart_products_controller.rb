class CartProductsController < ApplicationController

  def create
    @cart_product = CartItem.new(cart_item_params)
    @cart_product.customer_id = current_customer.id
    if current_customer.cart_products.find_by(product_id: params[:cart_product][:product_id]).present?
    # product_id: params[:cart_product][:product_id])[ ]が2つ続く記述はどんな意味？product_idを指定するのになぜ2つパラメーターが必要？
    #cart_productsテーブルにすでに同じproductがあった時に、個数をプラスさせるための記述
    current_customer.cart_products.find_by(product_id: params[:cart_product][:product_id]).quantity += params[:cart_product][:quantity].to_i
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
    @cart_products = CartProduct.all
    # 上の記述だとcustomerの指定ができていないので全部持ってきてしまう
    # @cart_products = current_customer.in_cart_products
    # @cart_products = CartProduct.find_by(customer_id: current_customer.id)でもいい？
    # current_customerのidが含まれているレコードだけ欲しい
  end

  def put_in_cart
    @product = Product.find(1)
  end
  # put_in_cartメソッドはpush前に消す

  def update
    cart_product = CartProduct.find(params:[:id])
    # cart_product = current_customer.cart_products.find(id: params[:id])
    # show画面の個数ボックスと変更ボタンをform_withで作成し:product.idと:quantityをparamsで送ってもらうことでレコードの特定ができる
    cart_product.update(quantity: params[:quantity])
    # フォームで受け取ったstring型のquantityをinteger型に変えなければいけない
    # 特定したレコードのquantityカラムをフォームで受け取ったquantityに差し替える
    redirect_to cart_products_path

  end

  def show
  end

  def destroy
    CartProduct.find_by(product_id: params[:id]).destroy
    redirect_to cart_products_path
  end

  def destroy_all
    current_customer.cart_products.destroy_all
    # current_customerのuser_idが入ったcart_productsテーブルのレコードを全て削除
    redirect_to cart_products_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity)
  end

end
