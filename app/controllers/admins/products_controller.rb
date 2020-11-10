class Admins::ProductsController < ApplicationController
  # before_action :authenticate_admin!

  def index

    # kaminari
    @products = Product.page(params[:page]).per(10)
    # binding.pry
  end

  def show
    @product = Product.find(params[:id])
    @genres = Genre.all
    # binding.pry

  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "商品を登録しました"
      redirect_to admins_products_path
    else
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
    # binding.pry
  end


  def update
    @product = Product.find(params[:id])
    # binding.pry

    if @product.update(product_params)
      redirect_to admins_product_path(params[:id])
    else
      render 'edit'
    end
  end

private
  def product_params
    params.require(:product).permit(:image,:name,:price,:introduction,:is_active)
  end

end