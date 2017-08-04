class StaticPagesController < ApplicationController
  def index
  end 
  def about
  end
  def contact
  end
  def landing_page
    @products = Product.limit(3)
    # @featured_product = Product.first
  end
end
