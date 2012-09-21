# encoding: utf-8
class Product < ActiveRecord::Base


  class << self
    
    
    def tyre_all_collection
      Product.tyre_collection + [["轮胎直径", 'disable']] + Product.tyre_with_x_collection
    end
    def name_all_collection
      Product.name_collection + [["花纹", 'disable']] + Product.name_with_x_collection
    end
  # 轮胎
    def name_collection
      where(["name not like ?", "%x%"]).group(:name).collect{|p| [("&nbsp;&nbsp;" + p.name).html_safe, p.name]unless p.name.blank? }.compact
    end
    def tyre_collection
      where(["tyre not like ?", "%X%"]).group(:tyre).collect{|p| [("&nbsp;&nbsp;" + p.tyre).html_safe, p.tyre] unless p.tyre.blank? }.compact
    end

    def name_with_x_collection
      where(["name like ?", "%X%"]).group(:name).collect{|p| [("&nbsp;&nbsp;" + p.name).html_safe, p.name] unless p.name.blank? }.compact
    end
    
    def tyre_with_x_collection
      where(["tyre like ?", "%X%"]).group(:tyre).collect{|p| [("&nbsp;&nbsp;" + p.tyre).html_safe, p.tyre] unless p.tyre.blank? }.compact
    end
    
    # 扁平比
    def aspect_ratio_collection
      group(:aspect_ratio).collect{|p| [p.aspect_ratio, p.aspect_ratio] unless p.aspect_ratio.blank? }.compact
    end
    
    # 直径
    def diameter_collection
      group(:diameter).collect{|p| [p.diameter, p.diameter] unless p.diameter.blank? }.compact
    end
    
    # 品牌
    def brand_collection
      order(:brand).group(:brand).collect{|p| [p.brand, p.brand] unless p.brand.blank? }.compact
    end
    
    # 车型
    def car_type_collection
      group(:car_type).collect{|p| [p.car_type, p.car_type] unless p.car_type.blank? }.compact
    end
    
    # 花纹
    def decorative_collection
      group(:decorative).collect{|p| [p.decorative, p.decorative] unless p.decorative.blank?  }.compact
    end
    
  end

end
