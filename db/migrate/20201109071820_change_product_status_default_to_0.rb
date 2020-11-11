class ChangeProductStatusDefaultTo0 < ActiveRecord::Migration[5.2]
  def change
    change_column :order_products, :product_status, :integer, :default => 0
  end
end
