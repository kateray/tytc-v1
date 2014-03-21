class ApplicationController < ActionController::Base
  # protect_from_forgery
  before_filter :configure_permitted_parameters, if: :devise_controller?

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

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:sign_in) << :username
  end

end
