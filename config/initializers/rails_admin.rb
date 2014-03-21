RailsAdmin.config do |config|
  config.authorize_with do
    flash[:error] = "You don't have permission to view that page. Please sign in as an admin user"
    redirect_to main_app.root_path unless warden.user.is_god?
  end
end
