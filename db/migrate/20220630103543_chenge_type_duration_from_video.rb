class ChengeTypeDurationFromVideo < ActiveRecord::Migration[7.0]
  def change
    remove_column :videos, :duration, :string
    add_column :videos, :duration, :integer
  end
end
