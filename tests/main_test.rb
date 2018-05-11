ENV['RACK_ENV'] = 'test'

require_relative '../app'  # <-- your sinatra app
require 'capybara'
require 'capybara/dsl'
require 'test/unit'

class HelloWorldTest < Test::Unit::TestCase
  include Capybara::DSL
  # Capybara.default_driver = :selenium # <-- use Selenium driver

  def setup
    Capybara.app = TradeCoinApp
  end

  def test_it_works
    visit '/'
    assert page.has_content?('Hello World')
  end
end