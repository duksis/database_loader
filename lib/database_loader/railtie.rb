module DatabaseLoader
  class Railtie < Rails::Railtie
    rake_tasks do
      custom_config_file = "#{Rails.root}/config/initializers/database_loader.rb"
      require custom_config_file if File.exists?(custom_config_file)
      DatabaseLoader.set_schemas
      require "database_loader/tasks"
    end
  end
end
