class AddRimToProducts < ActiveRecord::Migration
  def change
    add_column :products, :rim, :string

  end
end
