ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)

require 'rails/test_help'
require 'minitest/autorun'
require 'minitest/rails'
require 'minitest/focus'
require 'minitest/colorize'
require 'minitest/rails/capybara'

module Minitest::Expectations
  infect_an_assertion :assert_redirected_to, :must_redirect_to
  infect_an_assertion :assert_template, :must_render_template
  infect_an_assertion :assert_response, :must_response_with
end

class ActiveSupport::TestCase
  include Warden::Test::Helpers

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  fixtures :all

  def self.prepare
    # Add anything that you need before suite starts
  end

  prepare

  def setup
    Warden.test_reset!
    setup_warden
  end

  def request
    @request ||= ActionController::TestRequest.new
  end

  def setup_warden
    @warden ||= begin
      manager = Warden::Manager.new(nil,
        &Rails.application.config.middleware.detect{|m| m.name == 'Warden::Manager'}.block)
        request.env['warden'] = Warden::Proxy.new(@request.env, manager)
     end
  end

  alias_method :warden, :setup_warden

  def login_user(id = 200)
    authorization = Authorization.find id
    warden.set_user authorization, scope: :authorization
  end
end

class Capybara::Rails::TestCase
  def self.prepare
    # Add anything that you need before suite starts
  end

  prepare

  def setup
  end

  def teardown
  end

  def mock_omniauth(uid = '12334', email = 'test@user.com')
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      { 'provider' => 'github', 'uid' => uid,
        'info' => { 'nickname' => 'Test user', 'email' => email }
      }
    )
  end

  def login_user
    visit '/'

    find('.github').click
  end
end
