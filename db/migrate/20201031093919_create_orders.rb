class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.string :postalcode
      t.string :delivery_address
      t.string :delivery_name
      t.integer :postage
      t.integer :total_price
      t.integer :payment_method
      t.integer :order_status

      t.timestamps
    end
  end
end
