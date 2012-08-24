module Refinery
  module Infos
    class InfosController < ::ApplicationController

      before_filter :find_all_infos
      before_filter :find_page


      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @info in the line below:
        present(@page)
      end

      def show
        @info = Info.find(params[:id])
        @info.visit_count ||= 0
        @info.update_attribute(:visit_count, @info.visit_count + 1)        
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @info in the line below:
        present(@page)
      end

      protected

      def find_all_infos
        params[:page] ||= 1
        if params[:q].present?
          @infos = Info.where(["created_at < ?", Time.now.at_beginning_of_year ]).order('created_at DESC, position ASC').paginate(:page => params[:page], :per_page => 20)
        else
          @infos = Info.where(["created_at > ?", Time.now.at_beginning_of_year]).order('position ASC').paginate(:page => params[:page], :per_page => 20)
        end
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/infos").first
      end

    end
  end
end
