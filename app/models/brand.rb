class Brand < ActiveRecord::Base
  
  class << self
    
    def brand_collection
      order("CONVERT( brand_name_zh USING gbk)").group(:brand_name_zh).collect{|s| [s.brand_name_zh] unless s.brand_name_zh.blank? }.compact
    end
    
    def car_type_collection
      order("CONVERT( car_type_zh USING gbk)").group(:car_type_zh).collect{|s| [s.car_type_zh] unless s.car_type_zh.blank? }.compact
    end

    def decorative_collection
       group(:name).collect{|s| [s.name,s.name] unless s.name.blank? }.compact
    end
  end
end
