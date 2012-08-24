class ApplicationController < ActionController::Base
  protect_from_forgery
 
   before_filter :set_locale

  def index
    
  end

  def set_locale
   params[:locale] = "zh-CN"
    I18n.locale = params[:locale] || I18n.default_locale
  end
  
end
