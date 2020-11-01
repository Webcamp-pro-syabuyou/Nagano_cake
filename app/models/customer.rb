class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_products, dependent: :destroy
  has_many :in_cart_products, through: :cart_products, source: :product

  has_many :orders, dependent: :destroy
  has_many :order_products, through: :orders
  has_many :purchased_products, through: :order_products, source: :product

  has_many :addresses, dependent: :destroy


end
