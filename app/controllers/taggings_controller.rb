class TaggingsController < ApplicationController
  
  def index
    @tags = Tag.all
    
    respond_to do |format|
      format.html {render}
      format.json {render :json => @tags.map { |link| {:title => link.title, :url => link.url, :description => link.description, :vote_count => link.votes_count, :id => link.id}}}
    end
    
  end
  
  def create
    @tag = Tag.new(params[:tag])
    
    if @tag.save
      respond_to do |format|
        format.json {render :json => {:id => @tag.id}}
      end
    else
      render :text => @tag.errors.full_messages.join(", "), :status => :unprocessable_entity
    end
    
  end
  
end
