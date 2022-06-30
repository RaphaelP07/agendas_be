class CreateVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :videos do |t|
      t.string :name
      t.string :type
      t.string :upload_status
      t.string :duration
      t.string :render_id
      t.string :render_status
      t.string :embed_url
      t.string :source_url
      t.references :user, foreign_key: true
      t.references :meeting, null: false, foreign_key: true

      t.timestamps
    end
  end
end
