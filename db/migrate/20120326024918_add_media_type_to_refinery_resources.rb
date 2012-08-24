class AddMediaTypeToRefineryResources < ActiveRecord::Migration
  def change
    add_column :refinery_resources, :media_type, :string
  end
end
