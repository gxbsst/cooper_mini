module Refinery
  module Infos
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Infos

      engine_name :refinery_infos

      initializer "register refinerycms_infos plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "infos"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.infos_admin_infos_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/infos/info'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Infos)
      end
    end
  end
end
