class ArchiveController < ApplicationController
  layout "zen"
  
  def index
    if Post.exists?(params[:id])
    @post = Post.find(params[:id])
    @pagetitle = "Entry #" + @post.id.to_s
    else
      redirect_to :action => 'oops', :controller => 'zen'
    end 
  end
  
end


