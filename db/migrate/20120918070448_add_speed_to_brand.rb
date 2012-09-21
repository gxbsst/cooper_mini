class AddSpeedToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :speed, :string

  end
end
