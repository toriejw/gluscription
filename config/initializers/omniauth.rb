Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["FACEBOOK_API_KEY"], ENV["FACEBOOK_SECRET_KEY"],
    scope: 'public_profile', info_fields: 'id, first_name'
end
