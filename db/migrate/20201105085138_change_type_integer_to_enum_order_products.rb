class ChangeTypeIntegerToEnumOrderProducts < ActiveRecord::Migration[5.2]
  def change
    change_column :order_products, :product_status, :integer
  end
end