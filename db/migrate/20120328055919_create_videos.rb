class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.string :file_url
      t.string :file_name
      t.string :media_type

      t.timestamps
    end
  end
end
