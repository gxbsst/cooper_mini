class ChangeStoresLatitude < ActiveRecord::Migration
  def up
    change_column :stores, :latitude, :float
    change_column :stores, :longitude, :float
  end

  def down
    change_column :stores, :latitude, :string
    change_column :stores, :longitude, :string
  end
end