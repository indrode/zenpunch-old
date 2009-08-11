class GalleryController < ApplicationController
  layout "zen"
  
  def index
    @pagetitle = "Gallery"
    @content = Article.find(:first, :conditions => [ "category = ?", "gallery" ])
  end
   
end