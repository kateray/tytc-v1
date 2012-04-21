class TagsController < ApplicationController
  
  def create
    @tag = current_user.tags.build(params[:tag])
    
    if @tag.save
      respond_to do |format|
        format.json {render :json => @tag.to_json(:except => [ :user_id, :created_at, :updated_at ])}
      end
    else
      render :text => @tag.errors.full_messages.join(", "), :status => :unprocessable_entity
    end
    
  end
end
