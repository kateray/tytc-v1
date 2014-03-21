RailsAdmin.config do |config|
  config.authorize_with do
    unless warden.user.is_god?
      flash[:error] = "You don't have permission to view that page. Please sign in as an admin user"
      redirect_to main_app.root_path
    end
  end
end
