class CreateMeetings < ActiveRecord::Migration[7.0]
  def change
    create_table :meetings do |t|
      t.string :agenda
      t.text :notes
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
