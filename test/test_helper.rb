require 'simplecov'
SimpleCov.start 'rails'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "capybara/rails"
require "minitest/pride"

class ActiveSupport::TestCase
  fixtures :all

end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
end
