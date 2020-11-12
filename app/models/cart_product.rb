class CartProduct < ApplicationRecord
  belongs_to :customer
  belongs_to :product

  validates :quantity, numericality: :only_integer

  def subtotal
    (quantity * product.price * 1.1).floor
  end

  def self.cart_products_total_price(cart_products)
    array = []
    cart_products.each do |cart_product|
      array << cart_product.product.price * cart_product.quantity
    end
    return (array.sum * 1.1).floor
  end

end