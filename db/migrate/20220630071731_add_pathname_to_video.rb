class AddPathnameToVideo < ActiveRecord::Migration[7.0]
  def change
    add_column :videos, :pathname, :string
  end
end
