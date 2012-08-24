class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :url
      t.string :norm
      t.string :tyre
      t.string :aspect_ratio
      t.string :diameter
      t.string :brand
      t.string :car_type
      t.string :decorative

      t.timestamps
    end
  end
end
