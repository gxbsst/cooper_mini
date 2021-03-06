class Api::RegionsController < ApplicationController
  respond_to :json
  layout nil
  
  #######################################################
  ## 中国地区
  #######################################################
  
  def locals
    # type = params[:type]
    parent_id = params[:parent_id]
   # locals = Store.where(:provice => parent_id).group(:city)
    locals = Store.city_collection_by_parent_id(parent_id)
    render :json => locals
  end
  
  def aspect_ratio
    tyre = params[:parent_id]
    products = Product.where( :tyre => tyre ).group(:aspect_ratio)
    render :json => products
  end
  
  def diameter
    aspect_ratio = params[:parent_id]
    
    if params[:parent_type] == 'tyre'
      products = Product.where( :tyre => aspect_ratio ).group(:diameter)
    else
      products = Product.where( :aspect_ratio => aspect_ratio ).group(:diameter)
    end
    
    render :json => products
  end
  
  def car_type
    brand = params[:parent_id]
    brands = Brand.where(:brand_name_zh => brand).group(:car_type_zh).order("CONVERT( car_type_zh USING gbk)")
    render :json => brands
  end
  
  
  # def china_provinces
  #   parent_id = params[:parent_id]
  #   provinces = Region.provinces(parent_id)
  #   render :json => provinces
  # end
  # 
  # def china_cities
  #   parent_id = params[:parent_id]
  #   cities = Region.cities(parent_id)
  #   render :json => cities
  # end
  # 
  # def china_districts
  #    parent_id = params[:parent_id]
  #    districts = Region.districts(parent_id)
  #    render :json => districts
  # end
  # 
  # #######################################################
  # ## 葡萄酒世界产区
  # #######################################################
  # 
  # def region_world
  #   parent_id = params[:parent_id]
  #   regions = Wines::RegionTree.region(parent_id).order("id DESC")
  #   render :json => regions
  # end
    
end
