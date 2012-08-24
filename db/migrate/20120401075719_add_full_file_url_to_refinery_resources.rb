class AddFullFileUrlToRefineryResources < ActiveRecord::Migration
  def change
    add_column :refinery_resources, :full_file_url, :string

  end
end
