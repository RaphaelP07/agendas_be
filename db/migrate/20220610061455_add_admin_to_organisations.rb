class AddAdminToOrganisations < ActiveRecord::Migration[7.0]
  def change
    add_reference :organisations, :admin, null: false, foreign_key: { to_table: 'users' }
  end
end
