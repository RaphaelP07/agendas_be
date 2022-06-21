class RenameColumnInMeeting < ActiveRecord::Migration[7.0]
  def up
    rename_column :meetings, :agenda, :name
  end
  def down
  end
end
