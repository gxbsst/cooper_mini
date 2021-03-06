# encoding: utf-8
require 'csv'

namespace :app do

  def parse_spec(spec)
    if ((spec =~ /^(\d+)\/(\d+{2})(R\d+)/) == 0)
      puts "#{spec}"
      [$1, $2, $3]
    elsif ((spec =~ /^(\d.+)(R.+)$/) == 0)
      [$1, nil, $2]
    elsif ((spec =~ /^(LT\d+)\/(\d+{2})(R.+)/) == 0)
      [$1, $2, $3]
    else
      [nil, nil, nil]
    end
  end

  desc "TODO"
  task :init_product => :environment do
    name = []
    file_name = "Mastercraft_Strategy.csv"
    file = Rails.root.join('lib', 'tasks', 'data', file_name)

    csv = CSV.read(file)

    csv.each do |i|
      puts i[0]
      product_item = {
          :decorative => i[0].to_s.force_encoding("UTF-8"),
          :name => i[1].to_s.force_encoding("UTF-8"),
          :image_url => i[2].to_s.force_encoding("UTF-8"),
          :position => i[3].to_s.force_encoding("UTF-8"),
          :rim => i[4].to_s.force_encoding("UTF-8"),
          :speed =>i[5].to_s.force_encoding("UTF-8"),
          :sku => i[6].to_s.force_encoding("UTF-8"),
          :road => i[7].to_s.force_encoding("UTF-8"),
          :manufacture => i[8].to_s.force_encoding("UTF-8"),
          :time => i[9].to_s.force_encoding("UTF-8"),
          :url => i[10].to_s.force_encoding("UTF-8"),
          :tyre => i[11].to_s.force_encoding("UTF-8"),
          :aspect_ratio => i[12].to_s.force_encoding("UTF-8"),
          :diameter => i[13].to_s.force_encoding("UTF-8")
      }
      @product = Product.create(product_item)
    end
  end # end init_products

  desc "TODO"
  task :init_product_suv => :environment do

    file_name = Rails.root.join('lib', 'tasks', 'data', "suv-car.csv")
    csv = CSV.open(file_name, :headers => true)
    # csv = CSV.read(Rails.root.join('lib', 'tasks', 'data', file_name))
    csv.each do |item|
      puts item[4]
      if item[0].present?
        spec = parse_spec(item[2])
        Product.create({   name: item[0],
                           decorative: item[0],
                           url: item[15],
                           image_url: item[14],
                           position: item[7],
                           rim: item[8],
                           speed: item[9],
                           sku: item[10],
                           road: item[11],
                           manufacture: item[12],
                           time: item[13],
                           tyre: spec[0],
                           aspect_ratio: spec[1] ,
                           diameter: spec[2]
                       })
      end
    end
  end


  ## init_brand
  task :init_mcbrand => :environment do
    file_name = "mc.csv"
    csv = CSV.read(Rails.root.join('lib', 'tasks', 'data', file_name))
    csv.each do |item|
      puts item[4]
      Brand.create({
                       name: item[2],
                       url: item[11],
                       image_url: item[3],
                       brand_name_zh: item[0],
                       car_type_zh: item[1],
                       position: item[4],
                       rim: item[5],
                       speed: item[6],
                       sku: item[7],
                       road: item[8],
                       manufacture: item[9],
                       time: item[10]
                   })
    end
  end


  ## 更新描述和图片
  #task :init_store => :environment do
  #file_name = "store.csv"
  #csv = CSV.read(Rails.root.join('lib', 'tasks', 'data', file_name))
  #csv.each do |item|
  ## puts item[0]
  #item[2] =  "" if item[2].nil?
  #item[3] = "" if item[3].nil?
  #item[13] = "Others" if item[13].blank? || item[13] == 'CC'

  ## full_address = ""

  #shop_types = {"CPC" => "嘉车坊", "CTCC" => "替换中心",  "CSS+" => "店招店" ,  "CSS" => "招牌店",  "INDENPENDENT" => "独立授权店" , "OTHERS" => "其他" }

  #if item[13].blank?
  #shop_type = "OTHERS"
  #else
  #shop_type = item[13].upcase
  #end

  #address = item[10] == '0' ?  address = "" : item[10].to_s.force_encoding("UTF-8")

  #Store.create({rank: item[0].to_s.force_encoding("UTF-8"),
  #sale_dist: item[1].to_s.force_encoding("UTF-8"),
  #provice: item[2].to_s.force_encoding("UTF-8"),
  #city: item[3].to_s.force_encoding("UTF-8"),
  #dist: item[4].to_s.force_encoding("UTF-8"),
  #asr: item[5].to_s.force_encoding("UTF-8"),
  #dsr: item[6].to_s.force_encoding("UTF-8"),
  #telephone: item[12].to_s.force_encoding("UTF-8"),
  #retail_code: item[7].to_s.force_encoding("UTF-8"),
  #shop_name: item[8].to_s.force_encoding("UTF-8"),
  #address: address,
  #full_address: (item[2] + item[3] +  shop_types["#{item[13].upcase}"]).to_s.force_encoding("UTF-8"),
  #shop_type: shop_type })
  #end

  #end

  ### 更新店地址经纬度
  #task :update_store_tuge => :environment do
  #Store.all.each do |r|
  #tuge = Geocoder.coordinates(r.address) unless r.address.blank?
  #r.update_attributes(:longitude => tuge[0], :latitude => tuge[1]) unless tuge.blank?
  #end
  #end
  #
  task :init_stores => :environment do
    file_name = "store.csv"
    csv = CSV.read(Rails.root.join('lib', 'tasks', 'data', file_name))
    csv.each do |item|

      Shop.find_or_create_by_shop_name(item[2],
                                       provice: item[0],
                                       city: item[1],
                                       dist: item[2],
                                       # shop_name: item[2],
                                       address: item[3],
                                       full_address: ("#{item[1]}#{item[3]}") )
    end

  end


  ## 更新店地址经纬度
  task :update_store_tuge => :environment do
    Shop.all.each do |r|
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

  task :init_brand_suv => :environment do

    file_name = Rails.root.join('lib', 'tasks', 'data', "suv-car.csv")
    csv = CSV.open(file_name, :headers => true)
    # csv = CSV.read(Rails.root.join('lib', 'tasks', 'data', file_name))
    csv.each do |item|
      puts item[4]
      # binding.pry
      if item[6].present?
        car_array = item[6].split("\n")
        unless item[6].split("\n").join('').include? '改装'
          car_array.each do |car_type|
            bran_name_zh, car_type_zh = car_type.split(':')
            Brand.create({name: item[0],
                          url: item[15],
                          image_url: item[14],
                          brand_name_zh: bran_name_zh.strip,
                          car_type_zh: car_type_zh.strip,
                          position: item[7],
                          rim: item[8],
                          speed: item[9],
                          sku: item[10],
                          road: item[11],
                          manufacture: item[12],
                          time: item[13]})
          end
        end
      end
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
