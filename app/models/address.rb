class Address < ApplicationRecord
  belongs_to :customer



   def order_addresses
    ( self.postalcode + ' ' + self.address + ' ' + self.delivery_name )
   end

end
