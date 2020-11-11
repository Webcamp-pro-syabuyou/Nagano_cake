class SearchesController < ApplicationController

  def search
    @range = params[:range]
    @word = params[:word]
    if @range == "1"
      @customers = Customer.where('family_name like ? or first_name like ? or family_name_kana like ? or first_name_kana like ?',"%#{@word}%","%#{@word}%","%#{@word}%","%#{@word}%")
    elsif @range == "2"
      @products = Product.where('name like ? or introduction like ?',"%#{@word}%","%#{@word}%")
    end
  end

  def search_form
  end

end
