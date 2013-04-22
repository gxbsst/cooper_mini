# encoding: utf-8
class Store < ActiveRecord::Base
  set_table_name :shops

  attr_accessible :address, :city, :dist, :full_address, :latitude, :longitude, :provice, :shop_name, :shop_type
  class << self
    # 省
    def province_collection
      group(:provice).collect{|s| [s.provice, s.provice] unless s.provice.blank? }.compact
    end

    # 市
    def city_collection
      group(:city).collect{|s| [s.city, s.city] unless s.city.blank? }.compact
    end

    # shop_type
    def shop_type_collection
      group(:shop_type).collect{|s| [s.shop_type, s.shop_type] unless s.shop_type.blank? }.compact
    end


    def city_collection_by_parent_id(parent_id)
      where("city IS  NOT NULL ").where(:provice => parent_id).group(:city)
      #.collect{|c| [c.city, c.city] unless s.city.blank?}.compact
    end

  end
end
