# encoding: utf-8
require 'csv'

namespace :app do
  desc "TODO"
  task :init_product => :environment do
    name = []
    file_name = "tires.csv"
    csv = CSV.read(Rails.root.join('lib', 'tasks', 'data', file_name))
    csv.each do |i|
      puts i[0]
      product_item = {
        :decorative => i[0].to_s.force_encoding("UTF-8"), 
        :name => i[1].to_s.force_encoding("UTF-8"),
        :image_url => i[2].to_s.force_encoding("UTF-8"),
        :description => i[3].to_s.force_encoding("UTF-8"),
        :url => i[4].to_s.force_encoding("UTF-8"), 
        :tyre => i[5].to_s.force_encoding("UTF-8"), 
        :aspect_ratio => i[6].to_s.force_encoding("UTF-8"), 
        :diameter => i[7].to_s.force_encoding("UTF-8")
      }
      @product = Product.create(product_item)
    end
    # (1..18).each do |v|
    #   file_name = "#{v}.csv"
    #   csv = CSV.read(Rails.root.join('lib', 'tasks', 'data', 'product', file_name))
    #   ## save to database
    #   csv.each do |i|
    #     
    #     i[4] =~ /(L?T?|\d{3})\/(\d+R)(.+)/i
    #     tyre = $1
    #     aspect_ratio = $2
    #     diameter = $3
    #     
    #     @product = Product.create({:tyre => tyre, 
    #                     :aspect_ratio => aspect_ratio, 
    #                     :diameter => diameter,
    #                     :name => i[0],
    #                     :image_url => i[1],
    #                     :description => i[2],
    #                     :url => i[3] })
    #        
    #     ## 如果为空，则匹配不成功， 手动添加
    #     name << i[4] if(@product.tyre.blank?)
    #     puts "#{@product.id} => #{i[4]} #{tyre} = #{aspect_ratio} = #{diameter}"          
    #   end
    # 
    #   open('saved_items', 'w') do |file|
    #     name.each do |n|
    #       file << "product_id: #{@product.id}, #{file_name}--#{name}\n"
    #     end
    #   end
    #   puts "====== #{file_name} END ========"
    # end
  end # end init_products
  
  ## 更新描述和图片
  task :init_store => :environment do
    file_name = "store.csv"
    csv = CSV.read(Rails.root.join('lib', 'tasks', 'data', file_name))
    csv.each do |item|
      # puts item[0]
      item[2] =  "" if item[2].nil?
      item[3] = "" if item[3].nil?
      item[13] = "Others" if item[13].blank? || item[13] == 'CC'
      
      # full_address = ""
      
      shop_types = {"CPC" => "嘉车坊", "CTCC" => "替换中心",  "CSS+" => "店招店" ,  "CSS" => "招牌店",  "INDENPENDENT" => "独立授权店" , "OTHERS" => "其他" }
     
      if item[13].blank?
        shop_type = "OTHERS"
      else
        shop_type = item[13].upcase
      end
      
      address = item[10] == '0' ?  address = "" : item[10].to_s.force_encoding("UTF-8") 
                   
      Store.create({rank: item[0].to_s.force_encoding("UTF-8"),
                    sale_dist: item[1].to_s.force_encoding("UTF-8"),
                    provice: item[2].to_s.force_encoding("UTF-8"),
                    city: item[3].to_s.force_encoding("UTF-8"),
                    dist: item[4].to_s.force_encoding("UTF-8"),
                    asr: item[5].to_s.force_encoding("UTF-8"),
                    dsr: item[6].to_s.force_encoding("UTF-8"),
                    telephone: item[12].to_s.force_encoding("UTF-8"),
                    retail_code: item[7].to_s.force_encoding("UTF-8"),
                    shop_name: item[8].to_s.force_encoding("UTF-8"),
                    address: address,
                    full_address: (item[2] + item[3] +  shop_types["#{item[13].upcase}"]).to_s.force_encoding("UTF-8"),
                    shop_type: shop_type })
    end
    
  end
  
  ## 更新店地址经纬度
  task :update_store_tuge => :environment do 
  Store.all.each do |r|
    tuge = Geocoder.coordinates(r.address) unless r.address.blank?
    r.update_attributes(:longitude => tuge[0], :latitude => tuge[1]) unless tuge.blank?
  end
  end
  
  task :init_video => :environment do
    yaml = YAML::load(open(Rails.root.join('lib', 'tasks', 'data','video.yml')))
    yaml.each do |key, value|
       value["name"] = key
       Video.find_or_create_by_name(value)
    end
  end
  
  ## Init Regions Of stores
  task :init_region => :environment do 
    file_name = "store.csv"
    csv = CSV.read(Rails.root.join('lib', 'tasks', 'data', file_name))
    ranks = []
    csv.each do |item|
      item[2].to_s.force_encoding("UTF-8")
      item[3].to_s.force_encoding("UTF-8")
      item[4].to_s.force_encoding("UTF-8")
      
      @provice = Region.where(["region_name = ? AND region_type=1", item[2]]).first
      @provice ||= Region.new({:parent_id => 0, :region_name => item[2], :region_type => 1 })

      # @region = Region.new({:parent_id => 0, :region_name => item[2], :region_type => 1 })
      @city = Region.where(["region_name = ? AND region_type=2", item[3]]).first
      @city ||= @provice.children.build({ :region_name => item[3], :region_type => 2})
      
      @dist = Region.where(["region_name = ? AND region_type=3", item[4]]).first
      @dist ||= @city.children.build({ :region_name => item[4], :region_type => 3 })
      
      @provice.save
      ranks << item[0] if item[2].blank? || item[3].blank? || item[4].blank?
    end
    
    open("error_region_items", "w") do |file|
      ranks.each {|r| file << "#{r} \n"}
    end
        
  end
  
  
  ## init_brand
  task :init_brand => :environment do 
    file_name = "brand.csv"
    csv = CSV.read(Rails.root.join('lib', 'tasks', 'data', file_name))
    csv.each do |item|
      puts item[4]
      Brand.create({
        name: item[4],
        url: item[7],
        description: item[6],
        image_url: item[5],
        brand_name_zh: item[1],
        brand_name_en: item[0].delete("\n"),
        car_type_zh: item[2],
        car_type_en: item[3]
        })
      end
    end
    
  ## upload history news
  
  task :init_history_news => :environment do
    file_name = "history_news.csv"
    csv = CSV.read(Rails.root.join('lib', 'tasks', 'data', file_name))
    csv.shift
    
    csv.each_with_index do |i, index|
      i[14] =  i[14] ? "<p align='center'><img src='#{i[14].gsub("..","")}' /></p>" + i[9] : ""
      puts  i[9].to_s.force_encoding("UTF-8")
      info = {
        :title => i[1].to_s.force_encoding("UTF-8"),
        :content => i[14].to_s.force_encoding("UTF-8"),
        :created_at => Time.parse(i[11]),
        :position => index,
        :visit_count => i[10].to_s.force_encoding("UTF-8").to_i
      }
      Refinery::Infos::Info.create(info)
    end
    # @infos = Refinery::Infos::Info.recent
    
  end

end
