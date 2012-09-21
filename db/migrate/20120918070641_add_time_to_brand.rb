class AddTimeToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :time, :string

  end
end
