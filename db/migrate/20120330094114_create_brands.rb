class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
      t.string :url
      t.text :description
      t.string :image_url
      t.string :brand_name_zh
      t.string :brand_name_en
      t.string :car_type_zh
      t.string :car_type_en

      t.timestamps
    end
  end
end
