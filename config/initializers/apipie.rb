Apipie.configure do |config|
  config.app_name                = "ProjectYx"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/apipie"
  config.app_info                = 'ProjectYX JSON API'
  config.validate                = false
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end
