class Product < ApplicationRecord
  belongs_to :genre

  has_many :cart_products, dependent: :destroy
  has_many :order_products, dependent: :destroy
  
  attachment :image
  
  validates :name, presence: true
  validates :price, presence: true
  validates :sales_status, presence: true
  validates :genre_id, presence: true
  
  def tax_price
    (self.price * 1.1).floor
  end

 
end
