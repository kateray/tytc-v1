class LinksController < ApplicationController
  # caches_action :index

  def index    
    if params[:tags]
      tags = Tag.find(params[:tags])
      # @links = Link.order("votes_count DESC")
      @links = Link.order("votes_count DESC").includes(:tags).select{|link| (tags - link.tags).empty?}
    else
      @links = Link.order("votes_count DESC").includes(:tags)
    end
    if current_user
      @link = Link.new
      @comment = Comment.new
    end
    @links.each{|link|link.current_user = current_user}
    
    respond_to do |format|
      format.html {render}
      format.json {render :json => @links}
    end
    
  end
  
  def show
    @links = Link.find(params[:id])
    if current_user
      @link = Link.new
      @comment = Comment.new
    end

    @links.current_user = current_user
    respond_to do |format|
      format.html {render 'index'}
      format.json {render :json => @links}
    end
  end
  
  def create
    @link = current_user.links.build(params[:link])
    
    if @link.save
      
       # TKTK should be in model, but lang array isn't nested under params[:link]
      params[:taggings].each do |id|
        Tagging.create! do |tagging|
          tagging.link_id = @link.id
          tagging.user_id = @link.user_id
          tagging.tag_id = id
        end
      end
      
      @link.current_user = current_user

      respond_to do |format|
        format.json {render :json => @link}
      end
    else
      render :text => @link.errors.full_messages.join(", "), :status => :unprocessable_entity
    end
    
  end
  
end