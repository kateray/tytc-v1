class ApplicationController < ActionController::Base
  # protect_from_forgery

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


  def after_sign_in_path_for(resource)
    root_path
  end

  def not_found
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end



end
