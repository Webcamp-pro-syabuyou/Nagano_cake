class ProductsController < ApplicationController


  def index
      @genres = Genre.where(is_active: true)
     	# もしURLに[:genre_id]が含まれていたら
    	if params[:genre_id]
    		# その[:genre_id]のデータをGenreから@genreに入れて
    		@genre = Genre.find(params[:genre_id])
  	    # @genreに紐付いた商品で販売可の商品を持ってくるイメージ。全件抽出する（あとでカウントしたいので）
    		@products_all = @genre.products.order(created_at: :desc).where(is_active: true)
      else
        # whereメソッドを使うときは booleanの値を整数に。全件抽出する（あとでカウントしたいので）
        @products_all = Product.joins(:genre).where('is_active = 1 and genres.is_active = 1')
        # binding.pry
      end
      # 8件でページをわける
      @products = @products_all

  end

    def show
        @product = Product.find(params[:id])
        @genres = Genre.where(is_active: true)
        @cart_product = CartProduct.new
    end

end
