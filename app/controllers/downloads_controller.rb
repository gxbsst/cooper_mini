# encoding: utf-8
class DownloadsController < ApplicationController
  # before_filter :authenticate
  http_basic_authenticate_with :name => "media.cooper", :password => "cooperchina", :realm => "Cooper"

  def index
    @files = Refinery::Resource.where("media_type = '新闻通稿'")
    @images_poster =  Refinery::Resource.where("media_type = '高清图片' AND image_type = '海报'")
    @images_foldout = Refinery::Resource.where("media_type = '高清图片' AND image_type = '折页'")    
    @movies = Video.where("media_type = '视频'")
  end
end