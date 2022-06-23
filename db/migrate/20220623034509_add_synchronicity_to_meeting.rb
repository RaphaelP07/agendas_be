class AddSynchronicityToMeeting < ActiveRecord::Migration[7.0]
  def change
    add_column :meetings, :synchronicity, :string
  end
end
