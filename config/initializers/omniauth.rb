OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '429444913898131', 'c32d1331f183b1eca22887ef1b166ec1', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
end