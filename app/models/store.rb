# encoding: utf-8
class Store < ActiveRecord::Base

  #acts_as_gmappable

  # serialize :

  # def gmaps4rails_address
  #    #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
  #    # "#{self.city}, #{self.provice}" 
  #    # "江桥, 上海, 中国"
  #  end

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

  end
end
