module Refinery
  module Jobs
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Jobs

      engine_name :refinery_jobs

      initializer "register refinerycms_jobs plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "jobs"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.jobs_admin_jobs_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/jobs/job'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Jobs)
      end
    end
  end
end
