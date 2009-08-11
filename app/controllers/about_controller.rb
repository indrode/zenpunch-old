class AboutController < ApplicationController
  layout "zen"
  
  def index
    @pagetitle = "About"
    @content = Article.find(:first, :conditions => [ "category = ?", "about" ])
    @websites = Website.find(:all, :order => 'sortorder')
  end
   
  def sitemap
    @pagetitle = "Sitemap"  
  end
  
end
