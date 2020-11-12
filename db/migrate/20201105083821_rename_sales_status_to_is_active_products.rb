class RenameSalesStatusToIsActiveProducts < ActiveRecord::Migration[5.2]
  def change
    rename_column :products, :sales_status, :is_active
    change_column_default :products, :is_active, to: true
  end
end
