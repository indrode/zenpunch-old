class ArchiveController < ApplicationController
  layout "zen", :except => "comment"
  
  def index
    @post = Post.find(params[:id])
    @blogcomments = @post.logcomments
    @pagetitle = "Entry #" + @post.id.to_s
     
  end

  def comment        
    @comment = Post.find(params[:id]).logcomments.create(params[:comment])
    @blogcomments = Post.find(params[:id]).comments
       
    if @comment.save
      flash[:notice] = "Your comment has been successfully added! Thank you!"
    else
      flash[:notice] = "There were errors! Please try again."
    end
      
    respond_to do |format|
      format.html { redirect_to :action => "index", :id => params[:id] }
      format.js
    end
    
  end
  
end


