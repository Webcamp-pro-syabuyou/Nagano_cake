class ProductsController < ApplicationController


  def index
      @genres = Genre.where(is_genres_status: true)
     	# もしURLに[:genre_id]が含まれていたら
    	if params[:genre_id]
    		# その[:genre_id]のデータをGenreから@genreに入れて
    		@genre = Genre.find(params[:genre_id])
  	    # @genreに紐付いた商品で販売可の商品を持ってくるイメージ。全件抽出する（あとでカウントしたいので）
    		@products_all = @genre.products.order(created_at: :desc).where(status: true)
        else
        # whereメソッドを使うときは booleanの値を整数に。全件抽出する（あとでカウントしたいので）
        @products_all = Product.joins(:name).where('is_active = 1 and genres.is_active = 1')
        # binding.pry
        end
      # 8件でページをわける
      @products = @products_all.page(params[:page]).per(8)

  end

    def show
        @product = Product.find(params[:id])
        @genres = Genre.where(display_status: true)
        @cart_product = CartProduct.new
    end

end
