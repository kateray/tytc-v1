class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    binding.pry
    # puts '*'*80
    # auth = request.env["omniauth.auth"]
    # binding.pry
    # if current_user
    #   current_user.add_github_login(auth)
    # else
    #   @user = User.github_find_or_create(auth)
    #   sign_in_and_redirect
    # end
    
    # redirect_to_target_or_default
    redirect_to '/'
    
  end
end