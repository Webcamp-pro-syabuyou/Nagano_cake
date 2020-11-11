class ChangeIsActiveDufault < ActiveRecord::Migration[5.2]
  def change
    change_column_default :genres, :is_active, from: true, to: nil
  end
end
