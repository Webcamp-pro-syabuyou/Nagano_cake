class Order < ApplicationRecord
  has_many :order_products, dependent: :destroy
  belongs_to :customer

  enum payment_method: {クレジットカード:0, 銀行振込:1}
  enum order_status:  {入金待ち:0, 入金確認:1, 製作中:2, 発送準備中:3, 発送済み:4}

  validates :postalcode, presence: true
  validates :delivery_name, presence: true
  validates :delivery_address, presence: true

   def address_already_registerd?(current_customer)
     current_customer.address != delivery_address && current_customer.addresses.where(address: delivery_address).empty?
   end

end