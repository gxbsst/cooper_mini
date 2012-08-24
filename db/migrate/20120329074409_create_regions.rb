class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.integer :parent_id
      t.string :region_name
      t.integer :region_type

      t.timestamps
    end
  end
end
