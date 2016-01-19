require 'simplecov'
SimpleCov.start 'rails'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require "rails/test_help"
require "capybara/rails"
require "minitest/pride"
require "webmock"
require "vcr"

class ActiveSupport::TestCase
  fixtures :all

  VCR.configure do |config|
    config.cassette_library_dir = "test/vcr_cassettes"
    config.hook_into :webmock
    config.ignore_localhost = true
  end
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

  def teardown
    reset_session!
    Capybara.use_default_driver
  end

  def require_js
    Capybara.current_driver = :selenium
  end
end
