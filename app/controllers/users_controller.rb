class UsersController < ApplicationController
  before_filter :logmeout, :only => [:update]

  def update
    @user = current_user

    if @user.update_attributes(params[:user])
      respond_to do |format|
        format.html {redirect_to :back}
        format.js {head :ok}
      end
    else
      render :text => @user.errors.full_messages.join(", "), :status => :unprocessable_entity
    end

  end

  def show
    @user = User.find_by_username(params[:username])
    if @user
      @links = @user.links
    else
      not_found
    end
  end

end
