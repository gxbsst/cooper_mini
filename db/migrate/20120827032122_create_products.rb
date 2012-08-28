class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :url
      t.string :tyre
      t.string :aspect_ratio
      t.string :diameter
      t.string :decorative
      t.string :description
      t.string :image_url
      t.string :name

      t.timestamps
    end
  end
end
