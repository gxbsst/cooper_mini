class AddImageTypeToRefineryResources < ActiveRecord::Migration
  def change
    add_column :refinery_resources, :image_type, :string

  end
end
