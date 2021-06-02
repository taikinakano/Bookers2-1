class RemoveCommentFromFavorites < ActiveRecord::Migration[5.2]
  def change
    remove_column :favorites, :Comment, :text
  end
end
