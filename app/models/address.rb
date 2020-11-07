class Address < ApplicationRecord
  belongs_to :customer
  
  # バリデーション------------------------------------------
  validates :postalcode ,presence: :true
  # validates :address ,presence: :true ,format: {
  #               with: /^[0-9０-９]+$/,
  #               message: "数字7ケタで入力して下さい"
  #               }
  validates :delivery_name ,presence: :true
  #---------------------------------------------------------   
   def order_addresses
    ( self.postalcode + ' ' + self.address + ' ' + self.delivery_name )
   end
end
