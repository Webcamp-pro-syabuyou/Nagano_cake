class HomesController < ApplicationController 
  def top
     @genres = Genre.where(is_active: true)
     	# もしURLに[:genre_id]が含まれていたら
    	if params[:genre_id]
    		# その[:genre_id]のデータをGenreから@genreに入れて
    		@genre = Genre.find(params[:genre_id])
  	    # @genreに紐付いた商品で販売可の商品を持ってくるイメージ。全件抽出する（あとでカウントしたいので）

    		@products = @genre.products.order(created_at: :desc).where(is_active: true).page(params[:page])
    		#binding.pry
        else
        # whereメソッドを使うときは booleanの値を整数に。全件抽出する（あとでカウントしたいので）
        
        @products = Product.where(is_active: true).page(params[:page])
        
        end
  end
  
  def about
  end
end
