class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(params[:comment])
    
    if @comment.save
      respond_to do |format|
        format.json {render :json => @comment.to_json(:methods => [:username, :time], :except => [ :user_id, :created_at, :updated_at ])}
      end
    else
      render :text => @comment.errors.full_messages.join(", "), :status => :unprocessable_entity
    end
    
  end
  
  def index
    if params[:link_id]
      @comments = Comment.where(:link_id => params[:link_id]).order('created_at ASC')
    else
      @comments = Comment.all.order('created_at ASC')
    end
    
    respond_to do |format|
      format.html {render}
      format.json {render :json => @comments.to_json(:methods => [:username, :time], :except => [ :user_id, :created_at, :updated_at ])}
    end
    
  end
end
