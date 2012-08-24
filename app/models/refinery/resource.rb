# encoding: utf-8
module Refinery
  class Resource < Refinery::Core::BaseModel
    include Resources::Validators

    attr_accessible :id, :file, :media_type, :name, :image_type

    resource_accessor :file

    validates :file, :presence => true
    validates_with FileSizeValidator

    # Docs for acts_as_indexed http://github.com/dougal/acts_as_indexed
    acts_as_indexed :fields => [:file_name, :title, :type_of_content]

    delegate :ext, :size, :mime_type, :url, :to => :file
    
    ## 创建缩略图
    after_save :create_thumb
    
    def create_thumb
      file_mime_types = ["image/jpeg", "image/png", "image/gif"]
      if file_mime_types.include? file_mime_type
        
        file_path = Rails.root.join("public","system","refinery","resources", file_uid)
        file_name = File.basename(file_path, ".*")
        file_dirname = File.dirname(file_path)
        file = MiniMagick::Image.open(file_path)
        
        if image_type == "折页"
          file.resize "320x"
         else
           file.resize "120x"
         end
         
        file.format "jpg"
        file.write(File.join( file_dirname, file_name + "_thumb.jpg" ))
      end 
    end
    
    def thumb_url
      file_mime_types = ["image/jpeg", "image/png", "image/gif"]
      if file_mime_types.include? file_mime_type
        # file_path = Rails.root.join("public","system","refinery","resources", file_uid)
        file_path_dirname = File.dirname(File.join("system", "refinery", "resources", file_uid))
        file_name = File.basename(file_uid, ".*") + "_thumb.jpg"
        file_url = File.join( file_path_dirname, file_name)   
        return file_url     
      end
    end

    # used for searching
    def type_of_content
      mime_type.split("/").join(" ")
    end

    # Returns a titleized version of the filename
    # my_file.pdf returns My File
    def title
      CGI::unescape(file_name.to_s).gsub(/\.\w+$/, '').titleize
    end

    class << self
      # How many resources per page should be displayed?
      def per_page(dialog = false)
        dialog ? Resources.pages_per_dialog : Resources.pages_per_admin_index
      end

      def create_resources(params)
        resources = []

        unless params.present? and params[:file].is_a?(Array)
          resources << create(params)
        else
          params[:file].each do |resource|
            resources << create(:file => resource, :media_type => params[:media_type], :name => params[:name], :image_type => params[:image_type])
          end
        end
        
        resources
      end
    end
  end
end