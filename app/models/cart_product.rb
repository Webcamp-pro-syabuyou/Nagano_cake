class CartProduct < ApplicationRecord
  belongs_to :customer
  belongs_to :product

  validates :quantity, numericality: :only_integer

  # def tax_included_price
  #   (quantity * product.price * 1.1).floor
  #   # 戻り値はreturn書かなくてもok
  # end

end
