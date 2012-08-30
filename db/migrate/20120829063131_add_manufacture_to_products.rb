class AddManufactureToProducts < ActiveRecord::Migration
  def change
    add_column :products, :manufacture, :string

  end
end
