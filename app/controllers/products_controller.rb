# encoding: utf-8
class ProductsController < ApplicationController

  def search
    @product = Product.new
  end

end