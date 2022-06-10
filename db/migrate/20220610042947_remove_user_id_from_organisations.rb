class RemoveUserIdFromOrganisations < ActiveRecord::Migration[7.0]
  def change
    remove_column :organisations, :user_id, :integer
  end
end
