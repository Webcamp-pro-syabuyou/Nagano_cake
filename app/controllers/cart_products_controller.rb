class CartProductsController < ApplicationController
  
  def create
    @cart_product = CartItem.new(cart_item_params)
    @cart_product.customer_id = current_customer.id
    if current_customer.cart_products.find_by(product_id: params[:cart_product][:product_id]).present?
    # product_id: params[:cart_product][:product_id])[]が2つ続く記述はどんな意味？product_idを指定するのになぜ2つパラメーターが必要？
    #cart_productsテーブルにすでに同じproductがあった時に、個数をプラスさせるための記述
    #見本ではsaveになっているがupdateじゃないの？
    elsif @cart_product.save
      flash[:notice] = "New Product was successfully added to cart."
      # redirect_to show画面
    else
      # render 'show画面'
    end
  end
  
  def index
    @cart_products = CartProduct.all
  end
  
  def update
  end

  def show
  end

  def destroy
  end
  
  def destroy_all
  end
  
  private
  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity)
  end
  
end
