class CartProduct < ApplicationRecord
  belongs_to :customer
  belongs_to :product

  validates :quantity, numericality: :only_integer

end
