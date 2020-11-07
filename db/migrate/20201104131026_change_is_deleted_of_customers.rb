class ChangeIsDeletedOfCustomers < ActiveRecord::Migration[5.2]
  def up
   change_column :customers, :is_deleted , :boolean , default: 'false'
  end

  def down
   change_column  :customers, :is_customer_status ,:boolean
  end
end
