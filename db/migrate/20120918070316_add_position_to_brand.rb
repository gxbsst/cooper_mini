class AddPositionToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :position, :string

  end
end
