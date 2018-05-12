require 'sinatra'
require 'sinatra/json'
require 'rack/contrib'
require 'sinatra/cross_origin'

require_relative 'graphql/schema'

class ApplicationController < Sinatra::Base
    use Rack::PostBodyContentTypeParser 
    configure do
        enable :cross_origin
    end
    before do
        response.headers['Access-Control-Allow-Origin'] = '*'
    end

    options "*" do
        response.headers["Allow"] = "GET, POST, OPTIONS"
        response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
        response.headers["Access-Control-Allow-Origin"] = "*"
        200
    end

    def query(params)
        TradeCoinAppSchema.execute(
          params[:query],
          variables: params[:variables],
          context: { current_user: nil },
        )
    end
end