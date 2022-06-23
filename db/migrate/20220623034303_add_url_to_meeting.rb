class AddUrlToMeeting < ActiveRecord::Migration[7.0]
  def change
    add_column :meetings, :url, :string
  end
end
