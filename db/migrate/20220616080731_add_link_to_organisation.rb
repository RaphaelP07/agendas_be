class AddLinkToOrganisation < ActiveRecord::Migration[7.0]
  def change
    add_column :organisations, :link, :string
  end
end
