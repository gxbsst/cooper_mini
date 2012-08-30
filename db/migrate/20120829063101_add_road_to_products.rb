class AddRoadToProducts < ActiveRecord::Migration
  def change
    add_column :products, :road, :string

  end
end
