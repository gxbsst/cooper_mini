module Refinery
  module Infos
    module Admin
      class InfosController < ::Refinery::AdminController

        crudify :'refinery/infos/info', :xhr_paging => true

      end
    end
  end
end
