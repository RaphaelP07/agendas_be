class RemoveUserIdFromMeetings < ActiveRecord::Migration[7.0]
  def change
    remove_column :meetings, :user_id, :integer
  end
end
