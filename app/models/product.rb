class Product < ApplicationRecord
  belongs_to :genre

  has_many :cart_products, dependent: :destroy
  has_many :order_products, dependent: :destroy

  attachment :image

  validates :name, presence: true
  validates :price, presence: true
  validates :is_active, inclusion: [true, false]
  # validates :is_active, presence: true だとfalseが入ったときに弾かれてしまうので上の記述に変更
  validates :genre_id, presence: true

  def tax_price
    (self.price * 1.1).floor
  end


end
