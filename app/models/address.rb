class Address < ApplicationRecord
  belongs_to :customer

  validates :postalcode ,presence: :true
  validates :postalcode, format: {with: /\A[0-9]{7}\z/}
  validates :address ,presence: :true
  validates :delivery_name ,presence: :true

   def order_addresses
    ( self.postalcode + ' ' + self.address + ' ' + self.delivery_name )
   end

end
