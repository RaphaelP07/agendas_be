class CreateOrganisations < ActiveRecord::Migration[7.0]
  def change
    create_table :organisations do |t|
      t.string :name, null: false
      t.string :city_address
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
