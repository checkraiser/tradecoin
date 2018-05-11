ENV['RACK_ENV'] = 'test'
require 'rack/test'
require 'capybara'
require 'capybara/dsl'
require 'test/unit'
require_relative '../app'
module Helper
    include Capybara::DSL
    include Rack::Test::Methods
    Capybara.default_driver = :selenium
    
    def setup
        Capybara.app = TradeCoinApp
    end

    def app
        TradeCoinApp
    end

    def post_json(uri, json)
        post(uri, json, { "CONTENT_TYPE" => "application/json" })
    end
end