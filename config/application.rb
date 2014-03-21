require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module Tytc
  class Application < Rails::Application
    config.assets.precompile += ['rails_admin/rails_admin.css', 'rails_admin/rails_admin.js']
  end
end
