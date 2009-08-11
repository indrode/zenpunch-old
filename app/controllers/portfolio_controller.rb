class PortfolioController < ApplicationController
  layout "zen"
  
  def index
    @pagetitle = "Portfolio"
    @content = Article.find(:first, :conditions => [ "category = ?", "portfolio" ])
    @total = Project.count(:conditions => "displaynote = '1'")
    @prodnotes = Project.find(:all, :order => 'title') 
  end

  def projects
    @total = Project.count(:conditions => "displaynote = '1'")
    @singlenote = Project.find(params[:id])
    @label = @singlenote.title
    @pagetitle = "Portfolio - " + @label
  end
  
end