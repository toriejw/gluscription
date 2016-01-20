require 'simplecov'
SimpleCov.start 'rails'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require "rails/test_help"
require "capybara/rails"
require "minitest/pride"

class ActiveSupport::TestCase
  fixtures :all
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
        provider: "facebook",
        uid: "1234",
        info: { first_name: "some_name" },
        credentials: { token: "candy_treats",
                       expires_at: 1010101,
                       expires: "true" } })
  end

  def setup
    Capybara.reset_sessions!
  end

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

  def require_js
    Capybara.current_driver = :selenium
  end
end
