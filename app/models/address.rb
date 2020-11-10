class Address < ApplicationRecord
  belongs_to :customer
  
  # バリデーション------------------------------------------
  validates :postalcode ,presence: :true
  validates :address ,presence: :true 
  # ,format: {
  #               with: /\A[0-9０-９]\z/,
  #               message: "数字で入力して下さい"
  #               }
  validates :delivery_name ,presence: :true
  #---------------------------------------------------------   
   def order_addresses
    ( self.postalcode + ' ' + self.address + ' ' + self.delivery_name )
   end
end
