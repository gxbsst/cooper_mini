class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :rank
      t.string :sale_dist
      t.string :provice
      t.string :city
      t.string :dist
      t.string :asr
      t.string :dsr
      t.string :retail_code
      t.string :shop_name
      t.string :shop_type
      t.string :longitude
      t.string :latitude

      t.timestamps
    end
  end
end
