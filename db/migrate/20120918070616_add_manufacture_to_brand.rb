class AddManufactureToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :manufacture, :string

  end
end
