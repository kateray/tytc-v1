class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user_session, :current_user, :store_location
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end
  
  def store_location
    session[:return_to] = request.path
  end
  
  def redirect_to_target_or_default
    if session[:return_to]
      redirect_to session[:return_to]
      session[:return_to] = nil
    else
      redirect_to "/"
    end
  end

  def logmeout
    if current_user
      current_user_session.destroy
      # redirect_to :back
    end
  end
  
end
