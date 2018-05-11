require './app'
require 'rack/graphiql'
map '/graphiql' do
    run Rack::GraphiQL.new(endpoint: '/graphql')
end
map '/' do 
    run TradeCoinApp
end