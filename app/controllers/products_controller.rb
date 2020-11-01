class ProductsController < ApplicationController
  def index
    @genres = Genre.all
  end

  def new
  end

  def show
    @products = Product.all
  end

  def edit
  end
  

end
