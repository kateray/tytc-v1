class UserSessionsController < ApplicationController

  before_filter :logmeout, :only => [:new, :create]
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_to '/'
    else
      flash[:error] = @user_session.errors.full_messages.join(", ")
      redirect_to :back
    end
  end

  def about
    render
  end
  
  def callback
    auth = request.env["omniauth.auth"]
    
    if current_user
      current_user.add_github_login(auth)
    else
      user = User.github_find_or_create(auth)
      UserSession.create(user, true)
    end
    
    redirect_to_target_or_default
    
  end
  
  def destroy
    redirect_to_target_or_default
    current_user_session.destroy
  end
end
