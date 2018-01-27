Clearance.configure do |config|
  config.mailer_sender = "info@trellish.com"
  config.routes = false
  config.rotate_csrf_on_sign_in = true
end
