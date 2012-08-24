class AddFileUrlToRefineryResources < ActiveRecord::Migration
  def change
    add_column :refinery_resources, :file_url, :string

  end
end
