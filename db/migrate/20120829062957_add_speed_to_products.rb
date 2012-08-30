class AddSpeedToProducts < ActiveRecord::Migration
  def change
    add_column :products, :speed, :string

  end
end
