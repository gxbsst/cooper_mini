class RemoveDescriptionFromBrand < ActiveRecord::Migration
  def up
    remove_column :brands, :description
      end

  def down
    add_column :brands, :description, :string
  end
end
