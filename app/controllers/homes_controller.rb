class HomesController < ApplicationController

  def top
    @genres = Genre.where(is_active: true)
    if params[:genre_id]
  		@genre = Genre.find(params[:genre_id])
  		@products = @genre.products.order(created_at: :desc).where(is_active: true).page(params[:page])
    else
      @products = Product.where(is_active: true).page(params[:page])
    end

    @product_first = Product.find_by(id: 1)
    @product_second = Product.find_by(id: 2)
    @product_third = Product.find_by(id: 3)
    @product_fourth = Product.find_by(id: 4)

  end

  def about
  end
end
