class LinksController < ApplicationController
  before_filter :authenticate_user!, only: :create

  autocomplete :tag, :name

  def index
    if params[:tags]
      tags = Tag.find(params[:tags])
      # @links = Link.order("votes_count DESC")
      @links = Link.order("votes_count DESC").includes(:tags).select{|link| (tags - link.tags).empty?}
    else
      @links = Link.order("votes_count DESC").includes(:tags)
    end
    @link = Link.new
    @comment = Comment.new
    #tktk very bad!
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
    @link = current_user.links.build(link_params)

    if @link.save
      @link.current_user = current_user

      respond_to do |format|
        format.json {render :json => @link}
      end
    else
      render :text => @link.errors.full_messages.join(", "), :status => :unprocessable_entity
    end

  end

  private

  def link_params
    params.require(:link).permit(:url, :description, :title, :votes_count, :comments_count, :taggings_attributes => [:tag_id])
  end

  def get_autocomplete_items(parameters)
    super(parameters).where(:group => params[:group])
  end

end
