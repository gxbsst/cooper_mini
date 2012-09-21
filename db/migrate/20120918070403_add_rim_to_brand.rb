class AddRimToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :rim, :string

  end
end
