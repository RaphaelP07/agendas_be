class CreateJoinTableUserOrganisation < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :organisations do |t|
      t.index [:user_id, :organisation_id]
      t.index [:organisation_id, :user_id]
    end
  end
end
