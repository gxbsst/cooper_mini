class AddSkuToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :sku, :string

  end
end
