require 'graphql'
require_relative 'query'
TradeCoinAppSchema = GraphQL::Schema.define do
  query QueryType
end