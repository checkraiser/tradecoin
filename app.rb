require_relative 'application_controller'

class TradeCoinApp < ApplicationController
    get '/' do
        File.read(File.join('public', 'index.html'))
    end
    post '/graphql' do
        result = query(params)
        json result
    end
end
