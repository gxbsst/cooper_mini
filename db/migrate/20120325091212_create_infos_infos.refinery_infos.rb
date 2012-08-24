# This migration comes from refinery_infos (originally 1)
class CreateInfosInfos < ActiveRecord::Migration

  def up
    create_table :refinery_infos do |t|
      t.string :title
      t.integer :visit_count
      t.string :source
      t.text :content
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-infos"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/infos/infos"})
    end

    drop_table :refinery_infos

  end

end
