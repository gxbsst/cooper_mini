class AddRoadToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :road, :string

  end
end
