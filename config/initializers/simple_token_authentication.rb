SimpleTokenAuthentication.configure do |config|

  config.sign_in_token = false

  config.header_names = { client: { authentication_token: 'X-Client-Token', email: 'X-Client-Email' } }

  config.skip_devise_trackable = false

end
