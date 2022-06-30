class RenameTypeFromVideo < ActiveRecord::Migration[7.0]
  def change
    remove_column :videos, :type, :string
    add_column :videos, :video_type, :string
  end
end
