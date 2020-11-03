class Order < ApplicationRecord
  has_many :order_products, dependent: :destroy
  belongs_to :customer
  
  enum paymecnt_method: {クレジットカード:1, 銀行振込:2}
 
  
end  

