require 'sinatra'
require 'sinatra/json'
require 'rack/contrib'
require_relative 'graphql/schema'

class TradeCoinApp < Sinatra::Base
    use Rack::PostBodyContentTypeParser 
   
    post '/graphql' do
        p params
        result = TradeCoinAppSchema.execute(
          params[:query],
          variables: params[:variables],
          context: { current_user: nil },
        )
        json result
      end
end
