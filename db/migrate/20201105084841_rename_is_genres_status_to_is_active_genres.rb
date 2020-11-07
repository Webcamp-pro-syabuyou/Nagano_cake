class RenameIsGenresStatusToIsActiveGenres < ActiveRecord::Migration[5.2]
  def change
    rename_column :genres, :is_genres_status, :is_active
    change_column_default :genres, :is_active, to: true
  end
end
