class AddPositionToProducts < ActiveRecord::Migration
  def change
    add_column :products, :position, :string

  end
end
