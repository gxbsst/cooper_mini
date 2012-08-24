class AddTelephoneToStores < ActiveRecord::Migration
  def change
    add_column :stores, :telephone, :string

  end
end
