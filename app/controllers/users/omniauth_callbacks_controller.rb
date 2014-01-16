class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def github
    auth = request.env["omniauth.auth"]

    if current_user
      current_user.add_github_login(auth)
    else
      @user = User.github_find_or_create(auth)
      if @user.persisted?
        sign_in_and_redirect @user, :event => :authentication
        set_flash_message(:notice, :success, :kind => "Github") if is_navigational_format?
      else
        session["devise.github_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    end

  end

end