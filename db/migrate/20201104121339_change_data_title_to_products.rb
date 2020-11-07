class ChangeDataTitleToProducts < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :sales_status, :boolean
  end
end
