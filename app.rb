require 'sinatra'
require 'sinatra/json'
require 'rack/contrib'
require_relative 'graphql/schema'

class TradeCoinApp < Sinatra::Base
    use Rack::PostBodyContentTypeParser 
    get '/' do
        'It Works!'
    end
    get '/hello.json' do
        message = { success: true, message: 'hello'}
        json message
    end
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
