# encoding: utf-8
class SearchsController < ApplicationController

  def index
    if params[:type] == "brand"
      @products ||= find_brands
    else
      @products ||= find_products  
    end
  end
  
  private 

  def find_products
    tyre = params[:tyre]
    aspect_ratio = params[:aspect_ratio]
    diameter = params[:diameter]
    brand = params[:brand]
    car_type = params[:car_type]
    decorative = params[:decorative]
    
    @products = Product.order(:tyre).group(:name)
    # products = products.where("tyre like ?", "%#{keywords}%") if keywords.present?
    @products = @products.where(tyre: tyre).group(:name) if tyre.present?
    @products = @products.where(aspect_ratio: aspect_ratio).group(:name) if aspect_ratio.present?
    @products = @products.where(diameter: diameter).group(:name) if diameter.present?
    @products = @products.where(brand: brand).group(:name) if brand.present?
    @products = @products.where(car_type: car_type).group(:name) if car_type.present?
    @products = @products.where(decorative: decorative).group(:name) if decorative.present?
    @products
  end
  
  
  def find_brands
    brand = params[:brand]
    car_type = params[:car_type]
    name = params[:name]
    @products = Brand.order(:brand_name_en).group(:name)
    @products = @products.where(brand_name_en: brand).group(:name) if brand.present?
    @products = @products.where(car_type_en: car_type).group(:name) if car_type.present?
    @products = @products.where(name: name).group(:name) if name.present?
    @products
  end

end