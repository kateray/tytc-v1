class UsersController < ApplicationController
  before_filter :logmeout, :only => [:new, :create]

  def new
    @user = User.new
    
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      redirect_to_target_or_default
    else
      flash[:error] = @user.errors.full_messages.join(", ")
      redirect_to :back
    end
  end
  
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
    @links = @user.links
  end
  
end