class ArchiveController < ApplicationController
  layout "zen", :except => "comment"
  
  def index
    @post = Post.find(params[:id])
    @pagetitle = "Entry #" + @post.id.to_s     
  end
  
end


