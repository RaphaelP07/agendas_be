class AddDateTimeToMeetings < ActiveRecord::Migration[7.0]
  def change
    add_column :meetings, :schedule, :datetime
  end
end
