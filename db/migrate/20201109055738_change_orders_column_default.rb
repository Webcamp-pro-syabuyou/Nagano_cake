class ChangeOrdersColumnDefault < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :postage, :integer, :default => 800
    # change_column_default :orders, :postage, to:800
  end
end
