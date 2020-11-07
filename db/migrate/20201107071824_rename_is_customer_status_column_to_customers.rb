class RenameIsCustomerStatusColumnToCustomers < ActiveRecord::Migration[5.2]
  def change
    rename_column :customers, :is_customer_status, :is_deleted
  end
end
