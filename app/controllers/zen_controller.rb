class ZenController < ApplicationController
  layout "zen", :except => { "logs", "zenlog" }

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :logcomment],
         :redirect_to => { :action => :index }
  
  def index
    @pagetitle = "The home of Indro De"
    unless params[:search].blank?      
      @searchlabel = params[:search].strip
    end

    @posts = Post.search(@searchlabel, params[:page])
    @found = @posts.size
    @current_page = "You are viewing all posts. Showing page #{@posts.current_page.to_s} of #{@posts.total_pages.to_s}. &nbsp; &nbsp; <small>("

    if @found == 0
      @current_page = "Your search query was not found. &nbsp; &nbsp; <small>(<a href=""?page=1&search="">view all entries</a> | "
    elsif !@searchlabel.blank?
      @current_page = "You are viewing search results for <b>#{@searchlabel}</b>. Showing page #{@posts.current_page.to_s} of #{@posts.total_pages.to_s}. &nbsp; &nbsp; <small>(<a href=""?page=1&search="">view all</a> | "
    end
  end
  
  def form
    @blog = Blog.find(params[:id])
    render :layout => 'form'
  end
  
  def logs
    @post = Post.find(params[:id])
    render :layout => 'permanent'
  end

  def zenlog
    @posts = Post.find(:all, :order => 'created_at DESC') 
    render :layout => false
  end
  
  def oops
    # triggered when 404 error is found
    @pagetitle = "Oops! Error 404 - File Not Found"
  end


end