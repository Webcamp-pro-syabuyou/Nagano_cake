class ProductsController < ApplicationController


  def index
    @genres = Genre.where(is_active: true)
    if params[:genre_id]
		  @genre = Genre.find(params[:genre_id])
		  @products = @genre.products.order(created_at: :desc).where(is_active: true).page(params[:page])
    else
      @products = Product.where(is_active: true).page(params[:page])
    end
 end

 def show
   @product = Product.find(params[:id])
   @genres = Genre.where(is_active: true)
   @cart_product = CartProduct.new
 end
end