class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :provice
      t.string :city
      t.string :dist
      t.string :shop_name
      t.string :shop_type
      t.float :longitude
      t.float :latitude
      t.string :address
      t.string :full_address

      t.timestamps
    end
    add_index :shops, :provice
    add_index :shops, :city
    add_index :shops, :dist
    add_index :shops, :shop_name
    add_index :shops, :shop_type
    add_index :shops, :longitude
    add_index :shops, :latitude
    add_index :shops, :address
    add_index :shops, :full_address
  end
end

